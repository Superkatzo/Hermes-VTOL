#!/bin/bash
# ============================================================
# Hermes-VPS Connectivity-Check
# Prueft Netzwerk-Konnektivitaet der wichtigsten Endpoints
# ============================================================
# Wird alle 60 Minuten via Cron ausgefuehrt (separater Job)
# Alerts via telegram_alert.sh
# ============================================================

ALERT="/home/hermes/telegram_alert.sh"
LOG="/home/hermes/hermes/logs/connectivity.log"
mkdir -p "$(dirname "$LOG")"

echo "[$(date)] Connectivity-Check gestartet" >> "$LOG"

# BUGFIX (2026-09-24):
# - api.minimax.io ohne Pfad gibt 404 -> richtige URL ist api.minimax.io/anthropic
# - Auch testen mit HEAD statt GET (schneller, weniger Traffic)
CHECKS=(
    "http://127.0.0.1:4860|Hermes intern (Port 4860)"
    "https://api.telegram.org|Telegram Bot-API"
    "https://github.com|GitHub (fuer Push/Pull)"
    "https://api.minimax.io/anthropic|MiniMax Provider (Anthropic-Endpoint)"
)

for entry in "${CHECKS[@]}"; do
    url=$(echo "$entry" | cut -d'|' -f1)
    desc=$(echo "$entry" | cut -d'|' -f2)

    # HEAD-Request ist schneller und bandbreiten-sparender
    http_code=$(curl -sk -o /dev/null -w '%{http_code}' --max-time 10 -X HEAD "$url" 2>/dev/null)

    # Fallback: GET wenn HEAD nicht 2xx/3xx (manche APIs antworten nicht auf HEAD)
    if [[ ! "$http_code" =~ ^[23] ]]; then
        http_code=$(curl -sk -o /dev/null -w '%{http_code}' --max-time 10 "$url" 2>/dev/null)
    fi

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
