#!/bin/bash
# Prueft SSL-Zertifikate der wichtigsten Domains
ALERT="/home/hermes/telegram_alert.sh"
LOG="/home/hermes/hermes/logs/ssl.log"
DOMAINS=(
    "your-domain.de"
    "another-domain.com"
)
WARN_DAYS=21

echo "[$(date)] SSL-Check gestartet" >> "$LOG"

for domain in "${DOMAINS[@]}"; do
    if [ "$domain" = "your-domain.de" ]; then continue; fi
    
    expiry_date=$(echo | openssl s_client -servername "$domain" -connect "$domain":443 2>/dev/null | openssl x509 -noout -enddate 2>/dev/null | cut -d= -f2)
    
    if [ -z "$expiry_date" ]; then
        "$ALERT" "WARN" "SSL-Check: $domain" "Verbindung oder Zertifikat nicht abrufbar.
Moeglicherweise Down oder kein HTTPS." > /dev/null
        continue
    fi
    
    expiry_epoch=$(date -d "$expiry_date" +%s 2>/dev/null)
    now=$(date +%s)
    days=$(( (expiry_epoch - now) / 86400 ))
    
    if [ "$days" -lt "$WARN_DAYS" ]; then
        "$ALERT" "WARN" "SSL-Zertifikat laeuft ab: $domain" "Domain: $domain
Laeuft ab: $expiry_date
Verbleibend: $days Tage (Schwelle: $WARN_DAYS Tage)
Bitte erneuern!" > /dev/null
        echo "[$(date)] $domain: $days Tage verbleibend" >> "$LOG"
    else
        echo "[$(date)] $domain: OK ($days Tage)" >> "$LOG"
    fi
done
