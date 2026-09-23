#!/bin/bash
# Repo-Review-Reminder — einmaliger Cronjob am 2026-09-30 10:00 MESZ (= 08:00 UTC)
#
# Zweck: willow daran erinnern, das gesamte Hermes-VTOL-Repo einmal durchzugehen
#        und unpassende / doppelte / veraltete Inhalte zu markieren.
#
# Hintergrund: Mit wachsendem Repo (Stand 2026-09-23 ca. 38 Commits, 13 Domänen-Ordner)
#              besteht das Risiko, dass Text-Mengen die Übersicht erschweren.
#              Ziel: kritischer Review, Inhalte konsolidieren, ggf. umsortieren.
#
# Cron-Eintrag:
#   0 8 30 9 * /home/hermes/hermes/repo_review_reminder.sh >> /home/hermes/hermes/logs/cron.log 2>&1
#
# Nach dem Ausführen am 30.09.2026 den Cronjob wieder entfernen:
#   crontab -e  -> Zeile löschen

TIMESTAMP=$(date +'%Y-%m-%d %H:%M %Z')

MESSAGE="📋 *Repo-Review-Reminder — Hermes-VTOL*

Hallo willow! Heute ist der 30.09.2026 — wie versprochen der wöchentliche Repo-Rückblick.

📅 *${TIMESTAMP}*

🎯 *Ziel:* Einmal das *gesamte* Repo durchgehen und Inhalte anpassen, die stören oder nicht (mehr) dahin gehören.

🔍 *Review-Checkliste:*

*1. Konsolidierung prüfen*
• Letzter Commit: 38+ — hat sich Inhalt verdoppelt (z.B. mehrere ConOps-Versionen)?
• Gibt es veraltete Entwürfe (z.B. Lastenheft v0.x neben v1.1)?
• Sind Skripte doppelt (lokale Kopie vs. VPS-Version)?

*2. 13 Domänen-Ordner sauber?*
• Hat jeder Ordner nur *einen* klaren Zweck?
• Liegt etwas in 12_Skripte_Tools/, das nach 03_CAD/ gehört (oder umgekehrt)?
• Liegt Regulatorisches versehentlich in 01_Dokumentation/ statt 09_Regulatorik/?

*3. Inhalts-Granularität*
• Sind neue Dokumente zu lang und gefährden den Überblick?
• Brauchen wir ein *Dokument-Navigator-Update* (01_Dokumentation/Dokument-Navigator.md)?
• README-Dateien pro Ordner aktuell?

*4. Verkaufs-Repositionierung (Stand: 23.09.2026)*
• Reflektiert das Repo die *Verkäufer-Perspektive* (Hersteller/Designer)?
• Sind Hersteller-Pflichten (CE, Produkthaftung) sichtbar genug?
• ConOps-Vorlage als Produkt-Bundle sichtbar?

📝 *Workflow-Vorschlag:*

1. Diesen Chat eröffnen mit: \`repo-review start\`
2. Ich liste dir alle Dateien nach Änderungsdatum
3. Wir gehen Ordner für Ordner durch
4. Was nicht passt → markieren, verschieben oder löschen
5. Am Ende einen \`docs: repo-review cleanup\`-Commit

💡 *Tipp:* Wenn dir nach 10 Dateien die Konzentration schwindet: Pause machen und in 2-3 Etappen weitergehen. Lieber 3× 30 min als 1× Marathon.

— Dein testbot auf Hostinger VPS"

# Lese Telegram-Token aus dem Hermes-Container
TELEGRAM_BOT_TOKEN=$(sudo docker exec hermes-agent-ekgx-hermes-agent-1 bash -c 'grep ^TELEGRAM_BOT_TOKEN /opt/data/.env | cut -d= -f2' 2>/dev/null | tr -d '\r')

if [ -z "$TELEGRAM_BOT_TOKEN" ]; then
    echo "[ERROR] Kein TELEGRAM_BOT_TOKEN gefunden"
    exit 1
fi

# Sende via direkter Telegram-Bot-API
CHAT_ID="858968389"  # TELEGRAM_HOME_CHANNEL
URL="https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendMessage"

curl -s -X POST "$URL" \
    -d chat_id="$CHAT_ID" \
    -d parse_mode="Markdown" \
    -d text="$MESSAGE" > /dev/null

if [ $? -eq 0 ]; then
    echo "[${TIMESTAMP}] Repo-Review-Reminder gesendet"
else
    echo "[${TIMESTAMP}] Repo-Review-Reminder FEHLGESCHLAGEN"
    exit 1
fi
