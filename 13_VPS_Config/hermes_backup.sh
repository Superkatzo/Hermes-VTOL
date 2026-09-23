#!/bin/bash
# Hermes-Backup mit Telegram-Alert
ALERT="/home/hermes/telegram_alert.sh"
LOG="/home/hermes/hermes/logs/backup.log"
LOCK="/home/hermes/hermes/logs/backup.lock"

# Lockfile gegen Parallel-Lauf
if [ -f "$LOCK" ]; then
    "$ALERT" "WARN" "Backup-Abbruch" "Letzter Backup lief noch. Lockfile: $LOCK vorhanden." > /dev/null 2>&1
    exit 1
fi
touch "$LOCK"

TIMESTAMP=$(date +%Y%m%d-%H%M)
BACKUP_DIR="/home/hermes/hermes/backups/daily"
BACKUP_FILE="${BACKUP_DIR}/hermes-data-${TIMESTAMP}.tar.gz"

mkdir -p "$BACKUP_DIR"

# Backup mit Ausschluss von Secrets
tar -czf "$BACKUP_FILE" \
    --exclude='.env' \
    --exclude='.env.backup-*' \
    --exclude='*.log' \
    -C /docker/hermes-agent-ekgx/data \
    config.yaml SOUL.md cron/ skills/ state.db shared-state.db projects.db kanban.db 2>&1

RC=$?
SIZE=$(du -h "$BACKUP_FILE" | awk '{print $1}')
rm -f "$LOCK"

if [ $RC -eq 0 ]; then
    echo "[$(date)] Backup OK: $BACKUP_FILE ($SIZE)" >> "$LOG"
    "$ALERT" "INFO" "Backup erfolgreich" "Datei: \`hermes-data-${TIMESTAMP}.tar.gz\`
Größe: ${SIZE}
Pfad: \`${BACKUP_DIR}\`" > /dev/null
else
    echo "[$(date)] Backup FEHLGESCHLAGEN (RC=$RC)" >> "$LOG"
    "$ALERT" "CRITICAL" "Backup FEHLGESCHLAGEN" "Letzter Cron-Lauf hat nicht gespeichert.

Backup-Verzeichnis: \`${BACKUP_DIR}\`
Return-Code: $RC

Bitte manuell prüfen." > /dev/null
    exit $RC
fi
