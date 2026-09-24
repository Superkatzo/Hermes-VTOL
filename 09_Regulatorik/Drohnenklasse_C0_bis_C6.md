# EASA Drohnenklassen (C0–C6) — Übersicht & Hermes-VTOL-Zuordnung

> **Zweck:** Schnellreferenz für die Klassifizierung von Hermes-VTOL nach EU-Verordnung 2019/945 + 2019/947.
> **Stand:** September 2026
> **Quelle:** EASA Opinion No 05-2019 (Einführung C5/C6), EU-Durchführungsverordnung 2019/947

---

## Überblick: Die 7 Klassen (C0–C6)

Die EU-Drohnenregulierung unterscheidet **7 Klassen**, gestaffelt nach MTOM, Geschwindigkeit und Betriebsart. **C0–C4** fallen unter die **Open Category** (kein LBA nötig), **C5–C6** unter **Specific Category mit Standard-Szenarien** (STS-01 / STS-02).

| Klasse | Max MTOM | Max Speed | Char. Dimension | Betrieb | Erforderlich |
| --- | --- | --- | --- | --- | --- |
| **C0** | < 250 g | – | – | Open, keine Reg. | CE + Klasse-C-Label |
| **C1** | < 900 g | 19 m/s | – | Open, A1/A3 | CE + Klasse-C-Label |
| **C2** | < 4 kg | – | – | Open, A1/A2/A3 | CE + Klasse-C-Label + Mode-Switch |
| **C3** | **< 25 kg** | – | **≤ 3 m** | Open, A3 + Declaration | CE + Klasse-C-Label |
| **C4** | < 25 kg | – | ≤ 3 m | Specific (begrenzt) | CE + Klasse-C-Label |
| **C5** (STS-01) | < 25 kg | – | – | Specific BVLOS ≤ 2 km | CE + STS-01-Declaration |
| **C6** (STS-02) | < 25 kg | ≤ 50 m/s | – | Specific BVLOS erweitert | CE + STS-02-Declaration |

---

## Welche Klasse passt zu Hermes-VTOL?

Hermes-VTOL-Spezifikation (Lastenheft v1.1):

- MTOM: **16 kg**
- Wingspan: **≤ 2 m** (char. Dimension ≤ 3 m)
- Max Speed: **~30 m/s** (mit Pusher)
- Use-Cases: SAR, Wildschutz, Behörden, Vermessung

→ Hermes-VTOL passt in **C3 / C5 / C6** je nach Use-Case:

| Use-Case | Klasse | Begründung |
| --- | --- | --- |
| **VLOS in nicht-kontrolliertem Luftraum** (z. B. lokaler SAR-Einsatz auf offenem Feld mit Sichtkontakt) | **C3** | Open Category, nur Declaration |
| **BVLOS bis 2 km** (z. B. automatisierte Wildschutz-Patrol, kurze Vermessungsmissionen) | **C5** (STS-01) | Declaration, alle Anforderungen erfüllt |
| **BVLOS erweitert** (z. B. großflächige SAR-Suche, lange Behörden-Missionen) | **C6** (STS-02) | Declaration + Geo-Caging + FTS |

---

## C3 — Anforderungen (für VLOS-Betrieb)

### Technische Anforderungen

- ✅ MTOM ≤ 25 kg
- ✅ Charakteristische Dimension ≤ 3 m
- ✅ Geo-Caging-Funktion (programmierbare Fluggebietsbegrenzung)
- ✅ Remote-ID (direkt oder über Netzwerk)
- ✅ Datenlink-Health-Monitoring (C2-Loss-Warnung)
- ✅ Schwacher Akku-Warnung + Auto-Landing

### Betriebliche Anforderungen

- ✅ Piloten-Schulung (A3-Subkategorie: Online-Training ausreichend)
- ✅ Versicherung (EU-Halterhaftpflicht, €1,5 Mio Minimum)
- ✅ Remote-ID-Registrierung beim LBA
- ✅ Max Operationshöhe: 120 m / 400 ft AGL

### Hermes-VTOL: alle ✅ (müssen aber im Design verifiziert werden)

## C5 (STS-01) — Anforderungen (für BVLOS ≤ 2 km)

### Zusätzlich zu C3

- ✅ Max Operationshöhe bis 120 m (kann auch >120 m sein, wenn lokal erlaubt)
- ✅ Max BVLOS-Reichweite: **2 km vom Remote-Pilot**
- ✅ Beobachter (VO) ist optional — Piloten-Sichtkontakt nicht zwingend
- ✅ Geo-Caging muss aktiv sein
- ✅ FTS (Flight Termination System) — z. B. Auto-Landing bei C2-Loss
- ✅ M2-Mitigation empfohlen: Fallschirm (optional, aber sinnvoll für Hermes)
- ✅ STS-01-Declaration beim LBA

### Hermes-VTOL: alle ✅ (FTS-Design muss noch in Avionik-Konzept verifiziert werden)

## C6 (STS-02) — Anforderungen (für BVLOS erweitert)

### Zusätzlich zu C5

- ✅ Max BVLOS-Reichweite: **erweitert** (bis zu mehreren km, je nach LBA-Genehmigung)
- ✅ Max Speed: ≤ 50 m/s
- ✅ **Geo-Position-Reporting** des UA muss aktiv sein (für andere Luftraumteilnehmer)
- ✅ Trajectory-Programmierung erforderlich (kein freier Flug)
- ✅ C2-Link muss zusätzlich Signalstärke reporten
- ✅ FTS wie C5

### Hermes-VTOL: alle ✅ (Position-Reporting ist im PX4-Stack standardmäßig verfügbar)

---

## Hermes-VTOL-Design-Anforderungen (aus C6 abgeleitet)

| Funktion | Implementierung | Status |
| --- | --- | --- |
| **Geo-Caging** | PX4-Parameter `GF_ACTION`, `GF_MAX_HOR_DIST`, `GF_MAX_VER_DIST` | ✅ PX4 built-in |
| **FTS** | PX4 FailureInjector + Auto-Landing bei C2-Loss > 5s | ⚠️ zu verifizieren |
| **M2-Mitigation** | Optionaler Fallschirm (z. B. MARS Parachutes MFG-02-RAVEN) | ⚠️ optional, empfohlen |
| **Remote-ID** | PX4 MAVLink RID + externe App/Transmitter | ✅ PX4 unterstützt |
| **Position-Reporting** | MAVLink GLOBAL_POSITION_INT mit ≥ 1 Hz | ✅ PX4 default |
| **Trajectory-Programming** | QGroundControl Mission Plan | ✅ |
| **C2-Link Health** | MAVLink RADIO_STATUS, RSSI-Warning | ✅ |
| **Speed-Limit** | PX4-Parameter `MPC_VEL_MAX` ≤ 50 m/s | ✅ einfach |

---

## Aktueller Markt-Stand (September 2026)

Auf der offiziellen EASA-Liste der **C-klassifizierten Drohnen** ([easa.europa.eu](https://www.easa.europa.eu/en/domains/drones-air-mobility/drones-evtol-designs/drones-eu-operations)) sind:

| Hersteller | Modell | Klasse | Topologie |
| --- | --- | --- | --- |
| CAVOK UAS | CK4 / CK9 / CK25 / CK7-2 | C5/C6 | Multirotor |
| AIR6 SYSTEMS | AIR4 NANO / LIGHT / MICRO | C5/C6 | Multirotor |
| OBJECTIF DRONE PRODUCTION | CHRONOS / ARES / ATLAS / MANTA | C5/C6 | Multirotor |
| DELAIR | UX11 | C6 | Festflügler (KEIN VTOL) |
| DRONE VOLT | Kobra | C3 | Multirotor |
| INNOVADRONE | SURVEYOR / 410 SPECIAL | C5/C6 | Multirotor |

**→ KEIN Quadplane/Tilt-rotor hat aktuell eine C5/C6-Zulassung. Marktchance für Hermes-VTOL.**

---

## Strategische Empfehlung für Hermes-VTOL

### Phase 1: C3-Zertifizierung (kurzfristig, 6-12 Monate)

- Ziel: erstes marktfähiges Produkt mit einfachstem Zertifizierungspfad
- Verkaufsargument: **„Multi-Mission VLOS Quadplane, ready-to-fly C3"**
- Käufer nutzen es zunächst unter Open Category (kein LBA-Aufwand)

### Phase 2: C5 (STS-01) — parallele Entwicklung

- BVLOS bis 2 km: passt zu Wildschutz-Patrol und kleinen SAR-Missionen
- Erfordert FTS + Geo-Caging + STS-01-Declaration beim Käufer

### Phase 3: C6 (STS-02) — **Killer-App für den Markt**

- Erweiterte BVLOS: öffnet großflächige SAR + Vermessungs-Großprojekte
- Differenzierung: **erster Quadplane/Tilt-rotor mit C6 weltweit** (Marktfenster ~2-3 Jahre)
- Erfordert zusätzlich Trajectory-Programming + Position-Reporting

---

## Konsequenz für das Lastenheft

Das Lastenheft v1.1 sollte explizit auf **C5/C6 als Design-Ziel** ausgerichtet sein:

| Lastenheft-Anforderung | Implikation |
| --- | --- |
| Akku-Redundanz | OSO #2 erfüllt |
| IMU-Redundanz (2 Sensoren) | OSO #2 erfüllt |
| GPS-Redundanz (Dual-Antenne) | OSO #2 erfüllt |
| Kompass-Redundanz | OSO #2 erfüllt |
| Wetter-Grenzwerte dokumentiert | OSO #3 erfüllt |
| Wartungs-Logbuch als Bundle | OSO #5 erfüllt |
| Notfall-Landing bei Link-Loss | FTS erfüllt |
| Geo-Caging | C5/C6 erfüllt |

→ **Alle OSO #2-Anforderungen sind in der MTOM-16-kg-Klasse mit Standard-Avionik erreichbar** (PX4 Standard-Stack).

---

## Weiterführende Doku

- **EASA Opinion No 05-2019** — STS-01/STS-02-Einführung, C5/C6-Definition: [EASA Opinion 05-2019 (PDF)](https://www.easa.europa.eu/sites/default/files/dfu/Opinion%20No%2005-2019.pdf)
- **EASA C-Class-Liste** (Live): [easa.europa.eu](https://www.easa.europa.eu/en/domains/drones-air-mobility/drones-evtol-designs/drones-eu-operations)
- **SORA-Schritte-Skelett:** siehe `01_Dokumentation/ConOps-Vorlage-SAR.md` + Skill `vtol-experte` Sektion 13
- **Marktvergleich:** `Marktvergleich_VTOL.md`

---

## Versionsverlauf

| Version | Datum | Änderung |
|---|---|---|
| 1.0 | 2026-09-23 | Initiale Übersicht — 7 Klassen, Hermes-Zuordnung, Marktstand |
