#!/bin/bash
# VPS-Monitoring mit Telegram-Alerts
# Prüft alle kritischen Services und System-Resourcen
# Cron: alle 15 Minuten
ALERT="/home/hermes/telegram_alert.sh"
LOG_FILE="/home/hermes/hermes/logs/monitor.log"
HOSTNAME=$(hostname)
ISSUES=""

log_msg() { echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"; }

check_container() {
    local container_name="$1"
    local status=$(sudo -S -p '' docker inspect -f '{{.State.Running}}' "$container_name" 2>/dev/null)
    if [ "$status" != "true" ]; then
        ISSUES="${ISSUES}\n- Container '$container_name' ist NICHT laufend"
    fi
}

check_disk() {
    local usage=$(df / | tail -1 | awk '{print $5}' | sed 's/%//')
    if [ "$usage" -gt 85 ]; then
        ISSUES="${ISSUES}\n- Disk-Belegung: ${usage}% (Schwelle 85%)"
    fi
}

check_memory() {
    local mem_used=$(free | grep Mem | awk '{printf "%.0f", $3/$2 * 100}')
    if [ "$mem_used" -gt 90 ]; then
        ISSUES="${ISSUES}\n- RAM-Belegung: ${mem_used}% (Schwelle 90%)"
    fi
}

check_load() {
    local load=$(uptime | grep -oE 'load average: [0-9.]+' | awk '{print $3}')
    local cores=$(nproc)
    local load_int=$(echo "$load" | awk '{print int($1)}')
    if [ "$load_int" -gt "$((cores * 2))" ]; then
        ISSUES="${ISSUES}\n- Load-Average: ${load} (mehr als 2x Cores ${cores})"
    fi
}

check_failed_logins() {
    local failed=$(sudo -S -p '' grep -c "Failed password" /var/log/auth.log 2>/dev/null || echo "0")
    if [ "$failed" -gt 10 ]; then
        ISSUES="${ISSUES}\n- SSH Failed-Password in auth.log: ${failed}x (Schwelle 10)"
    fi
}

# Tests durchführen
check_container "hermes-agent-ekgx-hermes-agent-1"
check_container "traefik-traefik-1"
check_disk
check_memory
check_load
check_failed_logins

if [ -n "$ISSUES" ]; then
    BODY="Host: ${HOSTNAME}
Folgende Probleme erkannt:${ISSUES}

Aktion erforderlich: Bitte manuell prüfen."
    "$ALERT" "WARN" "VPS-Monitor: Probleme erkannt" "$BODY" 2>/dev/null
    log_msg "Probleme gemeldet"
else
    log_msg "Alles OK"
fi
