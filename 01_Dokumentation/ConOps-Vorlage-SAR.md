# 🚁 ConOps-Vorlage — Search and Rescue (SAR) mit Hermes-VTOL

> **Diese Vorlage ist als Template gedacht.** Der Käufer passt seine Mission-spezifischen Daten an.
> Wenn du sie unverändert nutzt, gilt sie als Grund-ConOps für SAR-Generalist-Einsätze.

---

## 1. Missions-Übersicht

### 1.1 Missions-Name

```
[Missions-Name, z.B. „SAR-Einsatz Südhang 2026"]
```

### 1.2 Organisation

| Feld | Wert |
|-------|------|
| **Operator-Name** | _[Verein / Firma]_ |
| **EU-Operator-Nummer** | _[DE-OP-XXXXX]_ |
| **Land / Bundesland** | _[z.B. Bayern / Oberbayern]_ |
| **Verantwortlicher Pilot-in-Command (PIC)** | _[Name, Fernpilot-Zeugnis-Nr.]_ |

### 1.3 Einsatz-Typen (Mehrfachauswahl)

| Einsatz | Ankreuzen |
|---------|----------|
| Vermisste Person suchen (Wald, Berg) | ☐ |
| Lawinen-Vermisste Person orten | ☐ |
| Hochwasser-Pegel/Reichweiten erfassen | ☐ |
| Waldbrand-Lagebild erstellen | ☐ |
| Wege/Fürze für Hunde-Staffel erkunden | ☐ |
| Sachbeschädigung / Umwelt-Sichtung | ☐ |
| Einsatz-Drohnen-Lagebild an Stabsstelle | ☐ |
| Andere: ___________ | ☐ |

### 1.4 Einsatz-Zeiten

| Wann | Erlaubt? |
|------|----------|
| Tageslicht-Flug | ✅ |
| Sonnenuntergang ± 30 min | ⚠️ nur mit Beleuchtung |
| Nacht (Sonne unter Horizont) | ⚠️ nur mit LBA-Erlaubnis |

### 1.5 Wiederkehr der Mission

| Variante | Häufigkeit |
|----------|-----------|
| **Ad-hoc** | nach Alarm, oft kurzfristig |
| **Geplant** | z.B. 1x pro Woche Training |
| **Bereitschaft** | 24/7-Rufbereitschaft |

---

## 2. Rechtliche Grundlagen

### 2.1 Klasse des Geräts

| Eigenschaft | Wert |
|------------|------|
| **MTOM** | 16 kg |
| **Klasse nach EU-VO 2019/945** | **C3** |
| **Konfiguration** | Quadplane Pusher + 4 Hub |
| **Energie** | 14S4P Li-Ion 6500 mAh @ 325 Wh/kg |
| **Reichweite** | ca. 50 km im Auto-Pilot |
| **Nutzlast** | bis 2,3 kg (Universal-Container) |

### 2.2 Betriebs-Kategorie

| Element | Wert |
|---------|------|
| **EU-Kategorie** | **Specific** (SORA-basiert) |
| **SORA-Analyse (Version)** | JARUS SORA 2.5 |
| **SAIL-Level** | [z.B. SAIL II] |
| **LBA-Genehmigung** | Aktenzeichen, Datum |

### 2.3 Pflichten des Operators

| Pflicht | Status |
|---------|--------|
| **Operator-Registrierung** (LBA) | ✅ / ☐ |
| **Haftpflicht-Versicherung** (mind. 750k SZR) | ✅ / ☐ |
| **LBA-Specific-Cat-Genehmigung** | ✅ / ☐ |
| **Fernpilot-Zeugnis** (A2 STS oder höher) | ✅ / ☐ |
| **SORA-Analyse genehmigt** | ✅ / ☐ |

### 2.4 Behörden-Koordination

| Behörde | Vor Flug zu informieren? |
|---------|--------------------------|
| **LBA (Luftfahrt-Bundesamt)** | bei SORA-relevanten Änderungen |
| **Landesluftfahrtbehörde** (DE-BY = Regierung Oberbayern) | immer |
| **Polizei / Rettungsleitstelle** | bei Einsätzen in deren Bereich |
| **Forst-/Naturschutz** | in Schutzgebieten |
| **Tower / Flugleitung** | bei CTR-Nähe |

---

## 3. Geografische Einsatz-Bereiche

### 3.1 Erlaubte Lufträume

| Bedingung | Erlaubt? |
|-----------|----------|
| **CTR (Kontrollzone Flughafen)** | ❌ ohne Tower-Freigabe |
| **RMZ (Radio Mandatory Zone)** | ⚠️ mit Funk-Kontakt |
| **ED-R (Restricted Areas)** | ❌ |
| **Waldgebiet, Forst** | ✅ ohne Erlaubnis |
| **Offene Felder** | ✅ |
| **Wohngebiet (innerstädtisch)** | ⚠️ nur zur SAR, mit Genehmigung |
| **Nationalparke** | ⚠️ mit Park-Behörde |
| **Höhen über 120 m AGL** | ⚠️ nur mit Befreiung |

### 3.2 Definierte Einsatz-Gebiete

```
[Mission-spezifische Geokoordinaten einfügen]
[z.B. Polygon „Einsatzgebiet Südhang" als GeoJSON-Datei]
```

| Gebiet-Name | Eckpunkte (lat/lon) |
|-------------|---------------------|
| _[Gebiet 1]_ | _[49.123, 11.456 / 49.124, 11.457 / ...]_ |
| _[Gebiet 2]_ | _[...]_ |

---

## 4. Personal

### 4.1 Schlüsselrollen

| Rolle | Person | Qualifikation |
|-------|--------|---------------|
| **Pilot in Command (PIC)** | _[Name]_ | A2 STS oder höher |
| **Visual Observer (VO)** | _[Name]_ | mind. A1/A3 |
| **Mission Commander** | _[Name]_ | SAR-Ausbildung |
| **Drohnen-Techniker** | _[Name]_ | Wartung + Reparatur |
| **Operator-Verantwortlicher** | _[Name]_ | Pflicht lt. EU-VO |
| **Einsatzleiter** (Schnittstelle Rettungsdienst) | _[Name]_ | SAR-Ausbildung |

### 4.2 Personal-Anforderungen

| Anforderung | Pflicht |
|-------------|--------|
| **Fernpilot-Zeugnis A2 STS** | 🔴 |
| **Medizinische Tauglichkeit** (JARUS OSO) | 🔴 |
| **SAR-spezifische Schulung** (Mindesthöhe, Suchmethoden) | 🔴 |
| **Wiederkehr-Training** (mind. 1x jährlich) | 🔴 |
| **Notfall-Training** (Crash am Einsatzort) | 🔴 |

---

## 5. Geräte und Ausrüstung

### 5.1 Hauptdrohne: Hermes-VTOL

| Spezifikation | Wert |
|---------------|------|
| **Hersteller** | [dein Name] |
| **Modell** | Hermes-VTOL Mk.I |
| **MTOM** | 16 kg |
| **Spannweite** | 2,3 m (klappbar) |
| **Antrieb** | 5× BLDC (4 Hub + 1 Pusher) |
| **Akku** | 14S4P Li-Ion (1536 Wh) |
| **Endurance** | 45-60 min |
| **Reichweite Funk** | ~20 km mit C2-Link |
| **Sicherheitsfeatures** | Fallschirm (ASTM F3322), Geo-Fence, Auto-Landing |

### 5.2 Payload

| Standard-Payloads | Optional |
|-----------------|----------|
| **RGB-Kamera** (Tag-Nacht-Sensor) | LiDAR |
| **Thermal-Kamera** (Vermisstenortung) | Multispektral (Waldbrand) |
| **Lautsprecher / Megafon** | SAR-Transponder |
| **Scheinwerfer** (Einsatzstelle) | Handy-Ping-Empfänger |

### 5.3 Bodenstation

| Komponente | Modell / Spezifikation |
|------------|----------------------|
| **Tablet** mit Ground-Control-Software | iPad Pro / Samsung Tab |
| **C2-Funk** (Command-and-Control) | z.B. RFD900, Mobile Mesh |
| **Video-Receiver** für Telemetrie | 5,8 GHz / LTE |
| **Redundante Akkus** | je 30 min Backup |

### 5.4 Wartungs-Equipment

| Werkzeug | Aufgabe |
|----------|---------|
| Multimeter | Spannungs-Test |
| Schraubendreher-Set | Service |
| Ersatz-Props (5 Stück) | Verschleiß |
| Ersatz-Akku (1 Stück) | Reichweiten-Verdopplung |
| Erste-Hilfe-Set | bei Verletzung während Wartung |

---

## 6. Operations

### 6.1 Standard-Mission (Schritt für Schritt)

| Schritt | Was | Verantwortlich |
|---------|-----|----------------|
| **1** | Einsatzauftrag vom Einsatzleiter | Mission Commander |
| **2** | Briefing (Wetter, Gebiet, Gefahren, Rollen) | PIC + Team |
| **3** | Pre-Flight-Check (Drohne, Akku, Funk, Sensor) | Drohnen-Techniker |
| **4** | Behörden-Information (falls nötig) | Operator-Verantwortlicher |
| **5** | Start am Missionspunkt (Vertikal, Quad-Mode) | PIC |
| **6** | Übergang auf Flächenflug (Pusher-Mode) | automatisch |
| **7** | Such-Systematik (siehe Abschnitt 6.2) | PIC + VO |
| **8** | Daten-Live-Stream an Einsatzleiter | automatisch |
| **9** | Bei Fund: Position an Rettungsdienst | PIC |
| **10** | Rückflug + Auto-Landing | automatisch mit PIC |
| **11** | Post-Flight-Check + Daten sichern | Drohnen-Techniker |
| **12** | Debriefing | alle |

### 6.2 Such-Systematik (SAR-spezifisch)

| Methode | Effizienz | Einsatz-Bedingungen |
|--------|-----------|---------------------|
| **Parallele Bahnen** („Lawn-Mower") | mittel | offenes Gelände |
| **Expandierendes Rechteck** | gut | bekannte POI-Region |
| **Lineare Küsten-/Waldkante** | mittel | Waldbrand-Kante |
| **Tracking eines Handy-Pings** | gut | Person hat Handy |
| **Manuelles Suchen** (Gitterpunkt-für-Punkt) | hoch bei Detail | Thermalkamera-Modus |
| **Thermal-Differenz-Scan** | sehr hoch | in der Nacht oder kalten Suchgebieten |

### 6.3 Kommunikation

| Kanal | Von → An | Inhalt |
|-------|---------|--------|
| **PIC ↔ VO** | direkt (Funk) | Hindernisse, andere Luftfahrzeuge |
| **PIC ↔ Einsatzleiter** | Daten-LTE oder Funk | Fortschritt, Befunde |
| **PIC ↔ Tower** | Funk 5,8 GHz | falls in CTR |
| **Backup-System** | Hand-Funk (PMR/Funk) | bei Daten-Ausfall |

### 6.4 Daten-Management

| Daten-Typ | Speicherort | Aufbewahrung |
|-----------|------------|--------------|
| **Telemetrie (Log)** | SD-Karte Drohne + Cloud | 2 Jahre (Behörden-Audit) |
| **Video-Aufnahmen** | interne SSD Groundstation | so lange für Einsatz nötig, max 30 Tage |
| **Fotos** | Cloud (verschlüsselt) | so lange für Einsatz nötig |
| **Such-Bericht** | als PDF inkl. Karten-Material | 5 Jahre (SAR-Dokumentation) |

### 6.5 Notfall-Szenarien

| Notfall | Reaktion |
|---------|----------|
| **Funkverbindung verloren** | Auto-RTH (Return-to-Home) |
| **GPS verloren** | Manuelle Stabilisierung, sofortige Landung |
| **Akku kritisch (<30%)** | Sofortige Rückkehr |
| **Motor-Ausfall** | Auto-Landing mit Fallschirm |
| **Verletzung an Einsatzort** | Drohne stehen lassen, Rettungsdienst |
| **Person aus Drohne gefallen / Crash** | Sofortige Landung, Bergung, Vorfall-Meldung |
| **Wetter-Verschlechterung** | Abbruch und Landung |

---

## 7. Sicherheits-Plan

### 7.1 SORA-OSO-Checkliste (17 Punkte)

| # | OSO | Status | Maßnahme |
|---|-----|--------|----------|
| 1 | UAS Design + Construction | ✅ | Klasse C3 erfüllt |
| 2 | UAS Maintenance | ✅ | Wartungs-Plan lokal |
| 3 | Manufacturer's Manual | ✅ | Bedienungs-Anleitung |
| 4 | Crew Training | ✅ | A2 STS + SAR-Schulung |
| 5 | UAS Inspection | ✅ | Pre-Flight + Post-Flight |
| 6 | C3 Link Performance | ✅ | C2-Link validiert |
| 7 | UAS Inspection | ✅ | siehe #5 |
| 8 | Operational Procedures | ✅ | diese ConOps |
| 9 | Personnel Training | ✅ | siehe #4 |
| 10 | Safe Recovery | ✅ | Fallschirm ASTM F3322 |
| 11 | Safe Trajectory | ✅ | Geo-Fence + Hindernis-Sensor |
| 12 | Op Risk Assessment | ✅ | diese ConOps + Mission-Risiko |
| 13 | Multi-UAS Coordination | n/a | nur 1 UAS pro Mission |
| 14 | Op Qualifikation | ✅ | Operator-Verantwortlicher zertifiziert |
| 15 | Adverse Conditions | ✅ | Wind-Limit, Regen-Stopp |
| 16 | External Services Coord | ✅ | Rettungsdienst, Polizei, Forst |
| 17 | Emergency Response | ✅ | Abschnitt 6.5 |

### 7.2 Bodenrisiko-Minderung (M1)

| Maßnahme | M1-Typ | Wirkung |
|----------|--------|--------|
| Fallschirm-System | M1 (B) | reduziert iGRC um ~2 Stufen |
| Geo-Fence | M1 (A) | vermeidet bewohntes Gebiet |
| Manuell übersteuerbar | M1 (A) | PIC kann sofort eingreifen |
| Area Survey vor Flug | M1 (A) | Fluggebiets-Aufnahme |

### 7.3 Luftrisiko-Minderung (M2)

| Maßnahme | Wirkung |
|----------|---------|
| Funk-Kontakt mit nahem Tower | reduziert ARC |
| ADSB-Empfänger (sofern Drohne unterstützt) | erkennt bemannte Luftfahrzeuge |
| Fluggebiet <120 m AGL | meist außerhalb kontrollierter Luft |
| Einsatzort-Risiko: Lage, Windrichtung | vermeidet andere UFOs |

### 7.4 Performance-Anforderungen (Robustheits-Level)

| OSO | Level | Begründung |
|-----|-------|------------|
| 1, 3, 5, 6, 7 | **Hoch** | direkt sicherheitsrelevant |
| 2, 4, 8, 9 | **Mittel** | betrieblich wichtig |
| 10, 11 | **Hoch** | direkt sicherheitsrelevant |
| 12, 14, 17 | **Mittel** | koordinations-relevant |

**→ Robustheit ist überwiegend „Mittel". Käufer dokumentiert die Evidenz pro OSO.**

---

## 8. Konfiguration und Spezifikation

### 8.1 Wartungs-Intervalle

| Komponente | Intervall | Aufgabe |
|------------|-----------|---------|
| **Motor-Lager** | jede 50 h | Schmierung, Verschleiß-Check |
| **Propeller** | vor jedem Flug | Sicht-Check + Riss-Check |
| **Akku** | nach jedem Flug | Spannung-Check + Balancing |
| **Fallschirm** | jedes 6 Monat | Packen + Trocken-Test |
| **Firmware-Updates** | monatlich | update + log |
| **Sensorkalibrierung** | vor jedem Flug | Kompass, IMU, Baro |
| **Komplett-Review** | jährlich | Inspektion durch Hersteller |

### 8.2 Spezifikation Drohne

| Element | Wert |
|---------|------|
| **Max Schub pro Motor** | 4,5 kg |
| **Schwebeschub-Bedarf** | ca. 8 kg pro Motor @ 50% Throttle |
| **Pusher-Max-Schub** | 4 kg (Cruise-Flug) |
| **Sensor-Redundanz** | Doppelte IMU, GPS, Kompass |
| **Reichweite Telemetrie** | ~20 km |
| **Akku-Spannungs-Range** | 11,0 - 16,8 V |
| **Sicherheits-Schwelle Akku** | 13,5 V (10%) — RTH-Trigger |
| **Wind-Limit** | 10 m/s (Bayern-Realität) |

---

## 9. Anhänge (zu erstellen)

| Anhang | Inhalt |
|--------|--------|
| **Anhang A** | Karten-Material (Einsatzgebiete als GeoJSON) |
| **Anhang B** | Crew-Liste + Qualifikations-Nachweise |
| **Anhang C** | Drohnen-Wartungs-Logbuch |
| **Anhang D** | SORA-Analyse-Rechnung |
| **Anhang E** | Notfall-Plan (Karten mit Lande-Zonen) |
| **Anhang F** | Behörden-Briefings (an LBA, Polizei) |
| **Anhang G** | Datenschutz-Konzept (DSGVO) |

---

## 10. Versions-Historie

| Datum | Version | Autor | Änderung |
|-------|---------|-------|----------|
| 2026-09-22 | 1.0 | Hersteller | Erst-Version |

---

*Diese Vorlage ist „Plug and Play" — der Käufer passt die []-Werte an, dann ist die ConOps für die SORA-Analyse fertig.*

*SORA-2.5-konform — bei jeder LBA-Anpassung der Regulierung diese Vorlage aktualisieren.*
