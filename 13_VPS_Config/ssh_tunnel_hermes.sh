#!/bin/bash
# ============================================================
# Hermes-VPS SSH-Tunnel
# ============================================================
#
# Öffnet einen verschlüsselten Tunnel zu deinem VPS
# und macht die Hermes-Web-UI unter localhost:8080 erreichbar.
#
# Verwendung:
#   bash ssh_tunnel_hermes.sh
#
# Dann im Browser öffnen:
#   http://localhost:8080
#
# Beenden: Ctrl+C im Terminal drücken
#
# ============================================================

set -e

VPS_HOST="hermes-vps"
LOCAL_PORT="${LOCAL_PORT:-8080}"
REMOTE_PORT="${REMOTE_PORT:-32768}"

echo "==============================================="
echo "  Hermes-VPS SSH-Tunnel"
echo "==============================================="
echo ""
echo "  Lokal:    http://localhost:${LOCAL_PORT}"
echo "  VPS-Host: ${VPS_HOST}"
echo "  Remote:   Port ${REMOTE_PORT} (Hermes Web-UI)"
echo ""
echo "  Drücke Ctrl+C zum Beenden."
echo ""

# Tunnel öffnen
ssh -L "${LOCAL_PORT}:127.0.0.1:${REMOTE_PORT}" -N "${VPS_HOST}"
