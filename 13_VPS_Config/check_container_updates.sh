#!/bin/bash
# ============================================================
# Hermes-VPS Container-Update-Check
# Prüft verfügbare Image-Updates, OHNE automatisch upzudaten
# ============================================================

TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
LOG_FILE="$HOME/hermes/logs/updates.log"

mkdir -p "$(dirname "$LOG_FILE")"

log() {
    echo "[$TIMESTAMP] $1" | tee -a "$LOG_FILE"
}

log "=== Container-Update-Check gestartet ==="

# === Liste der zu prüfenden Images ===
IMAGES=(
    "ghcr.io/hostinger/hvps-hermes-agent:latest"
    "traefik:latest"
)

UPDATES_AVAILABLE=0

for IMAGE in "${IMAGES[@]}"; do
    # Lokale Version (Image-Hash)
    LOCAL_HASH=$(sudo docker images --format "{{.Repository}}:{{.Tag}} {{.ID}}" 2>/dev/null | grep -F "$IMAGE" | awk '{print $2}' | head -1)

    # Remote-Version (Digest von Docker Hub)
    if [[ "$IMAGE" == *"ghcr.io"* ]]; then
        # GitHub Container Registry
        REGISTRY="ghcr.io"
    else
        # Docker Hub
        REGISTRY="docker.io"
    fi

    log "Prüfe $IMAGE..."

    # Versuche, das neueste Image zu pullen (ohne laufende Container zu stören)
    if sudo docker pull "$IMAGE" 2>&1 | grep -q "Status: Image is up to date"; then
        log "  ✓ $IMAGE ist aktuell"
    else
        log "  ⚠️ $IMAGE hat möglicherweise ein Update!"
        UPDATES_AVAILABLE=$((UPDATES_AVAILABLE + 1))
    fi
done

log "=== Update-Check abgeschlossen ($UPDATES_AVAILABLE Updates verfügbar) ==="
log ""
