#!/bin/bash
# Telegram ↔ GitHub Connection — ermöglicht Todo-Liste-Update vom Handy
#
# Zweck: willow kann vom Handy per Telegram-Nachricht an den Bot
#        einen neuen Task in 01_Dokumentation/Todos/Todo-Liste.md pushen.
#
# Ablauf:
#   1. User sendet: "speichere X für später" oder "Job #N: ..." per Telegram an den Bot
#   2. python-telegram-bot empfängt Nachricht
#   3. Bot ruft dieses Skript mit --text "..." auf
#   4. Skript cloned Repo nach /tmp, patcht Todo-Liste.md, committed, pusht
#
# Architektur:
#   - Python-Telegram-Bot (läuft im hermes-agent-ekgx Container)
#   - ruft dieses Skript per subprocess auf
#   - Skript schreibt direkt ins hermes-vtol-Repo (das lokal auf VPS liegt)
#
# Sicherheit:
#   - Token + GitHub-Credentials kommen aus /opt/data/.env
#   - Push verwendet SSH-Key (vorbereitet in /home/hermes/.ssh/)
#   - Input wird geprüft (keine Sonderzeichen, max. Länge)
#
# Aufruf:
#   /home/hermes/telegram_to_github.sh --text "Job #5: CAD-Modell der Tragfläche fertigstellen"

set -euo pipefail

# --- Argumente parsen ---
TEXT=""
REPO_PATH="/home/hermes/Hermes-VTOL"
TODO_FILE="01_Dokumentation/Todos/Todo-Liste.md"

while [[ $# -gt 0 ]]; do
    case "$1" in
        --text)
            TEXT="$2"
            shift 2
            ;;
        --repo)
            REPO_PATH="$2"
            shift 2
            ;;
        *)
            echo "[ERROR] Unknown argument: $1" >&2
            exit 1
            ;;
    esac
done

if [ -z "$TEXT" ]; then
    echo "[ERROR] --text ist erforderlich" >&2
    exit 1
fi

TIMESTAMP=$(date +'%Y-%m-%d %H:%M %Z')
DATE_ISO=$(date -u +'%Y-%m-%dT%H:%M:%SZ')

# --- Sanity-Check Text (max 500 Zeichen, keine gefährlichen Zeichen) ---
if [ ${#TEXT} -gt 500 ]; then
    echo "[ERROR] Text zu lang (max 500 Zeichen, ist ${#TEXT})" >&2
    exit 1
fi

# Erlaubte Zeichen: Buchstaben, Ziffern, Leerzeichen, gängige Interpunktion
if ! echo "$TEXT" | grep -qE '^[[:alnum:][:space:][:punct:][:cntrl:]]+$'; then
    echo "[ERROR] Ungültige Zeichen im Text" >&2
    exit 1
fi

# --- Repo-Update ---
if [ ! -d "$REPO_PATH/.git" ]; then
    # Repo nicht vorhanden → einmalig klonen (Voraussetzung fuer Connector)
    echo "[INFO] Repo nicht gefunden, klone nach $REPO_PATH ..."
    sudo -u hermes git clone "https://github.com/Superkatzo/Hermes-VTOL.git" "$REPO_PATH" \
        || { echo "[ERROR] git clone fehlgeschlagen" >&2; exit 1; }
fi

cd "$REPO_PATH" || { echo "[ERROR] Repo-Pfad nicht erreichbar: $REPO_PATH" >&2; exit 1; }

# Git-Identity sicherstellen (für Commit-Autor)
git config user.email "hermes-vps@superkatzo.local" 2>/dev/null || true
git config user.name "Hermes VPS Bot" 2>/dev/null || true

# Aktuellen Stand holen
sudo -u hermes git pull --rebase --quiet 2>&1 || { echo "[ERROR] git pull fehlgeschlagen" >&2; exit 1; }

# Todo-Liste patchen — Eintrag vor "## 📅 Chronik" einfügen
TODO_PATH="$REPO_PATH/$TODO_FILE"
if [ ! -f "$TODO_PATH" ]; then
    echo "[ERROR] Todo-Datei nicht gefunden: $TODO_PATH" >&2
    exit 1
fi

# Formatiere neuen Eintrag
NEW_LINE="| ${TIMESTAMP} | Via Telegram: ${TEXT} |"

# Patche via python (robuster als sed mit Sonderzeichen)
python3 - <<PYEOF
import sys
path = "$TODO_PATH"
new_line = "$NEW_LINE"
with open(path, 'r', encoding='utf-8') as f:
    content = f.read()
marker = "## \U0001F4C5 Chronik"
if marker not in content:
    print("[ERROR] Chronik-Marker nicht gefunden", file=sys.stderr)
    sys.exit(1)
new_content = content.replace(marker, new_line + "\n\n" + marker, 1)
with open(path, 'w', encoding='utf-8') as f:
    f.write(new_content)
print("[OK] Todo-Liste gepatcht")
PYEOF

# Commit + Push
git add "$TODO_FILE"
git commit -m "chore(todo): Telegram-Update: ${TEXT:0:80}" --quiet
git push --quiet

if [ $? -eq 0 ]; then
    echo "[${TIMESTAMP}] Todo-Update gepusht: ${TEXT:0:80}"
else
    echo "[${TIMESTAMP}] FEHLGESCHLAGEN: Todo-Update: ${TEXT:0:80}" >&2
    exit 1
fi
