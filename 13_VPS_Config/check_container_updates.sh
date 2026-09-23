#!/bin/bash
# Container-Update-Check mit Telegram-Alert
ALERT="/home/hermes/telegram_alert.sh"
LOG="/home/hermes/hermes/logs/updates.log"

echo "[$(date)] Update-Check gestartet" >> "$LOG"

UPDATES=""
for c in $(sudo -S -p '' docker ps --format '{{.Names}}'); do
    IMAGE=$(sudo -S -p '' docker inspect -f '{{.Config.Image}}' "$c" 2>/dev/null)
    if [ -z "$IMAGE" ]; then continue; fi
    
    # Versuche update-check
    RESULT=$(sudo -S -p '' docker pull "$IMAGE" 2>&1)
    if echo "$RESULT" | grep -q "Status: Image is up to date"; then
        # OK
        :
    elif echo "$RESULT" | grep -q "Downloaded\|Pulling"; then
        UPDATES="${UPDATES}${IMAGE}, "
    fi
done

if [ -n "$UPDATES" ]; then
    "$ALERT" "WARN" "Container-Updates verfügbar" "Diese Images haben neue Versionen:
${UPDATES}
Manuell prüfen mit 'docker ps' und ggf. updaten." > /dev/null
    echo "[$(date)] Updates gefunden: $UPDATES" >> "$LOG"
else
    echo "[$(date)] Alle Container aktuell" >> "$LOG"
fi
