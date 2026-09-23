# Telegram-Bot Polling-Konflikt — Vorfall 2026-09-23

> **Zweck:** Dokumentation des Polling-Konflikts zwischen Sidecar-Test und Hauptbot, Lehren für künftige Sidecar-Tests.

---

## Zusammenfassung

Beim **Live-Test des Telegram-Sidecars** (Schritt 2 des Quick-Win-Plans am 2026-09-23) kam es zu **Polling-Konflikten** zwischen dem Sidecar und dem offiziellen Hermes-Telegram-Bot. Diese führten zu mehren Warnmeldungen im Container-Log.

---

## Zeitstrahl

| Zeit (MESZ) | Ereignis |
|---|---|
| 21:50 | Sidecar gestartet via `nohup python3 telegram_sidecar.py` |
| 21:52:52 | Erster Konflikt im Hauptbot: `previous session still held open on Telegram's servers` |
| 21:55:06 | Retry 1/5 (Hauptbot versucht erneut, Waiting 20s) |
| 21:55:34 | Retry 2/5 (Waiting 30s) |
| 21:56:09 | Retry 3/5 (Waiting 40s) |
| 21:56:54 | Retry 4/5 (Waiting 50s) |
| 21:57 | Sidecar gestoppt via `kill -9 23005 23006` |
| 21:57:35 | Letzter Sidecar-Log-Eintrag (HTTP getUpdates) |
| ~22:00 | Hauptbot recovered, sauberer Polling |
| 22:17:09 | **Weiterer Konflikt ausgelöst durch Test-getUpdates von außen** (Bot-Test-Aufruf) |
| 22:17:30 | Hauptbot wartet 20s, recovers danach |

---

## Was war passiert?

### Telegram-API-Regel

Telegram erlaubt **nur EINEN** `getUpdates`-Request pro Bot gleichzeitig. Sobald ein zweiter Client (Sidecar oder externer Test) pollt, blockt die API den ersten mit `Conflict: terminated by other getUpdates request`.

### Hauptbot-Verhalten

Der Hauptbot hat eine **eingebaute Retry-Strategie**:
- 1/5: 20s warten
- 2/5: 30s warten
- 3/5: 40s warten
- 4/5: 50s warten
- 5/5: Endlosschleife (laut Code-Pfad)

Diese Strategie hat den Konflikt automatisch aufgelöst, **nachdem** der Sidecar gestoppt wurde. Telegram-API gibt den alten Session-Token nach einiger Zeit frei.

### Zwei Konflikt-Quellen

1. **Sidecar-Test (21:52–21:57):** Geplant und erwartet. Sidecar + Hauptbot parallel → Konflikt.
2. **Mein eigener Test-getUpdates (22:17):** Unbeabsichtigt. Ich habe zur Bot-Verifikation direkt `getUpdates` aufgerufen, was den Hauptbot störte.

---

## Was wurde behoben

| Maßnahme | Status |
|---|---|
| Sidecar gestoppt | ✅ erledigt |
| Sidecar-Test-Log gelöscht (`sidecar_test.log`) | ✅ erledigt |
| Hauptbot recovered automatisch | ✅ erledigt |
| Protokoll erstellt | ✅ dieses Dokument |

---

## Lehren für künftige Sidecar-Tests

### 1. NIEMALS Sidecar + Hauptbot gleichzeitig pollen lassen

**Entweder** Sidecar **oder** Hauptbot. Niemals parallel.

**Optionen für künftige Tests:**

- **Option A:** Hauptbot temporär stoppen, Sidecar testen, Hauptbot wieder starten. Aber: s6-Restart macht das umständlich.
- **Option B:** Hauptbot auf **Webhook** umstellen, Sidecar weiter **Polling**. Beide laufen ohne Konflikt.
- **Option C:** Sidecar nur bei Bedarf manuell starten (mit `&` und `kill $!` direkt nach dem Test).

### 2. NIEMALS getUpdates manuell aufrufen während der Bot läuft

Telegram-API prüft jeden `getUpdates`-Aufruf und verwirft alle anderen Polling-Sessions.

**Wenn ich den Bot testen will:**
- Via `curl POST .../sendMessage` (schickt Message, Bot empfängt über getUpdates)
- Oder via `getMe` (kein Polling-Konflikt)
- Oder Logs lesen (kein API-Call)

### 3. Bei Sidecar-Tests: kurze Test-Dauer (≤ 1 min)

Selbst bei kurzen Tests kann Telegram die "previous session" 1-2 Minuten halten. **Nach Sidecar-Stop:** mindestens 2 Minuten warten, bevor man den Hauptbot als "sauber" einstuft.

### 4. Dokumentation der Polling-Limits

Die Telegram-Bot-Doku beschreibt das Limit klar: **Nur 1× Polling gleichzeitig** pro Bot-Token. Webhooks sind parallel nutzbar (einer schickt, einer empfängt).

---

## Langfristige Empfehlung

**Hauptbot auf Webhook umstellen**, Sidecar weiter Polling:

```
TELEGRAM_WEBHOOK_URL=https://srv1998925.hstgr.cloud:8443/telegram
TELEGRAM_WEBHOOK_PORT=8443
TELEGRAM_WEBHOOK_CERT=/path/to/cert.pem
```

→ Hauptbot empfängt via HTTPS-Push vom Telegram-Server
→ Sidecar kann dauerhaft parallel via `getUpdates` pollen
→ **Keine Konflikte mehr möglich**

Aber: Webhook benötigt HTTPS-Endpunkt + Zertifikat + offene Firewall (Traefik auf VPS ist bereits konfiguriert, siehe Cronjob-Setup).

---

## Referenzen

- **Telegram Bot API — getUpdates:** [core.telegram.org/bots/api#getupdates](https://core.telegram.org/bots/api#getupdates)
- **python-telegram-bot Conflict-Error:** [python-telegram-bot.readthedocs.io/en/stable/telegram.error.html](https://python-telegram-bot.readthedocs.io/en/stable/telegram.error.html)
- **Hermes-VTOL Telegram-Connector:** `13_VPS_Config/telegram_to_github.sh`, `13_VPS_Config/telegram_sidecar.py`
- **Sidecar-Install-Anleitung:** `13_VPS_Config/SIDECAR-INSTALL.md`

---

## Versionsverlauf

| Version | Datum | Änderung |
|---|---|---|
| 1.0 | 2026-09-23 | Initiales Protokoll nach Sidecar-Test-Vorfall |
