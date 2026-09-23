#!/bin/bash
# Telegram-Alert-Skript - wiederverwendbar
SEVERITY="$1"
TITLE="$2"
BODY="$3"

if [ -z "$TITLE" ] || [ -z "$BODY" ]; then
    echo "Usage: $0 SEVERITY TITLE BODY"
    exit 1
fi

TIMESTAMP=$(date +'%Y-%m-%d %H:%M:%S %Z')
TELEGRAM_BOT_TOKEN=$(sudo -S -p '' docker exec hermes-agent-ekgx-hermes-agent-1 bash -c 'grep ^TELEGRAM_BOT_TOKEN /opt/data/.env | cut -d= -f2' 2>/dev/null | tr -d "'"'\''\r')
CHAT_ID="858968389"

MESSAGE="${SEVERITY} *${TITLE}*
🕐 ${TIMESTAMP}

${BODY}

VPS Hermes-Monitor"

URL="https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendMessage"
curl -s -X POST "$URL" \
    -d chat_id="$CHAT_ID" \
    -d parse_mode="Markdown" \
    -d text="$MESSAGE" > /dev/null

if [ $? -eq 0 ]; then
    echo "[${TIMESTAMP}] Alert gesendet: ${TITLE}"
else
    echo "[${TIMESTAMP}] Alert FEHLGESCHLAGEN: ${TITLE}" >&2
    exit 1
fi
