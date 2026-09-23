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
"""

import os
import re
import subprocess
import logging
import sys
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
    token = get_token()
    log.info("Sidecar startet mit Token-Laenge=%d", len(token))

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
