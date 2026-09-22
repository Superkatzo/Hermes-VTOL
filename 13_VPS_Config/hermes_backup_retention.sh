#!/bin/bash
# ============================================================
# Hermes-VPS Backup-Retention (Production)
# Wird täglich via Cron ausgeführt
# ============================================================
# - Behält die letzten 14 Tage
# - Löscht ältere .tar.gz-Dateien
# - Loggt jede Aktion
# ============================================================

TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
LOG_FILE="$HOME/hermes/logs/retention.log"
RETENTION_DAYS=14

mkdir -p "$(dirname "$LOG_FILE")"

log() {
    echo "[$TIMESTAMP] $1" | tee -a "$LOG_FILE"
}

log "=== Retention-Check (Behalte letzte $RETENTION_DAYS Tage) ==="

BACKUP_DIR="$HOME/hermes/backups/daily"

# Vorher/Nachher zählen
BEFORE_COUNT=$(ls -1 "$BACKUP_DIR"/*.tar.gz 2>/dev/null | wc -l)
BEFORE_SIZE=$(du -sh "$BACKUP_DIR" 2>/dev/null | awk '{print $1}')

# Alte Backups löschen (älter als $RETENTION_DAYS Tage)
DELETED=$(find "$BACKUP_DIR" -name "*.tar.gz" -mtime +$RETENTION_DAYS -delete -print 2>/dev/null | wc -l)

AFTER_COUNT=$(ls -1 "$BACKUP_DIR"/*.tar.gz 2>/dev/null | wc -l)
AFTER_SIZE=$(du -sh "$BACKUP_DIR" 2>/dev/null | awk '{print $1}')

if [ "$DELETED" -gt 0 ]; then
    log "✓ $DELETED alte Backups gelöscht"
fi
log "Bestand: vorher=$BEFORE_COUNT ($BEFORE_SIZE), nachher=$AFTER_COUNT ($AFTER_SIZE)"
log ""
