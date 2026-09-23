#!/bin/bash
# Hermes-Backup - sends a Telegram alert ONLY on failure (or first-success confirm).
# Cron: 0 3 * * *  (03:00 UTC = 05:00 MESZ)
# Alerting rule: zero messages on a green day after the initial wiring confirm.
ALERT="/home/hermes/telegram_alert.sh"
LOG="/home/hermes/hermes/logs/backup.log"
LOCK="/home/hermes/hermes/logs/backup.lock"
SENT_OK_ONCE="/home/hermes/hermes/logs/backup.ok-once"

if [ -f "$LOCK" ]; then
    "$ALERT" "WARN" "Backup-Abbruch" "Lockfile noch vorhanden: $LOCK" > /dev/null 2>&1
    exit 1
fi
touch "$LOCK"

TIMESTAMP=$(date +%Y%m%d-%H%M)
BACKUP_DIR="/home/hermes/hermes/backups/daily"
BACKUP_FILE="${BACKUP_DIR}/hermes-data-${TIMESTAMP}.tar.gz"
mkdir -p "$BACKUP_DIR"

# Backup excluding secrets and locks; sudo because bind-mount is UID-10000
sudo -S -p '' tar -czf "$BACKUP_FILE" \
    --exclude='.env' --exclude='.env.backup-*' --exclude='*.log' --exclude='*.lock' \
    -C /docker/hermes-agent-ekgx/data \
    config.yaml SOUL.md cron/ skills/ state.db shared-state.db projects.db kanban.db 2>&1

RC=$?
SIZE=$(du -h "$BACKUP_FILE" | awk '{print $1}')
rm -f "$LOCK"

if [ $RC -eq 0 ]; then
    echo "[$(date)] Backup OK: $BACKUP_FILE ($SIZE)" >> "$LOG"
    # Alert only once: on the first successful backup after deploy.
    # Steady state = silent on green days.
    if [ ! -f "$SENT_OK_ONCE" ]; then
        "$ALERT" "INFO" "Backup erfolgreich (initial)" "Datei: hermes-data-${TIMESTAMP}.tar.gz
Groesse: ${SIZE}
Pfad: ${BACKUP_DIR}

Ab jetzt: stiller Erfolg (kein taegliches 'all good'). Alert nur bei Fehler." > /dev/null
        touch "$SENT_OK_ONCE"
    fi
else
    echo "[$(date)] Backup FEHLGESCHLAGEN (RC=$RC)" >> "$LOG"
    "$ALERT" "CRITICAL" "Backup FEHLGESCHLAGEN" "Cron-Lauf ohne Archiv beendet.

Backup-Verzeichnis: ${BACKUP_DIR}
Return-Code: $RC

Manuell pr\u00fcfen." > /dev/null
    exit $RC
fi
