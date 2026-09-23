#!/bin/bash
# Container-Restart-Detector
ALERT="/home/hermes/telegram_alert.sh"
LOG="/home/hermes/hermes/logs/container_health.log"
echo "[$(date)] Container-Health gestartet" >> "$LOG"

WARN_RESTARTS=3

CONTAINERS=$(sudo -S -p '' docker ps --format '{{.Names}}')
for c in $CONTAINERS; do
    RESTARTS=$(sudo -S -p '' docker inspect -f '{{.RestartCount}}' "$c" 2>/dev/null)
    if [ -n "$RESTARTS" ] && [ "$RESTARTS" -gt "$WARN_RESTARTS" ]; then
        STATE=$(sudo -S -p '' docker inspect -f '{{.State.Status}}' "$c" 2>/dev/null)
        if [ "$STATE" = "running" ] && [ "$RESTARTS" -gt "$WARN_RESTARTS" ]; then
            "$ALERT" "WARN" "Container-Restarts: $c" "Container: ${c}
Anzahl Restarts: ${RESTARTS}
Status: ${STATE}
Letzter Neustart: $(sudo docker inspect -f '{{.State.StartedAt}}' "$c" 2>/dev/null)
Moeglicherweise instabil." > /dev/null
        fi
    fi
    
    if [ "$STATE" != "running" ]; then
        "$ALERT" "CRITICAL" "Container DOWN: $c" "Container: ${c}
Status: ${STATE}
Manuell prüfen: docker logs $c" > /dev/null
    fi
done

echo "[$(date)] Container-Health abgeschlossen" >> "$LOG"
