# 💰 Kosten-Realität für VTOL-Hersteller (Verkäufer-Pfad)

> **Ehrliche Aufschlüsselung aller Kosten**, die auf dich zukommen, um das VTOL marktreif zu bekommen.
> Stand: 2026-09-22 — aktualisiere wenn Werte sich ändern.

---

## 🎯 Übersicht — wo liegen die €€€?

Es gibt **drei große Blöcke**, die du trennen musst:

| Block | Was | Wann | Niedrig | Mittel | Hoch |
| ------- | ----- | ------ | -------- | -------- | ------ |
| **Block A** | CAD + Engineering | laufend | €500 | €1.5k | €3k |
| **Block B** | Prototyp + Werkstatt | 0-6 Monate | €13k | €30k | €53k |
| **Block C** | Regulatorik + Recht | 6-12 Monate | €10k | €24k | €48k |
| **Block D** | Versicherung (laufend) | ab Verkauf | €1.2k/Jahr | €2.5k/Jahr | €4.5k/Jahr |

| **TOTAL Initial** | | | **~€24k** | **~€58k** | **~€108k** |
|---|---|---|---|---|---|

---

## 📦 Block A: CAD und Engineering-Software

| Posten | Was | Wann | Niedrig | Mittel | Hoch |
| -------- | ----- | ------ | -------- | -------- | ------ |
| **Fusion 360** (Standard-Lizenz) | CAD/CAM/FEM | dauerhaft | €500/Jahr | €600/Jahr | €1.500/Jahr (höhere Stufe) |
| **XFLR5** | Profil-Analyse | dauerhaft | €0 (kostenlos) | €0 | €0 |
| **OpenVSP** | Konzept-Geometrie | dauerhaft | €0 | €0 | €0 |
| **MATLAB + Simulink** (optional, FEM) | numerische Tools | bei Bedarf | €0 | €1.000 | €3.000 |
| **Git** + **GitHub** | Versionsverwaltung | dauerhaft | €0 | €0 | €0 |
| **Cura / PrusaSlicer** | 3D-Druck-Slicer | dauerhaft | €0 | €0 | €0 |

**Block A Zwischensumme:** €500 – €3k einmalig + ca. €500-1.500/Jahr laufend

---

## 🔧 Block B: Werkstatt + Prototyp

### B.1 Werkstatt-Equipment (einmalig)

| Equipment | Preis |
| ----------- | ------- |
| **3D-Drucker** (z.B. Bambu Lab X1E, Prusa MK4) | €800 – €2k |
| **Lötstation** + Zubehör | €150 – €500 |
| **Multimeter + Oszilloskop** | €200 – €2k |
| **Schraubstock + Bohrmaschine** | €200 – €1k |
| **Schraubendreher-Sortiment** | €50 – €200 |
| **CFK-Werkstatt** (Vakuumpumpe, Harz, Pinsel) | €1k – €5k |
| **Dremel / Schleifer** | €100 – €500 |
| **Lackierkabine klein** (optional, für Finish) | €0 – €2k |

**B.1 Zwischensumme:** €2.5k – €13.2k (einmalig)

### B.2 Material-Prototyp 1 (ein Prototyp)

| Material | Was | Niedrig | Mittel | Hoch |
| ---------- | ----- | -------- | -------- | ------ |
| **CFK-Gewebe** (T800) | 1-3 Lagen je Fläche | €1k | €3k | €6k |
| **Schaumkern / Nomex-Waben** | Sandwich-Kern | €500 | €2k | €5k |
| **Epoxid-Harz + Härter** | + 50% Sicherheit | €300 | €1k | €2k |
| **Vakuum-Folie + Breaker** | Vakuum-Infusion | €300 | €800 | €2k |
| **3D-Druck-Material** (Formen) | PETG / PA-CF | €300 | €1k | €2k |
| **CNC-geführte Rippen** (extern vergeben) | Rippen, Holme | €500 | €5k | €10k |
| **Holme CFK-Rohr** | vorgefertigt | €200 | €1k | €2k |
| **Servos / Stellmotoren** (für Klappen/Trim) | mehrere | €200 | €500 | €1k |
| **Flight Controller** (Pixhawk, etc.) | Steuerung | €200 | €500 | €1k |
| **ESC** (Electronic Speed Controller) | × 5 (4 Hub + 1 Pusher) | €300 | €700 | €1.5k |
| **Motoren** (z.B. T-Motor) | × 5 | €1k | €4k | €8k |
| **Propeller** (Klappprop Pusher, Hub-Props) | Set | €300 | €1k | €3k |
| **Akku 14S4P** (selbst gebaut, Molicel) | 2 Akkus zur Reserve | €800 | €2k | €5k |
| **GPS + Kompass + Magnetometer** | Sensoren | €100 | €300 | €700 |
| **Telemetrie** (z.B. Sik Radio) | Funk | €100 | €200 | €500 |
| **Empfänger** (RC) | Haupt-Funk | €50 | €150 | €400 |
| **Verkabelung + Stecker** | Stromverteilung | €100 | €300 | €700 |
| **LED-Stripes** (vorne/hinten) | Pflicht CE | €50 | €150 | €300 |
| **Fallschirm** (ASTM F3322) | Pflicht empfohlen | €500 | €1k | €2k |
| **Datenlogger + Black-Box** | Black-Box | €100 | €300 | €1k |
| **Schrauben / Kleinteile** | Befestigung | €200 | €500 | €1k |

**B.2 Zwischensumme (1 Prototyp):** €6.1k – €43.1k

### B.3 Verschleiß + Unerwartetes

| Posten | Kosten |
| -------- | -------- |
| **Reparatur-Set** (Crash + Verbrauch) | €300 – €1k |
| **Werkstatt-Betriebskosten** (Strom, Wasser, Verschleiß) | €500 – €2k |
| **Verschiedenes** (Schutzbrillen, Handschuhe, Absaugung) | €200 – €500 |

**B.3 Zwischensumme:** €1k – €3.5k

### **Block B GESAMT:** €9.6k – €59.8k

---

## 📋 Block C: Regulatorik + Recht

### C.1 Regulatorische Compliance (C3-Klasse)

| Posten | Wer | Niedrig | Mittel | Hoch |
| -------- | ----- | -------- | -------- | ------ |
| **C3-Konformitätsbewertung** | intern | €0 | €2k | €6k |
| **EMV-Test** (elektromagnetische Verträglichkeit) | externes Labor | €2k | €4k | €7k |
| **Funk-Konformitätstest** (RED-Richtlinie) | externes Labor | €1k | €3k | €6k |
| **Akustik-Test** (85 dB) | eigenes Equipment | €200 | €500 | €2k |
| **Mechanische Tests** (Schock, Vibration, Fall) | eigenes + extern | €500 | €2k | €5k |
| **Akkusicherheits-Test** (UN-38.3) | externes Labor | €2k | €5k | €10k |
| **Notified-Body-Audit** (falls relevant) | Zertifizierer | €3k | €6k | €12k |

**C.1 Zwischensumme:** €8.7k – €48k

### C.2 Dokumentation

| Posten | Wer | Niedrig | Mittel | Hoch |
| -------- | ----- | -------- | -------- | ------ |
| **Bedienungsanleitung** (DE+EN) | du / extern | €1k | €3k | €8k |
| **Wartungs-Plan** | du | €200 | €500 | €1k |
| **Risiko-Analyse (FMEA)** | du / Berater | €0 | €2k | €8k |
| **SORA-Vorlage** | du (selbst) | €0 | €1k | €3k |
| **Testberichte zusammenstellen** | du | €200 | €500 | €2k |
| **CE-Konformitäts-Erklärung** | du / Anwalt | €100 | €500 | €2k |

**C.2 Zwischensumme:** €1.5k – €24k

### C.3 Rechtliches

| Posten | Kosten |
| -------- | -------- |
| **Rechtsbeistand für AGB** | €2k – €8k |
| **Produkthaftpflicht-Versicherung** (Initial + Jahr 1) | €500 – €2.000 |
| **Berufshaftpflicht-Versicherung** (Initial + Jahr 1) | €300 – €1k |
| **Inhaltsversicherung Werkstatt** | €400 – €1.5k |

**C.3 Zwischensumme:** €3.2k – €12.5k

### **Block C GESAMT:** €13.4k – €84.5k

---

## 🔁 Block D: Laufende Kosten (ab Verkauf)

| Posten | Niedrig | Mittel | Hoch |
| -------- | -------- | -------- | ------ |
| **Produkthaftpflicht** (jährlich) | €500 | €1.000 | €2.000 |
| **Berufshaftpflicht** | €300 | €600 | €1.000 |
| **Inhaltsversicherung Werkstatt** | €400 | €800 | €1.500 |
| **Wartung Software / Lizenzen** | €500 | €1.000 | €3.000 |
| **Wartung Werkstatt** | €200 | €500 | €1.000 |
| **Kundensupport / Hotline** | €0 (du selbst) | €1.000 | €5.000 |

**Block D (laufend):** €1.9k – €13.5k/Jahr

---

## 📊 Konsolidierte Gesamtaufstellung

### Initiale Investition (Monate 0-12)

| Szenario | Was du tust | Gesamt |
| ---------- | ------------- | -------- |
| **🏠 Hobby-Phase** | alles selbst, kein Anwalt, eigene Tests | **€24k** |
| **🔧 Pragmatisch** | einige externe Tests, eigene Doku | **€58k** |
| **🏢 Semi-professionell** | Berater, alle externen Tests | **€108k** |
| **🏭 Professionell** | mit Notified Body + Anwalt | **€140k+** |

### Zeitliche Verteilung

| Phase | Monate | Kosten |
| ------- | -------- | -------- |
| **Phase 1: Konzept + CAD** | 1-3 | ~€1k (deine Zeit + Tools) |
| **Phase 2: Prototyp 1** | 3-6 | ~€10k |
| **Phase 3: Test-Flüge** | 6-8 | ~€2k |
| **Phase 4: Prototyp 2** | 8-11 | ~€8k |
| **Phase 5: Compliance** | 11-15 | ~€12k |
| **Phase 6: Doku + Recht** | 15-18 | ~€3k |
| **Phase 7: Marketing + Vertrieb** | 18-24 | ~€3k |

---

## 🤝 Strategische Hinweise

### 💡 Cashflow-Optimierung

| Tipp | Spart dir |
| ------ | ---------- |
| **Eigene Tests** (soweit möglich) | EMV ~€2-4k |
| **Anwalt nur für AGB** (nicht für alles) | ~€5k |
| **Marketing-Inhalte selbst** (GitHub-Pages) | ~€5k |
| **1 statt 3 Prototypen** (iterativ statt parallel) | ~€10-20k |
| **Crowdfunding-/Vorbestellungen als Pre-Sale** | Working Capital |

### 🎯 Realistische Empfehlung

Wenn du **€30k** in der Tasche hast, kannst du starten. Wenn du **€80k** willst, musst du Investor suchen oder Förderung.

**Realistischer Mittelweg:** ~€50-70k als „Bootstrap-Phase 1" + ggf. Folge-Investition nach Prototyp-Test.

---

## 🚨 Was noch nicht in der Rechnung ist

| Posten | Warum nicht inkludiert |
| -------- | ---------------------- |
| **Deine eigene Lebenshaltung** | das ist eine andere Rechnung |
| **Steuerberater** | ab Gewerbeanmeldung |
| **Gewerbeanmeldung** | ~€30-100 (Stadt, je nach Gemeinde) |
| **Firmen-Logo + Branding** | kannst du erstmal selbst |
| **Webseite** | GitHub-Pages ist kostenlos |
| **Buchhaltung** | ab Umsatz |
| **Kunden-Service** | anfangs du selbst |
| **Lager-Kosten** | nur wenn du Vor-Ort verkaufst |

---

## 📂 Bezug zu Original-Dokumenten

| Was | Wo nachlesen |
| ----- | -------------- |
| **C3-Anforderungen** | EU-VO 2019/945, Annex |
| **SORA-Vorlage** | JARUS SORA 2.5 Main Body |
| **EMV-Anforderungen** | EU-VO 2019/945, ETSI EN 303 358 |
| **Akkus** (UN-38.3) | UNECE Manual of Tests and Criteria |
| **Fallschirm** (ASTM F3322) | <https://www.astm.org/f3322-22.html> |

---

*Letzte Aktualisierung: 2026-09-22. Werte sind Schätzungen — validiere mit Lieferanten / Test-Labors, bevor du buchst.*
