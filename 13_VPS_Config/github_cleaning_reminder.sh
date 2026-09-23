#!/bin/bash
# Wöchentlicher GitHub-Cleaning-Hinweis — freitags 11:30 MESZ (= 09:30 UTC)
#
# Zweck: willow daran erinnern, einmal pro Woche das Repo aufzuräumen.
#        Cleaning-Tag = offene Issues/PRs sichten, stale Branches mergen oder
#        löschen, Commit-History prüfen, Doku synchron halten.
#
# Cron-Eintrag:
#   30 9 * * 5 /home/hermes/hermes/github_cleaning_reminder.sh >> /home/hermes/hermes/logs/cron.log 2>&1
#
# (30 9 = 09:30 UTC = 11:30 MESZ im Sommer, * 5 = jeden Freitag)

TIMESTAMP=$(date +'%Y-%m-%d %H:%M %Z')

# Kurze Nachricht — Details werden bei Bedarf im Chat abgefragt.
MESSAGE="🧹 *GitHub Cleaning Tag*

Hallo willow! Heute ist Freitag — Zeit für den wöchentlichen Repo-Check.

📅 *${TIMESTAMP}*

✅ *Kurz-Checkliste (5–15 min):*
• Offene Issues/PRs auf GitHub durchgehen
• Stale Branches identifizieren (lokal + remote)
• Letzte Commits: passt alles, oder gibt es Amend-Bedarf?
• Doku-Updates seit letztem Cleaning-Tag synchron?

💬 *Antworte mit \`cleaning start\`, dann gehe ich mit dir durch:*
• \`gh issue list --repo Superkatzo/Hermes-VTOL --state open\`
• \`gh pr list --repo Superkatzo/Hermes-VTOL --state open\`
• \`git fetch --all --prune\` + Branch-Übersicht

📌 *Nicht warten bis es unübersichtlich wird — lieber wöchentlich kurz.*

— Dein testbot auf Hostinger VPS"

# Lese Telegram-Token aus dem Hermes-Container
TELEGRAM_BOT_TOKEN=$(sudo docker exec hermes-agent-ekgx-hermes-agent-1 bash -c 'grep ^TELEGRAM_BOT_TOKEN /opt/data/.env | cut -d= -f2' 2>/dev/null | tr -d '\r')

if [ -z "$TELEGRAM_BOT_TOKEN" ]; then
    echo "[ERROR] Kein TELEGRAM_BOT_TOKEN gefunden"
    exit 1
fi

# Sende via direkter Telegram-Bot-API
CHAT_ID="858968389"
URL="https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendMessage"

curl -s -X POST "$URL" \
    -d chat_id="$CHAT_ID" \
    -d parse_mode="Markdown" \
    -d text="$MESSAGE" > /dev/null

if [ $? -eq 0 ]; then
    echo "[${TIMESTAMP}] GitHub-Cleaning-Reminder gesendet"
else
    echo "[${TIMESTAMP}] GitHub-Cleaning-Reminder FEHLGESCHLAGEN"
    exit 1
fi
