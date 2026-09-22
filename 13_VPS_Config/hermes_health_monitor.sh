#!/bin/bash
# ============================================================
# Hermes-VPS Health-Check (Production)
# Wird alle 60 Minuten via Cron ausgeführt
# ============================================================

TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
LOG_FILE="$HOME/hermes/logs/health.log"
ALERT_FILE="$HOME/hermes/logs/alert.log"

mkdir -p "$(dirname "$LOG_FILE")"

log() {
    echo "[$TIMESTAMP] $1" >> "$LOG_FILE"
}

alert() {
    echo "[$TIMESTAMP] ⚠️ $1" >> "$ALERT_FILE"
    echo "[$TIMESTAMP] ⚠️ $1" >&2
}

# === Disk-Auslastung ===
DISK_USAGE=$(df / | tail -1 | awk '{print $5}' | sed 's/%//')
if [ "$DISK_USAGE" -gt 90 ]; then
    alert "Disk-Auslastung kritisch: ${DISK_USAGE}%"
elif [ "$DISK_USAGE" -gt 80 ]; then
    log "Disk-Auslastung hoch: ${DISK_USAGE}%"
fi

# === RAM-Auslastung ===
RAM_USAGE=$(free | grep Mem | awk '{printf "%.0f", ($3/$2)*100}')
if [ "$RAM_USAGE" -gt 90 ]; then
    alert "RAM-Auslastung kritisch: ${RAM_USAGE}%"
elif [ "$RAM_USAGE" -gt 80 ]; then
    log "RAM-Auslastung hoch: ${RAM_USAGE}%"
fi

# === Hermes-Container-Status ===
CONTAINER_STATUS=$(sudo docker inspect hermes-agent-ekgx-hermes-agent-1 --format '{{.State.Status}}' 2>/dev/null)
if [ "$CONTAINER_STATUS" != "running" ]; then
    alert "Hermes-Container NICHT running (Status: ${CONTAINER_STATUS})"
    log "Versuche Container-Restart..."
    sudo docker restart hermes-agent-ekgx-hermes-agent-1 2>&1 >> "$ALERT_FILE"
fi

# === Traefik-Container-Status ===
TRAEFIK_STATUS=$(sudo docker inspect traefik-traefik-1 --format '{{.State.Status}}' 2>/dev/null)
if [ "$TRAEFIK_STATUS" != "running" ]; then
    alert "Traefik-Container NICHT running (Status: ${TRAEFIK_STATUS})"
fi

# === SSH-Login-Failures (letzte Stunde) ===
FAIL_COUNT=$(sudo journalctl -u ssh --since "1 hour ago" 2>/dev/null | grep -c "Failed password" || echo 0)
if [ "$FAIL_COUNT" -gt 10 ]; then
    alert "Viele fehlgeschlagene SSH-Logins: ${FAIL_COUNT} in letzter Stunde"
fi

# === Disk-I/O-Probleme (I/O wait hoch) ===
IO_WAIT=$(top -bn1 | grep "Cpu" | awk -F'wa,' '{split($2,a," "); print a[1]}' | sed 's/%//')
IO_WAIT=${IO_WAIT:-0}
if [ "${IO_WAIT%.*}" -gt 30 ]; then
    log "Hoher I/O-Wait: ${IO_WAIT}%"
fi

# === Cleanup alte Logs (behalte 30 Tage) ===
find "$HOME/hermes/logs" -name "*.log" -mtime +30 -delete 2>/dev/null

# === Erfolgreich geloggt ===
log "Health-Check OK (Disk: ${DISK_USAGE}%, RAM: ${RAM_USAGE}%, Container: ${CONTAINER_STATUS})"
