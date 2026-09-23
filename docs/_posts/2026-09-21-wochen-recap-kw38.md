---
layout: post
title: "Wochen-Recap KW 38 2026 — Regulatorik, SORA-Vorlage und Telegram-Monitoring"
date: 2026-09-21 23:59:00 +0200
categories: wochenrecap
excerpt: "Diese Woche: ConOps-Vorlage-SAR.md veröffentlicht, fünf regulatorische Dokumente gesammelt, Telegram-Cron-Monitoring für den VPS aufgesetzt. Plus: Strategie-Wechsel vom Piloten zum Hersteller."
---

# Wochen-Recap KW 38 / 2026

> Eine produktive Woche zwischen regulatorischer Tiefenarbeit und System-Aufbau.

---

## Was diese Woche passiert ist

### Strategie-Wechsel

| Vorher | Nachher |
|--------|---------|
| Selbst fliegen | Drohne **verkaufen** |
| Operator-Pflichten (LBA, Versicherung, Pilotlizenz) | **Hersteller-Pflichten** (CE, Produkthaftung, ConOps-Vorlage) |

Das ändert die Regulatorik grundlegend — ich bin jetzt in der Position, **Dokumentation zu liefern**, die der Käufer braucht.

### 📚 Regulatorik-Tiefenarbeit

Diese Woche habe ich **fünf zentrale Dokumente** gesammelt und durchgearbeitet:

1. **EASA Easy Access Rules für UAS** (~600 Seiten, zentrales Konsolidierungs-Dokument)
2. **EU-VO 2019/947** — Grundverordnung für UAS-Betrieb in Europa
3. **LuftVO** — Deutsche nationale Umsetzung
4. **JARUS SORA 2.5** — Risiko-Analyse-Methodik für Specific Category
5. **EU-VO 2019/945** + **EU-VO 785/2004** + **EU-VO 2021/664** + **FAA Part 107** (in dieser Woche noch)

### 🛡️ ConOps-Vorlage SAR — der Verkaufspunkt

Die **wichtigste Woche-Arbeit**: Eine **„Plug-and-Play"-ConOps-Vorlage** für Search and Rescue (SAR) ist im Repo. Sie ist SORA-2.5-konform und enthält alle 17 OSOs als Checkliste.

```text
Wert für Käufer: Spart 4-8 Wochen Arbeit + €5-10k Berater-Kosten
```

→ [ConOps-Vorlage-SAR.md](https://github.com/Superkatzo/Hermes-VTOL/blob/main/01_Dokumentation/ConOps-Vorlage-SAR.md)

### 💰 Kosten-Realität

Wir haben die Kosten **transparent** aufgeschlüsselt:

| Kategorie | Niedrig | Mittel | Hoch |
|-----------|--------|--------|------|
| **Initial gesamt** | €24k | €58k | €108k+ |
| CAD + Software (laufend) | €500/Jahr | €1.5k/Jahr | €3k/Jahr |
| Versicherungen | €1.2k/Jahr | €2.5k/Jahr | €4.5k/Jahr |

→ [Kosten-Realität](https://github.com/Superkatzo/Hermes-VTOL/blob/main/01_Dokumentation/Kosten-Realitaet.md)

---

## 🛡️ VPS-Telegram-Monitoring

Heute Abend habe ich ein **9-Cronjob-Monitoring-System** aufgesetzt:

| Job | Intervall | Was |
|-----|-----------|-----|
| `check_self_ssh.sh` | 10 min | SSH-Daemon-Status |
| `vps_monitor.sh` | 15 min | Disk, RAM, Load, Backups |
| `check_connectivity.sh` | 30 min | Telegram, GitHub, MiniMax |
| `container_health.sh` | 30 min | Container-Restarts |
| `hermes_health_monitor.sh` | 60 min | Hermes intern |
| `hermes_backup.sh` | täglich 03 UTC | Backup (mit Alert) |
| `check_container_updates.sh` | täglich 04 UTC | Update-Check |
| `morning_briefing.sh` | täglich 10:00 MESZ | Morgens-Nachricht an Telegram |
| `security_monitor.sh` | täglich 23 UTC | SSH-Bruteforce, Fail2Ban |

→ Skripte im [VPS-Config-Ordner](https://github.com/Superkatzo/Hermes-VTOL/tree/main/13_VPS_Config)

Test-Alerts wurden verifiziert — **4 Test-Nachrichten erfolgreich empfangen**.

---

## 🔮 Was als Nächstes kommt

| KW 39 Plan | Was |
|------------|-----|
| **CAD-Phase startet** | Erste Komponenten in Fusion 360 |
| **MySQL-Verschiebung** | VPS-Architektur für Käufer-Vorlagen-API |
| **Newsletter-Wochen-Rhythmus etablieren** | dieser Artikel wird Pattern |
| **Marketing startet** | wenn Komponenten sichtbar werden |

---

## 💭 Persönliche Notiz

Diese Woche ist etwas Entscheidendes passiert: **vom Operator zum Designer/Hersteller**. Das ist nicht nur ein Strategie-Wechsel — es ist ein **Identitäts-Wechsel**.

Vorher: „Wie fliege ich die Drohne sicher?"
Jetzt: „Wie liefere ich ein Produkt, das der Käufer sicher fliegen kann?"

Die ConOps-Vorlage ist mein Verkaufs-Trumpf. Der Kosten-Plan zeigt, dass €24k Eigenkapital realistisch sind. Und die Telegram-Alerts zeigen, dass das ganze System jetzt **24/7 sichtbar** ist.

---

*Morgen-Briefing via Telegram um 10:00 MESZ. Wochen-Rückblick Sonntag-Abend. Bleibt dran.*

<div class="callout-warn">
  <div class="label">Fragen oder Feedback?</div>
  <p style="margin: 0.4rem 0 0;">Issue direkt im <a href="https://github.com/Superkatzo/Hermes-VTOL/issues">GitHub-Repo</a> oder im nächsten Recap.</p>
</div>

**— will, am 21.09.2026**
