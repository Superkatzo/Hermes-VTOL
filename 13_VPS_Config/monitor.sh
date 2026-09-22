#!/bin/bash
# ============================================================
# Health-Monitor für VPS
# Lässt sich als Cron-Job alle 60 Min ausführen
# ============================================================

TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

echo "=== Hermes-VPS Health-Check ==="
echo "Zeitstempel: $TIMESTAMP"
echo ""

# CPU-Last (load average)
echo "--- CPU-Last (1, 5, 15 min) ---"
uptime
echo ""

# RAM
echo "--- RAM-Nutzung ---"
free -h
echo ""

# Disk
echo "--- Disk-Nutzung ---"
df -h / | tail -1
echo ""

# Hermes-Agent-Status (versuche systemd, dann docker)
echo "--- Hermes-Agent-Status ---"
if systemctl list-units --full -all 2>/dev/null | grep -q hermes-agent.service; then
    systemctl is-active hermes-agent
elif command -v docker &> /dev/null; then
    docker ps --filter "name=hermes" --format "table {{.Names}}\t{{.Status}}" 2>/dev/null || echo "Kein Hermes-Container aktiv."
else
    echo "Hermes-Agent-Status unbekannt (kein systemd-Service, kein Docker)."
fi
echo ""

# Aktive Verbindungen
echo "--- SSH-Sessions aktiv ---"
who
echo ""

# Letzte fehlgeschlagene Login-Versuche (für Sicherheits-Audit)
echo "--- Letzte fehlgeschlagene Logins (Top 5) ---"
sudo grep "Failed password" /var/log/auth.log 2>/dev/null | tail -5 || echo "Keine (oder kein Zugriff auf Log)"
echo ""

# fail2ban-Status
echo "--- fail2ban SSH-Jail ---"
sudo fail2ban-client status sshd 2>/dev/null || echo "fail2ban läuft nicht."
echo ""
