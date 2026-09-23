#!/bin/bash
# Sicherheits-Monitor: Login-Versuche, Fail2Ban, SSH-Anomalien
ALERT="/home/hermes/telegram_alert.sh"
LOG="/home/hermes/hermes/logs/security.log"
echo "[$(date)] Security-Monitor gestartet" >> "$LOG"

WARN_LOGIN_THRESHOLD=20
WARN_FAIL2BAN_THRESHOLD=5

# 1. Fehlgeschlagene SSH-Logins in den letzten 60 Minuten
# BUGFIX (2026-09-24): Vorher wurde TOTAL aller Failed-Password gezaehlt
# (inkl. sudo-COMMAND-Eintraege). Jetzt: nur echte sshd-Eintraege letzte 1h.
if [ -f /var/log/auth.log ]; then
    FAILED_SSH=$(sudo journalctl -u ssh --since "1 hour ago" 2>/dev/null | \
        grep "sshd\[.*\]: Failed password" | grep -v "sudo:" | wc -l)
    if [ "$FAILED_SSH" -gt "$WARN_LOGIN_THRESHOLD" ]; then
        UNIQUE_IPS=$(sudo journalctl -u ssh --since "1 hour ago" 2>/dev/null | \
            grep "sshd\[.*\]: Failed password" | grep -v "sudo:" | \
            grep -oE 'from [0-9.]+' | sort | uniq -c | sort -rn | head -5 | \
            awk '{print $3}' | paste -sd, -)
        "$ALERT" "SECURITY" "SSH-Bruteforce erkannt" "Letzte 1h: ${FAILED_SSH} fehlgeschlagene Login-Versuche
Top-Quell-IPs: ${UNIQUE_IPS}" > /dev/null
        echo "[$(date)] SSH-Bruteforce: $FAILED_SSH attempts" >> "$LOG"
    fi
fi

# 2. Fail2Ban-Aktivitaet
if command -v fail2ban-client &>/dev/null; then
    BANNED=$(sudo -S -p '' fail2ban-client status sshd 2>/dev/null | grep "Banned IP list:" | sed 's/.*Banned IP list://' | wc -w)
    if [ "$BANNED" -gt "$WARN_FAIL2BAN_THRESHOLD" ]; then
        BANNED_LIST=$(sudo -S -p '' fail2ban-client status sshd 2>/dev/null | grep "Banned IP list:" | sed 's/.*Banned IP list://')
        "$ALERT" "SECURITY" "Fail2Ban: $BANNED IPs gebannt" "Aktuell gebannte IPs im sshd-Jail:
${BANNED_LIST}" > /dev/null
        echo "[$(date)] Fail2Ban: $BANNED banned IPs" >> "$LOG"
    fi
fi

# 3. Erfolgreiche Logins von ungewohnten IPs
ACCEPTED_AUTH="/var/log/auth.log"
if [ -f "$ACCEPTED_AUTH" ]; then
    LAST_LOGINS=$(grep "Accepted" "$ACCEPTED_AUTH" 2>/dev/null | tail -5)
    echo "[$(date)] Letzte erfolgreiche Logins:" >> "$LOG"
    echo "$LAST_LOGINS" >> "$LOG"
fi

echo "[$(date)] Security-Monitor abgeschlossen" >> "$LOG"
