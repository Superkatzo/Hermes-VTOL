# Session-Checkpoint 2026-09-23 Nachtsitzung

> **Zweck:** Schneller Wiedereinstieg für den User, falls die Konversation kompaktiert wird und Antworten aus dem UI verschwinden.

## Diese Nacht (22:00–23:30 MESZ) — Was wir gemacht haben

| # | Aktion | Status | Datei/Commit |
|---|---|---|---|
| 1 | Telegram-Sidecar-Pipeline getestet | ✅ 3 Messages → 3 GitHub-Commits | — |
| 2 | Token-Permission-Bug behoben (fine-grained PAT, push=false → push=true) | ✅ | — |
| 3 | Token in Container-`.env` als `GITHUB_PAT=...` | ✅ | — |
| 4 | `telegram_to_github.sh` umgeschrieben (HTTPS+PAT statt SSH) | ✅ Commit `eb2addc` |
| 5 | Scheduled Task `Hermes-Tunnel-Auto` angelegt | ✅ Tunnel funktioniert (HTTP 302) | — |
| 6 | Skill `vtol-experte` erweitert (5 neue Sektionen) | ✅ lokal, 15 KB, 19 Sektionen | — |
| 7 | `Drohnenklasse_C0_bis_C6.md` erstellt | ✅ gepusht | Commit `73933be` |
| 8 | `ConOps-Quickstart.md` erstellt | ✅ gepusht | Commit `3628742` |
| 9 | `XFLR5-Profil-Vergleich-Input.md` erstellt | ✅ gepusht | Commit `3628742` |
| 10 | Telegram-Bot-Polling-Konflikt Vorfall analysiert | ✅ Protokoll erstellt | Commit `1d4fe93` |
| 11 | Sidecar-Health-Check implementiert (`--force` Flag) | ✅ Live-getestet, blockiert standardmäßig | Commit `9a07c9e` |
| 12 | `SIDECAR-INSTALL.md` mit Health-Check-Doku ergänzt | ✅ gepusht | Commit `50262b8` |
| 13 | Skill `no-schluss-fragen` angelegt (Niemals "Schluss?" fragen) | ✅ lokal | — |

## Offene Punkte

| # | Was | Status |
|---|---|---|
| Hauptbot auf Webhook umstellen | Langfristige Lösung Sidecar-Konflikt, **nicht kurzfristig** | ⚠️ offen |
| Memory-Konsolidierung | Memory 4.252/2.200 (193 % überfüllt) | ⚠️ blockiert (vom Tool) |
| Repo-Review | einmaliger Reminder-Cronjob am **30.09.2026 10:00 MESZ** | ⏳ geplant |
| GH-Cleaning-Reminder | wöchentlich **Freitag 11:30 MESZ** | ⏳ läuft |
| GitHub-PAT läuft ab | **22.12.2026** (90 Tage) — Reminder kommt | ⏳ |

## Sidecar — Wann manuell starten

```bash
ssh hermes-vps
python3 /home/hermes/telegram_sidecar.py --force
# ... wenn fertig:
# Ctrl+C
```

Nur wenn du aktiv vom Handy "speichere X" schicken willst. Sonst ignorieren.

## Aktueller VPS-Status

- Container-Hauptbot: ✅ läuft (PID 11255, seit 20:25)
- Sidecar: ⏸️ gestoppt (manuell starten wenn nötig)
- Telegram-Token: ✅ funktioniert (Push OK)
- 9+ Cronjobs: ✅ alle aktiv

## Versions-Verweise

- Letzter Commit: `50262b8` (docs(sidecar): Health-Check-Verhalten dokumentieren)
- Branch: `main`
- Default-Tunnel-Port: dynamisch (32768–32770 beobachtet, 32769 aktuell)
