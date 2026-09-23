#!/bin/bash
# Prueft Netzwerk-Konnektivitaet der wichtigsten Endpoints
ALERT="/home/hermes/telegram_alert.sh"
LOG="/home/hermes/hermes/logs/connectivity.log"
echo "[$(date)] Connectivity-Check gestartet" >> "$LOG"

CHECKS=(
    "http://127.0.0.1:4860|Hermes intern (Port 4860)"
    "https://api.telegram.org|Telegram Bot-API"
    "https://github.com|GitHub (fuer Push/Pull)"
    "https://api.minimax.io|MiniMax (falls aktiv)"
)

for entry in "${CHECKS[@]}"; do
    url=$(echo "$entry" | cut -d'|' -f1)
    desc=$(echo "$entry" | cut -d'|' -f2)
    
    http_code=$(curl -sk -o /dev/null -w '%{http_code}' --max-time 10 "$url" 2>/dev/null)
    
    case "$http_code" in
        2*|3*)
            echo "[$(date)] OK: $desc -> $http_code" >> "$LOG"
            ;;
        *)
            "$ALERT" "WARN" "Connectivity-Problem" "Endpoint: ${desc}
URL: ${url}
HTTP-Code: ${http_code}

Moeglicherweise Netzwerk-Problem oder Service down." > /dev/null
            echo "[$(date)] FAIL: $desc -> $http_code" >> "$LOG"
            ;;
    esac
done

echo "[$(date)] Connectivity-Check abgeschlossen" >> "$LOG"
