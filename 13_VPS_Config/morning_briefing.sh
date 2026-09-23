#!/bin/bash
# Morgen-Briefing — sendet Nachricht via Hermes-Telegram-Bot
# Cron: 0 8 * * 1-7  (täglich um 10:00 Uhr MESZ = 08:00 UTC, Mo-So)
#
# Voraussetzung:
# - VPS-Container hermes-agent-ekgx läuft
# - .env enthält TELEGRAM_BOT_TOKEN
# - User hat /start mit dem Bot gemacht (Allowed-User-Status)
#
# Vorlage für VPS-Logs /tmp/crontab.backup.YYYYMMDD-HHMM

TIMESTAMP=$(date +'%Y-%m-%d %H:%M %Z')
MESSAGE="🌅 *Guten Morgen, willow!*

📅 *${TIMESTAMP}*

🚀 *Was steht heute an:*
• CAD-Phase startet — Fusion 360 auf, Charakteristika prüfen
• Lastenheft und ConOps-Vorlage als Referenz offen lassen
• Regulatorik bei Bedarf (Klassen-Walk, SORA-OSOs)
• Telegram steht 24/7 auf diesem VPS — frag mich was du brauchst

📊 *Tagesziele (Vorschlag):*
1. Eine CAD-Komponente sauber durchkonstruieren (z.B. Holm oder Rippe)
2. Einen kurzen Post-Mortem der gestrigen Arbeit
3. Eine Frage zur nächsten Komponente klären

💡 *Tipp:* Ich bin ab jetzt erreichbar — nutze mich als CAD-Sparring-Partner.

— Dein testbot auf Hostinger VPS"

# Lese Telegram-Token aus dem Hermes-Container
TELEGRAM_BOT_TOKEN=$(sudo docker exec hermes-agent-ekgx-hermes-agent-1 bash -c 'grep ^TELEGRAM_BOT_TOKEN /opt/data/.env | cut -d= -f2' 2>/dev/null | tr -d '\r')

if [ -z "$TELEGRAM_BOT_TOKEN" ]; then
    echo "[ERROR] Kein TELEGRAM_BOT_TOKEN gefunden"
    exit 1
fi

# Sende via direkter Telegram-Bot-API
CHAT_ID="858968389"  # TELEGRAM_HOME_CHANNEL aus .env
URL="https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendMessage"

curl -s -X POST "$URL" \
    -d chat_id="$CHAT_ID" \
    -d parse_mode="Markdown" \
    -d text="$MESSAGE" > /dev/null

if [ $? -eq 0 ]; then
    echo "[${TIMESTAMP}] Morning-Briefing gesendet"
else
    echo "[${TIMESTAMP}] Morning-Briefing FEHLGESCHLAGEN"
    exit 1
fi
