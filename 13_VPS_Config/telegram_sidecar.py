#!/usr/bin/env python3
"""
Hermes-Telegram-Sidecar: kleiner Telegram-Bot, der nur "speichere X"-Messages
an den telegram_to_github.sh weiterleitet.

Dieser Sidecar laeuft PARALLEL zum offiziellen Hermes-Telegram-Bot und nutzt
den GLEICHEN Token. WICHTIG: der offizielle Bot muss temporaer gestoppt werden,
sonst gibt es Polling-Konflikte (siehe Memory).

Verwendung:
   1. Token in /opt/data/.env des Containers als TELEGRAM_BOT_TOKEN vorhanden
   2. python-telegram-bot installiert (im Container bereits vorhanden)
   3. systemd-Service: /etc/systemd/system/hermes-telegram-sidecar.service
   4. Start: systemctl enable --now hermes-telegram-sidecar

Erkannte Commands (case-insensitive):
   speichere <text>       -> fuegt Todo-Eintrag zur Chronik hinzu
   job #<n>: <text>       -> fuegt Todo-Eintrag zur Chronik hinzu
   save <text>            -> englische Variante
   todo: <text>           -> Kurzform
   /status                -> zeigt aktuelle Cronjobs (Bonus)

WICHTIG (Konflikt-Praevention):
   Der Sidecar fuehrt vor dem Start einen HEALTH-CHECK durch, der erkennt ob
   der Hauptbot-Polling aktiv ist. Falls ja, wird der Sidecar mit Warnung
   blockiert (oder startet mit --force trotzdem).
"""

import os
import re
import subprocess
import logging
import sys
import argparse
from pathlib import Path

try:
    from telegram import Update
    from telegram.ext import Application, CommandHandler, MessageHandler, filters, ContextTypes
except ImportError:
    print("FEHLER: python-telegram-bot nicht installiert.")
    print("Installation: pip install python-telegram-bot")
    sys.exit(1)

# --- Konfiguration ---
CONTAINER_ENV = "/opt/data/.env"
SCRIPT_PATH = "/home/hermes/telegram_to_github.sh"
LOG_FILE = "/home/hermes/logs/telegram_sidecar.log"

# --- Logging ---
logging.basicConfig(
    format="%(asctime)s [%(levelname)s] %(message)s",
    level=logging.INFO,
    handlers=[
        logging.FileHandler(LOG_FILE),
        logging.StreamHandler(sys.stdout),
    ],
)
log = logging.getLogger("hermes-sidecar")

# --- Token aus Container-.env holen ---
def get_token():
    """Liest TELEGRAM_BOT_TOKEN live aus dem Container-Environment."""
    try:
        result = subprocess.run(
            ["sudo", "docker", "exec", "hermes-agent-ekgx-hermes-agent-1",
             "bash", "-c", f"grep ^TELEGRAM_BOT_TOKEN {CONTAINER_ENV} | cut -d= -f2"],
            capture_output=True, text=True, timeout=10
        )
        token = result.stdout.strip().replace("\r", "")
        if not token:
            log.error("TELEGRAM_BOT_TOKEN nicht gefunden in %s", CONTAINER_ENV)
            sys.exit(1)
        return token
    except Exception as e:
        log.exception("Fehler beim Token-Laden: %s", e)
        sys.exit(1)


# --- Health-Check: Hauptbot-Polling erkennen ---
def check_hauptbot_polling(token: str) -> dict:
    """
    Prueft via Telegram-API ob der Hauptbot aktiv pollt ODER auf Webhook laeuft.

    Logik:
    1. getWebhookInfo: Wenn URL gesetzt -> Webhook-Modus -> Sidecar darf pollen
    2. Wenn kein Webhook: getUpdates mit timeout=0, allowed_updates=[]
       - Wenn 409 Conflict zurueckkommt -> Hauptbot pollt aktiv -> KONFLIKT
       - Wenn ok=true zurueckkommt -> kein Hauptbot aktiv -> OK
       - Wenn anderes Ergebnis -> vorsichtig sein

    WICHTIG: getUpdates mit timeout=0 ist NICHT blockierend (vs. timeout>0).
    Wir loesen KEINEN weiteren Konflikt aus, weil Telegram-API hier keine Session haelt.
    """
    import requests

    base = f"https://api.telegram.org/bot{token}"

    try:
        # 1. Webhook-Info holen
        wh_resp = requests.get(f"{base}/getWebhookInfo", timeout=5).json()
        webhook_url = wh_resp.get("result", {}).get("url", "")
        pending_updates = wh_resp.get("result", {}).get("pending_update_count", 0)

        if webhook_url:
            log.info("Webhook aktiv: %s (pending_updates=%d) -> Sidecar kann pollen",
                     webhook_url, pending_updates)
            return {"safe": True, "reason": "webhook_active", "webhook_url": webhook_url}

        # 2. Kein Webhook -> pruefen ob Hauptbot aktiv pollt
        #    Mit timeout=0 (non-blocking) und limit=1
        gu_resp = requests.post(
            f"{base}/getUpdates",
            json={"timeout": 0, "limit": 1, "allowed_updates": []},
            timeout=5
        ).json()

        if not gu_resp.get("ok"):
            error_code = gu_resp.get("error_code", 0)
            description = gu_resp.get("description", "")

            # 409 = Conflict (Hauptbot pollt aktiv)
            if error_code == 409 or "Conflict" in description:
                log.warning("HAUPTBOT POLLT AKTIV! Konflikt erkannt.")
                log.warning("Loesung: Hauptbot auf Webhook umstellen ODER Container-Hauptbot stoppen")
                return {
                    "safe": False,
                    "reason": "hauptbot_polling_active",
                    "error": description
                }
            else:
                # Anderer Fehler -> sicherheitshalber blockieren
                log.warning("Unbekannter getUpdates-Fehler: %s", description)
                return {
                    "safe": False,
                    "reason": "unknown_error",
                    "error": description
                }

        # ok=true: kein Konflikt, aber wir wissen nicht ob Hauptbot gerade aktiv ist
        # (getUpdates mit timeout=0 blockiert nicht, andere Poller koennten trotzdem existieren)
        # Zusatz-Check: Container-hauptbot laeuft?
        hauptbot_laeuft = _check_hauptbot_docker()
        if hauptbot_laeuft:
            log.warning("Container-Hauptbot laeuft (kein Webhook, aber Docker-Prozess aktiv)")
            log.warning("Wahrscheinlich Polling-Konflikt. --force noetig oder Hauptbot stoppen.")
            return {
                "safe": False,
                "reason": "hauptbot_docker_active",
                "error": "Container-Hauptbot laeuft ohne Webhook -> wahrscheinlich Polling-Konflikt"
            }

        log.info("Kein Hauptbot-Polling erkannt -> Sidecar kann starten")
        return {"safe": True, "reason": "no_hauptbot_active"}

    except requests.RequestException as e:
        log.exception("Health-Check fehlgeschlagen (Netzwerkfehler): %s", e)
        # Im Netzwerkfehler-Fall: konservativ blockieren
        return {
            "safe": False,
            "reason": "network_error",
            "error": str(e)
        }


def _check_hauptbot_docker() -> bool:
    """Prueft ob der Hermes-Container-Hauptbot-Prozess laeuft."""
    try:
        result = subprocess.run(
            ["sudo", "docker", "exec", "hermes-agent-ekgx-hermes-agent-1",
             "bash", "-c", "ps -ef | grep 'hermes gateway' | grep -v grep"],
            capture_output=True, text=True, timeout=5
        )
        return "hermes gateway" in result.stdout
    except Exception as e:
        log.debug("Docker-Check fehlgeschlagen: %s", e)
        return False


# --- Erkannte Trigger-Patterns ---
TRIGGER_PATTERNS = [
    re.compile(r"^(?:speichere?|save)\s+(.+)$", re.IGNORECASE),
    re.compile(r"^(?:job|task)\s*#?\d*[:\s]+(.+)$", re.IGNORECASE),
    re.compile(r"^todo[:\s]+(.+)$", re.IGNORECASE),
]


def extract_todo_text(message_text: str) -> str | None:
    """Versucht, einen Todo-Text aus der Message zu extrahieren. Gibt None zurueck wenn kein Trigger matched."""
    for pattern in TRIGGER_PATTERNS:
        m = pattern.match(message_text.strip())
        if m:
            return m.group(1).strip()
    return None


async def handle_message(update: Update, context: ContextTypes.DEFAULT_TYPE):
    """Verarbeitet normale Text-Messages."""
    if not update.message or not update.message.text:
        return
    text = update.message.text.strip()
    log.info("Message von User %s: %s", update.effective_user.id, text[:80])

    todo_text = extract_todo_text(text)
    if not todo_text:
        return  # Kein Trigger — ignorieren (offizieller Bot handled das via normalen Chat)

    # Triggere den Connector
    try:
        result = subprocess.run(
            ["sudo", "-u", "hermes", SCRIPT_PATH, "--text", todo_text],
            capture_output=True, text=True, timeout=30
        )
        if result.returncode == 0:
            log.info("Todo gepusht: %s", todo_text[:80])
            await update.message.reply_text(
                f"✅ Gespeichert:\n\n_{todo_text}_\n\n"
                f"Commit gepusht zu GitHub: Superkatzo/Hermes-VTOL",
                parse_mode="Markdown"
            )
        else:
            log.error("Push fehlgeschlagen: rc=%s stderr=%s", result.returncode, result.stderr[:300])
            await update.message.reply_text(
                f"❌ Fehler beim Push:\n{result.stderr[:300]}"
            )
    except subprocess.TimeoutExpired:
        log.error("Timeout beim Push")
        await update.message.reply_text("❌ Timeout — der Connector hat zu lange gebraucht.")
    except Exception as e:
        log.exception("Unerwarteter Fehler: %s", e)
        await update.message.reply_text(f"❌ Unerwarteter Fehler:\n{e}")


async def cmd_status(update: Update, context: ContextTypes.DEFAULT_TYPE):
    """Bonus: zeigt die aktiven VPS-Cronjobs."""
    try:
        result = subprocess.run(
            ["sudo", "crontab", "-u", "hermes", "-l"],
            capture_output=True, text=True, timeout=10
        )
        cron = result.stdout.strip()
        await update.message.reply_text(
            f"📅 *Aktive VPS-Cronjobs:*\n\n```\n{cron}\n```",
            parse_mode="Markdown"
        )
    except Exception as e:
        await update.message.reply_text(f"Fehler: {e}")


async def cmd_help(update: Update, context: ContextTypes.DEFAULT_TYPE):
    """Hilfe-Command."""
    help_text = (
        "🤖 *Hermes-Telegram-Sidecar*\n\n"
        "*Erkannte Trigger:*\n"
        "• `speichere <text>` — fügt Todo-Eintrag hinzu\n"
        "• `save <text>` — englische Variante\n"
        "• `job #N: <text>` — mit Job-Nummer\n"
        "• `todo: <text>` — Kurzform\n\n"
        "*Befehle:*\n"
        "• `/status` — zeigt aktive Cronjobs\n"
        "• `/help` — diese Hilfe\n\n"
        "_Andere Messages werden ignoriert (der offizielle Hermes-Bot handled den normalen Chat)._"
    )
    await update.message.reply_text(help_text, parse_mode="Markdown")


async def cmd_start(update: Update, context: ContextTypes.DEFAULT_TYPE):
    """/start — begruesst den User."""
    await cmd_help(update, context)


def main():
    # Argparse fuer --force
    parser = argparse.ArgumentParser(description="Hermes Telegram Sidecar")
    parser.add_argument("--force", action="store_true",
                        help="Startet Sidecar auch wenn Hauptbot-Polling erkannt wird")
    args = parser.parse_args()

    token = get_token()
    log.info("Sidecar startet mit Token-Laenge=%d", len(token))

    # Health-Check: Kollision mit Hauptbot-Polling verhindern
    health = check_hauptbot_polling(token)
    if not health["safe"]:
        log.warning("=" * 60)
        log.warning("HEALTH-CHECK WARNUNG: Hauptbot-Polling wahrscheinlich aktiv!")
        log.warning("Grund: %s", health["reason"])
        if health.get("error"):
            log.warning("Detail: %s", health["error"])
        log.warning("=" * 60)
        if not args.force:
            log.error("Sidecar wird NICHT gestartet. Verwende --force zum Erzwingen.")
            log.error("Bessere Loesung: Hauptbot auf Webhook umstellen (siehe Protokoll).")
            sys.exit(1)
        else:
            log.warning("--force aktiv: Sidecar startet trotzdem. Hauptbot-Bot ist gestoert!")
    else:
        log.info("Health-Check OK (%s) -> Sidecar kann starten", health["reason"])

    app = Application.builder().token(token).build()

    # Handler
    app.add_handler(CommandHandler("start", cmd_start))
    app.add_handler(CommandHandler("help", cmd_help))
    app.add_handler(CommandHandler("status", cmd_status))
    app.add_handler(MessageHandler(filters.TEXT & ~filters.COMMAND, handle_message))

    log.info("Bot laeuft (polling). Druecke Ctrl+C zum Stoppen.")
    app.run_polling(allowed_updates=["message"])


if __name__ == "__main__":
    main()
