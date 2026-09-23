#!/bin/bash
# Telegram ↔ GitHub Connection — ermöglicht Todo-Liste-Update vom Handy
#
# Zweck: willow kann vom Handy per Telegram-Nachricht an den Bot
#        einen neuen Task in 01_Dokumentation/Todos/Todo-Liste.md pushen.
#
# Ablauf:
#   1. User sendet: "speichere X" oder "job #N: ..." per Telegram an den Bot
#   2. Telegram-Sidecar empfängt Nachricht
#   3. Sidecar ruft dieses Skript mit --text "..." auf
#   4. Skript cloned/pulled Repo, patcht Todo-Liste.md, committed, pusht
#
# Authentifizierung:
#   - GitHub-PAT liegt in /opt/data/.env des Hermes-Agent-Containers
#   - Skript holt ihn via 'sudo docker exec ... grep GITHUB_PAT'
#   - Push via HTTPS mit PAT in URL (temporaer, wird nicht geloggt)
#
# Sicherheit:
#   - Token kommt aus .env, wird nicht persistent gespeichert
#   - Input wird geprüft (max 500 Zeichen, Sanity-Check fuer Sonderzeichen)
#   - Repo-URL wird vor dem Push wieder bereinigt
#
# Aufruf:
#   /home/hermes/telegram_to_github.sh --text "Job #5: CAD-Modell der Tragflueche fertigstellen"

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

# --- Sanity-Check Text (max 500 Zeichen, nur sichere Zeichen) ---
if [ ${#TEXT} -gt 500 ]; then
    echo "[ERROR] Text zu lang (max 500 Zeichen, ist ${#TEXT})" >&2
    exit 1
fi

if ! echo "$TEXT" | grep -qE '^[[:alnum:][:space:][:punct:][:cntrl:]]+$'; then
    echo "[ERROR] Ungueltige Zeichen im Text" >&2
    exit 1
fi

# --- GitHub-PAT aus Container-.env holen ---
GITHUB_PAT=$(sudo docker exec hermes-agent-ekgx-hermes-agent-1 \
    bash -c 'grep ^GITHUB_PAT= /opt/data/.env | cut -d= -f2' 2>/dev/null | tr -d '\r' || true)

if [ -z "$GITHUB_PAT" ]; then
    echo "[ERROR] GITHUB_PAT nicht in /opt/data/.env gefunden" >&2
    echo "[HINT] Siehe 13_VPS_Config/GITHUB-PAT-ANLEITUNG.md" >&2
    exit 1
fi

# Repo-URL mit PAT (PAT NIEMALS loggen!)
REPO_URL="https://x-access-token:${GITHUB_PAT}@github.com/Superkatzo/Hermes-VTOL.git"

# --- Repo-Update (klonen falls noetig) ---
if [ ! -d "$REPO_PATH/.git" ]; then
    echo "[INFO] Repo nicht gefunden, klone nach $REPO_PATH ..."
    sudo -u hermes git clone "$REPO_URL" "$REPO_PATH" 2>/dev/null \
        || { echo "[ERROR] git clone fehlgeschlagen" >&2; exit 1; }
    # Remote-URL auf saubere Form (ohne PAT) aendern, damit 'git remote -v' nicht den Token leakt
    sudo -u hermes git -C "$REPO_PATH" remote set-url origin \
        "https://github.com/Superkatzo/Hermes-VTOL.git"
fi

cd "$REPO_PATH" || { echo "[ERROR] Repo-Pfad nicht erreichbar: $REPO_PATH" >&2; exit 1; }

# Git-Identity sicherstellen (fuer Commit-Autor)
sudo -u hermes git config user.email "hermes-vps@superkatzo.local" 2>/dev/null || true
sudo -u hermes git config user.name "Hermes VPS Bot" 2>/dev/null || true

# Temporaer die URL mit PAT setzen (fuer push), spaeter wieder entfernen
sudo -u hermes git remote set-url origin "$REPO_URL"

# Aktuellen Stand holen
if ! sudo -u hermes git pull --rebase --quiet 2>/dev/null; then
    echo "[ERROR] git pull fehlgeschlagen" >&2
    # URL wieder bereinigen, bevor wir beenden
    sudo -u hermes git remote set-url origin \
        "https://github.com/Superkatzo/Hermes-VTOL.git" 2>/dev/null || true
    exit 1
fi

# Todo-Liste patchen — Eintrag vor "## 📅 Chronik" einfuegen
TODO_PATH="$REPO_PATH/$TODO_FILE"
if [ ! -f "$TODO_PATH" ]; then
    echo "[ERROR] Todo-Datei nicht gefunden: $TODO_PATH" >&2
    sudo -u hermes git remote set-url origin \
        "https://github.com/Superkatzo/Hermes-VTOL.git" 2>/dev/null || true
    exit 1
fi

# Formatiere neuen Eintrag
NEW_LINE="| ${TIMESTAMP} | Via Telegram: ${TEXT} |"

# Patche via python (robuster als sed mit Sonderzeichen)
# Wir fuegen INNERHALB der Chronik-Tabelle eine neue Zeile ein, nicht davor.
sudo -u hermes python3 - <<PYEOF
import sys
path = "$TODO_PATH"
new_line = "| ${TIMESTAMP} | Via Telegram: ${TEXT} |"
with open(path, 'r', encoding='utf-8') as f:
    content = f.read()
# Marker: "## \U0001F4C5 Chronik" leitet die Sektion ein,
# direkt darunter steht die Tabelle mit Header "| Datum | ..." und Trenner "|---|...".
# Wir fuegen die neue Zeile NACH der Trenner-Zeile ein (also als erste Datenzeile).
marker = "## \U0001F4C5 Chronik"
if marker not in content:
    print("[ERROR] Chronik-Marker nicht gefunden", file=sys.stderr)
    sys.exit(1)
idx = content.find(marker)
# Suche das ENDE der Trenner-Zeile (das Newline danach)
# Trenner-Format: "|----...|" gefolgt von \n
sep_start = content.find("|---", idx)
if sep_start < 0:
    print("[ERROR] Tabellen-Trenner nicht gefunden", file=sys.stderr)
    sys.exit(1)
sep_end_newline = content.find("\n", sep_start)
if sep_end_newline < 0:
    print("[ERROR] Trenner-Zeile ohne Newline gefunden", file=sys.stderr)
    sys.exit(1)
# Fuege neue Zeile direkt nach dem Newline des Trenners ein
insert_pos = sep_end_newline + 1
new_content = content[:insert_pos] + new_line + "\n" + content[insert_pos:]
with open(path, 'w', encoding='utf-8') as f:
    f.write(new_content)
print("[OK] Todo-Liste gepatcht (Zeile in Chronik eingefuegt)")
PYEOF

# Commit + Push
sudo -u hermes git add "$TODO_FILE"
if ! sudo -u hermes git commit -m "chore(todo): Telegram-Update: ${TEXT:0:80}" --quiet; then
    echo "[WARN] Keine Aenderung zum Committen (Text evtl. schon vorhanden?)" >&2
    sudo -u hermes git remote set-url origin \
        "https://github.com/Superkatzo/Hermes-VTOL.git" 2>/dev/null || true
    exit 0
fi

if ! sudo -u hermes git push --quiet 2>&1; then
    echo "[ERROR] git push fehlgeschlagen" >&2
    sudo -u hermes git remote set-url origin \
        "https://github.com/Superkatzo/Hermes-VTOL.git" 2>/dev/null || true
    exit 1
fi

# URL nach erfolgreichem Push wieder bereinigen (PAT aus .git/config entfernen)
sudo -u hermes git remote set-url origin \
    "https://github.com/Superkatzo/Hermes-VTOL.git" 2>/dev/null || true

echo "[${TIMESTAMP}] Todo-Update gepusht: ${TEXT:0:80}"
