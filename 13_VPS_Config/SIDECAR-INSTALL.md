# 📦 Hermes-Telegram-Sidecar — Installation

> **Zweck:** Ein zweiter, kleiner Telegram-Bot auf dem VPS, der **nur** "speichere X"-Messages annimmt und an `telegram_to_github.sh` weiterleitet. Der offizielle Hermes-Bot bleibt unangetastet für normalen Chat.

---

## ⚠️ Wichtiger Hinweis: Polling-Konflikt

Python-telegram-bot nutzt **Long-Polling** auf dem Bot-Token. **Zwei Bots mit dem gleichen Token** führen zu **Polling-Konflikten** (jeder bekommt nur ca. 50 % der Messages).

**Lösungen (eine wählen):**

| Option | Vorteil | Nachteil |
| --- | --- | --- |
| **A) Sidecar dauerhaft aktiv, offizieller Bot deaktiviert** | Volle Message-Kontrolle | Kein normaler Chat-Bot mehr |
| **B) Sidecar bei Bedarf starten** (`systemctl start ...`) | Normaler Chat funktioniert weiter | Manueller Aufwand |
| **C) Webhook statt Polling** (braucht HTTPS-Endpunkt) | Kein Konflikt | Komplexer, braucht Traefik |

**Empfehlung: Option B** — Sidecar nur starten wenn du vom Handy aus Todos pushen willst.

---

## 📋 Installation

### Voraussetzungen prüfen

```bash
ssh hermes-vps
python3 --version  # >= 3.10
python3 -c "import telegram; print(telegram.__version__)"  # >= 20.0
```text

Falls `python-telegram-bot` fehlt:

```bash
sudo apt install python3-pip
pip3 install python-telegram-bot --break-system-packages
```text

### 1. Skripte deployen

```bash
cd /home/hermes
sudo cp telegram_sidecar.py /home/hermes/telegram_sidecar.py
sudo chmod +x /home/hermes/telegram_sidecar.py
sudo chown root:root /home/hermes/telegram_sidecar.py

# Service-Unit installieren
sudo cp hermes-telegram-sidecar.service /etc/systemd/system/
sudo systemctl daemon-reload
```text

### 2. Logs-Verzeichnis

```bash
sudo mkdir -p /home/hermes/logs
sudo touch /home/hermes/logs/telegram_sidecar.log
sudo chown root:root /home/hermes/logs/telegram_sidecar.log
```text

### 3. Test (manuell, ohne systemd)

```bash
sudo python3 /home/hermes/telegram_sidecar.py
```text

Erwartete Ausgabe:

```text
[INFO] Sidecar startet mit Token-Laenge=46
[INFO] Bot laeuft (polling). Druecke Ctrl+C zum Stoppen.
```text

**Im Telegram:** schicke "speichere Test-Eintrag vom Sidecar" → Sidecar sollte antworten "✅ Gespeichert: ..."

### 4. systemd-Service (optional)

```bash
sudo systemctl enable hermes-telegram-sidecar.service   # Auto-Start bei Boot
sudo systemctl start hermes-telegram-sidecar.service    # Jetzt starten
sudo systemctl status hermes-telegram-sidecar.service   # Status pruefen
```text

### 5. Stoppen (wenn du normalen Chat-Bot nutzen willst)

```bash
sudo systemctl stop hermes-telegram-sidecar.service
```text

---

## 🧪 Schnelltest

```bash
# Im Telegram an den Bot senden:
/help
# → Antwort: "🤖 Hermes-Telegram-Sidecar..."

speichere Memory-Konsolidierung als naechstes angehen
# → Antwort: "✅ Gespeichert: Memory-Konsolidierung als naechstes angehen"

# Pruefe auf VPS:
tail -5 /home/hermes/logs/telegram_sidecar.log
# → "[INFO] Todo gepusht: Memory-Konsolidierung..."
```text

Auf GitHub sollte in `01_Dokumentation/Todos/Todo-Liste.md` ein neuer Eintrag in der Chronik stehen.

---

## ⚠️ Konflikte mit Hauptbot vermeiden

**Wichtig (Stand 2026-09-23):** Der Sidecar hat jetzt einen **Health-Check** eingebaut, der vor dem Start prüft, ob der Hauptbot-Polling aktiv ist.

### Standard-Verhalten (sicher)

```bash
python3 /home/hermes/telegram_sidecar.py
```text

Wenn der Hauptbot aktiv ist, **blockiert** der Sidecar mit Exit-Code 1 und klarer Warnung:

```text
HEALTH-CHECK WARNUNG: Hauptbot-Polling wahrscheinlich aktiv!
Grund: hauptbot_docker_active
Detail: Container-Hauptbot laeuft ohne Webhook -> wahrscheinlich Polling-Konflikt
Sidecar wird NICHT gestartet. Verwende --force zum Erzwingen.
Bessere Loesung: Hauptbot auf Webhook umstellen (siehe Protokoll).
```text

### Erzwungener Start (mit Konflikt)

```bash
python3 /home/hermes/telegram_sidecar.py --force
```text

**Achtung:** `--force` umgeht den Health-Check. Der Hauptbot wird 20-50s in einer Retry-Schleife gefangen sein, bis der Sidecar wieder stoppt. Nur verwenden, wenn du weißt was du tust (z. B. Sidecar nach Hauptbot-Stop starten).

### Langfristige Lösung

**Hauptbot auf Webhook umstellen** (`TELEGRAM_WEBHOOK_URL=...`). Dann ist Sidecar dauerhaft parallel lauffähig ohne Konflikte. Siehe Vorfall-Protokoll: `01_Dokumentation/Protokolle/Telegram-Bot-Polling-Konflikt-2026-09-23.md`.

---

## ⚠️ Voraussetzung: GitHub-Auth

Der `telegram_to_github.sh` braucht Auth auf dem VPS, um zu pushen. Siehe `13_VPS_Config/GITHUB-PAT-ANLEITUNG.md` für:

- Fine-Grained PAT (30 Sek.)
- ODER SSH-Deploy-Key

Ohne Auth funktioniert das Speichern via Telegram nicht.

---

## 📁 Dateien in diesem Bundle

| Datei | Zweck |
| --- | --- |
| `telegram_sidecar.py` | Python-Bot, pollt Token, erkennt Trigger |
| `hermes-telegram-sidecar.service` | systemd-Service-Unit (optional) |
| `telegram_to_github.sh` | Bash-Connector, der Todo patcht + pusht (vom Sidecar aufgerufen) |
| `INSTALL.md` | Diese Anleitung |
