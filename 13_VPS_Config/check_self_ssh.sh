#!/bin/bash
# Prueft ob der VPS selbst von aussen erreichbar ist (via SSH)
# Wichtig fuer Remote-Zugang vom PC/Laptop
ALERT="/home/hermes/telegram_alert.sh"
LOG="/home/hermes/hermes/logs/self_health.log"

# Teste SSH-Daemon lokal
if ! systemctl is-active --quiet ssh 2>/dev/null && ! pgrep -x sshd > /dev/null; then
    "$ALERT" "CRITICAL" "SSH-Daemon down!" "VPS: $HOSTNAME
sshd laeuft NICHT.
Kein Remote-Zugriff mehr moeglich!
Dringend pruefen!" > /dev/null
    echo "[$(date)] SSH-DAEMON DOWN" >> "$LOG"
else
    echo "[$(date)] SSH-Daemon OK" >> "$LOG"
fi

# Teste Hermes-API lokal
if curl -s -o /dev/null -w '%{http_code}' --max-time 5 http://127.0.0.1:4860/health 2>/dev/null | grep -qE '^2|^3'; then
    echo "[$(date)] Hermes-API OK" >> "$LOG"
else
    HEALTH_CHECK=$(sudo -S -p '' docker exec hermes-agent-ekgx-hermes-agent-1 bash -c '/opt/hermes/.venv/bin/hermes doctor 2>&1' | head -20)
    "$ALERT" "WARN" "Hermes-API ungesund" "VPS: $HOSTNAME
Container laeuft, aber Health-Check fehlgeschlagen.
Letzte doctor-Ausgabe:
${HEALTH_CHECK}" > /dev/null
    echo "[$(date)] Hermes-API unhealthy" >> "$LOG"
fi
