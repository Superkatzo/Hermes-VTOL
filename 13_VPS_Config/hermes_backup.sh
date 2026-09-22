#!/bin/bash
# ============================================================
# Hermes-VPS Backup-Skript
# Erstellt tägliche Sicherungen der kritischen Daten
# ============================================================

set -euo pipefail

TIMESTAMP=$(date '+%Y%m%d-%H%M%S')
BACKUP_DIR="$HOME/hermes/backups/daily"
HERMES_DATA="/docker/hermes-agent-ekgx/data"
RETENTION_DAYS=14

mkdir -p "$BACKUP_DIR"

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Backup startet..."

# === Hermes-Daten sichern (Konfig, Memory, Sessions, State) ===
BACKUP_FILE="$BACKUP_DIR/hermes-data-$TIMESTAMP.tar.gz"

# Was wir sichern (kritische Daten, KEINE Geheimnisse in Klartext-Datei):
#   - config.yaml (Konfiguration)
#   - SOUL.md (Persona)
#   - memories/ (Memory)
#   - state.db (Hauptdatenbank, falls vorhanden)
#   - sessions.db (Sessions, falls vorhanden)
# NICHT sichern:
#   - .env (enthält Secrets, schon ausgeschlossen)
#   - .env.backup-* (auch Secrets)
#   - auth.json (enthält OAuth-Credentials)
#   - auth.lock, gateway.lock, .install_id.lock
#   - backups/ (Rekursion vermeiden)
#   - cache/ (rekonstruierbar)

# sudo nötig, weil hermes-user keinen Zugriff auf /docker hat
sudo tar -czf "$BACKUP_FILE" \
    -C "$HERMES_DATA" \
    config.yaml \
    SOUL.md \
    memories/ \
    state.db \
    shared-state.db \
    runs_idempotency.db \
    projects.db \
    kanban.db \
    response_store.db \
    cron/ \
    skills/ \
    home/ \
    channel_directory.json \
    2>/dev/null || {
    echo "⚠️ Einige Dateien fehlen (das ist OK beim ersten Lauf)"
}

# Backup-Größe prüfen
BACKUP_SIZE=$(du -h "$BACKUP_FILE" 2>/dev/null | awk '{print $1}')
echo "✓ Backup erstellt: $(basename "$BACKUP_FILE") ($BACKUP_SIZE)"

# === Alte Backups aufräumen (Retention) ===
DELETED=$(find "$BACKUP_DIR" -name "hermes-data-*.tar.gz" -mtime +$RETENTION_DAYS -delete -print | wc -l)
if [ "$DELETED" -gt 0 ]; then
    echo "🧹 $DELETED alte Backups gelöscht (>$RETENTION_DAYS Tage)"
fi

# === Aktuelle Backups auflisten ===
echo ""
echo "=== Aktuelle Backups ==="
ls -lh "$BACKUP_DIR"/hermes-data-*.tar.gz 2>/dev/null | tail -5 || echo "(noch keine weiteren)"

# === Optional: Backup zu externem Speicher (z. B. Hetzner Storage Box) ===
# Falls du später eine externe Backup-Lösung willst, hier verfügbar:
# rsync -avz "$BACKUP_DIR/" user@backup-server:/backups/hermes/

echo ""
echo "[$(date '+%Y-%m-%d %H:%M:%S')] Backup abgeschlossen."
