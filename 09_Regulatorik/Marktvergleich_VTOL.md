# Marktvergleich VTOL-Festflügler (zivile Plattformen)

> **Zweck:** Benchmarking & Konkurrenzanalyse für die kommerzielle Positionierung von Hermes-VTOL.
> **Stand:** September 2026
> **Preise:** Listen-/Händlerpreise in USD, ohne Sensor-Addons und Schulung. Wo Hersteller "Quote-based" arbeiten, ist eine realistische Bandbreite angegeben.

---

## Inhaltsverzeichnis

1. [Klassifizierung & Vergleichsringe](#klassifizierung--vergleichsringe)
2. [Ring 1 — Direkte Vergleichsklasse (14–25 kg MTOW, Quadplane/Tilt-rotor)](#ring-1--direkte-vergleichsklasse-1425-kg-mtow-quadplanetilt-rotor)
3. [Ring 2 — Kommerzielle Mapping/SAR-Standards (1,0–1,3 m Wingspan)](#ring-2--kommerzielle-mappingsar-standards-1013-m-wingspan)
4. [Ring 3 — DIY/Open-Source-Quadplanes (Bauweise-Referenzen)](#ring-3--diyopen-source-quadplanes-bauweise-referenzen)
5. [Detail-Vergleichsmatrix nach Architekturparametern](#detail-vergleichsmatrix-nach-architekturparametern)
6. [Zulassungs-Übersicht (EASA C-Class, SORA/PDRA, FAA)](#zulassungs-übersicht-easa-c-class-sorapdra-faa)
7. [Preis-Bänder & Marktpositionierung für Hermes-VTOL](#preis-bänder--marktpositionierung-für-hermes-vtol)
8. [Architektur-Anleihen für Hermes-VTOL](#architektur-anleihen-für-hermes-vtol)
9. [Alleinstellungsmerkmale (USPs) gegenüber dem Markt](#alleinstellungsmerkmale-usps-gegenüber-dem-markt)
10. [Quellen](#quellen)

---

## Klassifizierung & Vergleichsringe

Hermes-VTOL liegt mit seiner Spezifikation (Lastenheft v1.1) bewusst in einer **Nische zwischen drei kommerziellen Klassen**:

- **Tiefer** als professionelle Mapping-VTOLs (Wingtra, eBee X) — aber mit deutlich mehr Payload und Modularität.
- **Höher** als Hobby-DIY-Quadplanes — aber mit ziviler Zulassungs-Perspektive.
- **Konkurrenz-Klasse:** Mittelklasse-VTOL (14–25 kg MTOW, Quadplane, Multi-Mission).

Die Vergleichsringe sind deshalb so gewählt, dass Hermes-VTOL entweder direkter Wettbewerber ist (Ring 1), oder dasselbe Käufersegment bedient (Ring 2), oder als technische Referenz dient (Ring 3).

---

## Ring 1 — Direkte Vergleichsklasse (14–25 kg MTOW, Quadplane/Tilt-rotor)

| Modell | Hersteller | Wingspan | MTOW | Payload | Endurance (leer / max payload) | Range | Cruise Speed | Wind-Toleranz | IP | Topologie | **Preis (USD, ca.)** | Quelle |
|---|---|---|---|---|---|---|---|---|---|---|---|---|
| **DeltaQuad Evo** | DeltaQuad (NL) | 2,69 m | 10 kg | 3 kg (dual bay) | 4,5 h / ~2 h | **270 km** | 16,5 m/s (60 km/h) | 12,5 m/s TO/L, 14 m/s cruise | n/a (Drizzle 7 mm/h) | Quadplane, dual-boom, CFK | Quote (Enterprise, >$50k) | [deltaquad.com/evo](https://www.deltaquad.com/products/evo) |
| **T-DRONES VA23** | T-DRONES / T-Motor (CN) | 2,30 m | 12,5 kg | 2,5 kg | 4 h / 3 h (1,5 kg) | 240 km | 18–20 m/s | "Level 5" (≈10 m/s) | n/a | Quadplane, CFK | **$8.000–12.000** (Händler) | [t-drones.com/VA23](https://www.t-drones.com/product/VA23.html) |
| **Autel Dragonfish Lite** | Autel (CN/US) | 1,60 m | 5,5 kg | 1,0 kg | 81 min / 75 min | 30 km | bis 30 m/s | 15 m/s (FW) / 12 m/s (MR) | **IP43** | Tilt-rotor, CFK | **$22.000–30.000** | [autelrobotics.com/dragonfish](https://www.autelrobotics.com/productdetail/dragonfish-series-drones/) |
| **Autel Dragonfish Standard** | Autel | 2,30 m | 9 kg | 1,5 kg | 126 min / 107 min | 30 km | bis 30 m/s | 15 m/s (FW) / 12 m/s (MR) | **IP43** | Tilt-rotor, CFK | **$45.000–70.000** | s. o. |
| **Autel Dragonfish Pro** | Autel | 2,98 m | 19 kg | 2,2 kg (max 2,5 kg) | 179 min / 158 min | 30 km | bis 30 m/s | 15 m/s (FW) / 12 m/s (MR) | **IP43** | Tilt-rotor, CFK | **$99.000+** | s. o. |
| **JOUAV CW-15** | JOUAV (CN) | 3,54 m | 15 kg | 3 kg | 180 min / 120 min | 100 km | 61 km/h (17 m/s) | 10,8–13,8 m/s | **IP54** | Quadplane | **~$40.000** | [jouav.com/cw-15](https://www.jouav.com/products/cw-15.html) |
| **JOUAV CW-20E** | JOUAV | 2,30 m | ~25 kg | 6 kg | ~3 h | 200 km | bis 90 km/h | 13,9 m/s sustained | **IP54** | Quadplane | Quote (Enterprise) | [jouav.com/cw-20e](https://www.jouav.com/products/cw-20e.html) |

### Detail-Notizen Ring 1

- **DeltaQuad Evo:** Längste Endurance/Reichweite aller zivilen Quadplanes. Semi-Solid-State-Li-Ion (6S, 22 Ah pro Akku). PX4-basierter Autopilot. Open-Source-Architektur. Varianten: Enterprise (zivil), Tactical (Defense).
- **T-DRONES VA23:** Günstigste Plattform in dieser Klasse. 12S 22–30 Ah Akku-Empfehlung. Schnellverschluss-Design ("Quick-assembly"). Dual-Circuit Servo-Power für Safety.
- **Autel Dragonfish-Serie:** Drei Größen (Lite/Standard/Pro). 5-Minuten-Setup. Autel-eigenes Voyager-GCS, NICHT PX4/ArduPilot. Payload-Schnellverschluss. Redundanz für Akku/IMU/Barometer/Kompass/RTK/GPS.
- **JOUAV CW-15:** Sehr lange Endurance bei moderatem Preis. Wind-Toleranz bis 13,8 m/s. Positioniergenauigkeit 1 cm H + 3 cm V (PPK/RTK). Phase-One-iXM-Kameras optional (sehr teuer).

---

## Ring 2 — Kommerzielle Mapping/SAR-Standards (1,0–1,3 m Wingspan)

| Modell | Hersteller | Wingspan | MTOW | Payload | Endurance | Range | Cruise | Wind | **Preis (USD)** | Topologie | Quelle |
|---|---|---|---|---|---|---|---|---|---|---|---|
| **WingtraOne Gen II** | Wingtra (CH) | 1,25 m | 4,8 kg | 0,8 kg | 59 min | 10 km | 16 m/s | 12 m/s sustained | **$20.000–29.000** | Tailsitter (transition durch Kippe) | [wingtra.com](https://wingtra.com) |
| **WingtraRAY** | Wingtra | n/a | ~5 kg | MAP61 int. | 59 min | 10 km | 16 m/s | 12 m/s | **$90.000–120.000+** | Tailsitter | [Wingtra VTOL-Drone-Seite](https://wingtra.com/vtol-drone/?srsltid=AU7gw4UnDWTUYnZr6wkymOrAfef5WfmoHvpuMpUEBu5Rvi06iWbmRB3x) |
| **senseFly eBee X** | AgEagle / senseFly (CH/US) | 1,16 m | 1,6 kg | 0,8 kg | 90 min | 8 km | 11–30 m/s | 12,8 m/s | **$15.000–20.000** | Hand-launch / belly-land (KEIN VTOL!) | [sensefly.com](https://www.sensefly.com/solutions/drones) |
| **senseFly eBee TAC** | AgEagle / senseFly | 1,16 m | 1,6 kg | 0,8 kg | 90 min | 8 km | 11–30 m/s | 12,8 m/s | **$15.000+** (Blue UAS, NDAA) | s. o. | [ageagle.com](https://ageagle.com/drones/ebee-tac/) |
| **Quantum-Systems Trinity Pro** | Quantum-Systems (DE) | 2,30 m | ~5 kg | 0,8 kg | 90+ min | 100 km corridor | n/a | n/a | **~$22.000** | Tailsitter mit Klappflächen | [dronetrader Vergleich](https://blog.dronetrader.com/vtol-vertical-take-off-and-landing-hybrid-drones-available-for-sale) |
| **DeltaQuad Pro** | DeltaQuad (NL) | 2,35 m | 6,2 kg | 1,2 kg | 110 min | 100 km | 16–18 m/s | n/a | **$12.000–17.000** | Quadplane (delta-wing) | [deltaquad.com](https://www.deltaquad.com/) |

### Detail-Notizen Ring 2

- **WingtraOne Gen II:** Schweizer Premium-Mapping-Drohne. Sehr ausgereifte Software (WingtraPilot + PPK/RTK). Schwacher Punkt: nur 800 g Payload, daher keine flexiblen Mission-Module möglich.
- **WingtraRAY:** Wingtra-Flaggschiff, MAP61-Kamera integriert, extrem teuer — eher Enterprise-/Behördenkunden.
- **senseFly eBee X:** Festflügler ohne VTOL — Handstart und Bauchlandung. 90 min Endurance bei 1,6 kg. NDAA/Blue-UAS-konform → relevant für US-Behördenverkauf.
- **Quantum Trinity Pro:** Deutscher Hersteller, sehr gute Endurance bei moderatem Preis, Klappflügel-Design für Transport. Wichtig als **heimischer Wettbewerber** im DACH-Raum.
- **DeltaQuad Pro:** Günstigste professionelle VTOL mit ArduPilot/Open-Source. Varianten: #MAP, #VIEW, #CARGO — bereits Mission-Segmentierung eingeführt.

---

## Ring 3 — DIY/Open-Source-Quadplanes (Bauweise-Referenzen)

| Plattform | Wingspan | MTOW | Flight Controller | Quelle |
|---|---|---|---|---|
| **PX4 Quadplane-Reference** | 1,2 m | ~3 kg | Pixhawk + PX4 | [discuss.px4.io/37557](https://discuss.px4.io/t/4-1-vtol-drone-1-2-meter-wingspan-looking-for-feedback/37557) |
| **Quanum-Observer Quadplane (Instructables)** | 2,0 m | 4,8 kg | Pixhawk APM 3.6 | [instructables.com](https://instructables.com/id/Quadplane-Hybrid-Drone) |
| **FX-79 Buffalo QuadPlane Conversion** | 2,0 m | ~5 kg | APM / Pixhawk | [discuss.ardupilot.org/34493](https://discuss.ardupilot.org/t/fx-79-buffalo-quadplane-conversion-part-2/34493) |
| **Lidl-Glider VTOL Plane (Basement Creations)** | 0,85 m | Hobbyklasse | Speedybee F405 Wing | [printables.com/1129488](https://printables.com/model/1129488-lidl-glider-vtol-plane) |
| **Zbotic VTOL-Build-Guide** | 1,5–2,0 m (empfohlen) | ~3 kg (Beispiel) | Pixhawk + ArduPlane | [zbotic.in/how-to-build-a-vtol-drone](https://zbotic.in/how-to-build-a-vtol-drone-fixed-wing-meets-multirotor) |

### Detail-Notizen Ring 3

- **PX4 4+1 VTOL Diskussion (1,2 m wingspan):** Direkt vergleichbare Architektur — Twin-Boom mit Inverted-V-Tail, 4 Hover-Motoren + 1 Pusher, CFK-Tube + Foam. Sehr gute Thread-Diskussion für Design-Feedback.
- **Quanum-Observer:** Vollständig dokumentierter DIY-Quadplane-Build mit Pixhawk-Autopilot. 2 m Wingspan → exakt in Hermes-VTOL-Klasse. Foam + CFK-Spars.
- **FX-79 Buffalo:** 2 m Fläche, kommerzielle Hobby-Schaum-Flieger als Basis. Foxtech Hover-1 Folding Landing Gear Kit als Vier-Punkt-Landegestell.
- **Lidl-Glider VTOL:** Sehr leicht, Ardupilot-basiert, kleine Klasse — dient nur als Tuning-Referenz für Transitionslogik.
- **Zbotic-Guide:** Empfohlene Mindest-Wingspan 1,2 m, Idealklasse 1,5–2,0 m. Wing-Loading 20–35 g/dm² empfohlen. Hub-Motoren je 150–300 W, total ~1.200 W für 3 kg-Klasse (2× Hover-Thrust-Margin).

---

## Detail-Vergleichsmatrix nach Architekturparametern

### Akku- und Energie-Daten

| Modell | Akku-Typ | Konfiguration | Wh | Flugzeit ohne Payload | Flugzeit mit Payload | Ladezeit |
|---|---|---|---|---|---|---|
| **DeltaQuad Evo** | Semi-Solid-State Li-Ion | 6S, 22 Ah (×2) | ~270 Wh/Akku | 272 min | 110 min (1 kg) | n/a |
| **T-DRONES VA23** | LiPo / Li-Ion | 12S 22–30 Ah | ~880–1200 Wh | 240 min | 180 min (1,5 kg) | n/a |
| **Autel Dragonfish Lite** | Smart-Battery Li-Ion | n/a | 277 Wh (1×) | 81 min | 75 min (1 kg) | 120 min |
| **Autel Dragonfish Standard** | Smart-Battery Li-Ion | 2× | 554 Wh | 126 min | 107 min (1,5 kg) | 120 min |
| **Autel Dragonfish Pro** | Smart-Battery Li-Ion | 2× | 1.645 Wh | 179 min | 158 min (2,2 kg) | 120 min |
| **JOUAV CW-15** | Li-Ion | n/a | n/a | 180 min | 120 min (3 kg) | n/a |
| **WingtraOne Gen II** | Smart Li-Ion | 2× 99 Wh | 198 Wh (UN3481) | 59 min | 55 min (0,8 kg) | n/a |
| **senseFly eBee X** | Li-Ion | intern | ~70 Wh | 90 min (Endurance-Ext.) | 60 min | n/a |

### Betriebstemperatur & Schutzklassen

| Modell | Operating Temp | IP-Rating | Wind-Toleranz sustained | Wind-Toleranz Böen |
|---|---|---|---|---|
| **DeltaQuad Evo** | −20 °C bis +45 °C | nicht spezifiziert | 12,5 m/s | 14 m/s cruise |
| **T-DRONES VA23** | −10 °C bis +40 °C | n/a | "Level 5" (~10 m/s) | n/a |
| **Autel Dragonfish alle** | −20 °C bis +50 °C | **IP43** | 15 m/s (FW) | n/a |
| **JOUAV CW-15** | −20 °C bis +50 °C | **IP54** | 10,8 m/s | 13,8 m/s |
| **WingtraOne Gen II** | −10 °C bis +40 °C | nicht spezifiziert | 12 m/s | 18 m/s (Böen beim Start) |
| **senseFly eBee X** | n/a | n/a | 12,8 m/s | n/a |

### Autopilot & Software-Stack

| Modell | Autopilot | GCS | Open-Source? | SDK / API |
|---|---|---|---|---|
| **DeltaQuad Evo/Pro** | PX4 (Pixhawk-Ökosystem) | QGroundControl | Ja (PX4) | MAVLink |
| **T-DRONES VA23** | PX4 / Ardupilot-kompatibel | QGroundControl | Ja | MAVLink |
| **Autel Dragonfish** | Autel-eigener FC | Autel Voyager | **Nein** (Closed) | Autel-API |
| **JOUAV CW-15** | Eigenentwicklung | FlightSurv / EagleMap | **Nein** | Jocloud-API |
| **WingtraOne** | Eigenentwicklung | WingtraPilot | **Nein** | Eingeschränkt |
| **senseFly eBee X** | Eigenentwicklung | eMotion | **Nein** | Eingeschränkt |
| **Quantum Trinity Pro** | PX4 / Ardupilot | QGroundControl | Ja (PX4/AP) | MAVLink |

### Payload-Optionen

| Modell | Payload-Bay | Standard-Sensoren | Thermal | Multi-Spectral | LiDAR |
|---|---|---|---|---|---|
| **DeltaQuad Evo** | 20 × 20 × 11 cm, dual | EO/IR-Kombinationen, 61MP Sony A7R IV | Ja (gimbal) | Ja | Ja (verschiedene) |
| **T-DRONES VA23** | n/a spezifiziert | Kameras, Gimbal | optional | optional | optional |
| **Autel Dragonfish** | Schnellverschluss (toolless) | L20T (4K + Thermal + LR), L50T | Ja | Nein (Standard) | Lidar-Optionen |
| **JOUAV CW-15** | modular | Phase-One iXM, CA-103, MG-120E Gimbal | Ja (MG-120E) | Ja (X20P Hyperspectral) | Ja (1845 m range) |
| **WingtraOne** | fest verbaut | Sony RX1R II, Aeria X, RedEdge | Nein (RGB only) | Ja (RedEdge) | Ja (LiDAR) |
| **senseFly eBee X** | fest verbaut | S.O.D.A. 3D, Aeria X, Duet T | Ja (Duet T) | Ja (Sequoia+) | Nein |

---

## Zulassungs-Übersicht (EASA C-Class, SORA/PDRA, FAA)

### EASA C-Class-Kennzeichnung (EU 2019/945)

**Aktueller Stand September 2026:** Auf der offiziellen EASA-Liste der **C-classifizierten Drohnen** ([easa.europa.eu](https://www.easa.europa.eu/en/domains/drones-air-mobility/drones-evtol-designs/drones-eu-operations)) sind aktuell **nur sehr wenige VTOL/Festflügler** vertreten:

- **Delair UX11** (FR) — **C6 (STS 02)**, fixed-wing (KEIN VTOL, aber fest-flügelig)
- Diverse CK-Modelle (CAVOK UAS, FR) — **C5/C6**, aber **Multirotor**
- AIR4-Serie (AIR6 SYSTEMS, DE) — **C5/C6**, Multirotor

**→ Kein einziges Quadplane/Tilt-rotor-VTOL hat aktuell eine C-Class-Kennzeichnung in der EU!**

### Konsequenz für alle Marktteilnehmer

| Kategorie | Plattformen | Regulatorischer Status |
|---|---|---|
| **C-Class VTOL (C5/C6)** | (noch) keine | — |
| **Specific Category (LBA + SORA pro Betreiber)** | WingtraOne, DeltaQuad Pro/Evo, Autel Dragonfish, JOUAV CW-15, Quantum Trinity | Jeder Betreiber braucht eigene SORA-Genehmigung |
| **STS-01/STS-02 (BVLOS mit C5/C6-Drohne)** | noch nicht für VTOL/Festflügler nutzbar | C5/C6 fehlt |
| **FAA Part 107** | senseFly eBee X, Autel Dragonfish (US), WingtraOne | Standard Waiver für BVLOS nötig |
| **Blue UAS / NDAA** | senseFly eBee TAC (US-Behörden-zugelassen) | relevant für US-Government-Verkauf |

### EASA-Klassen-Grenzwerte (zur Einordnung Hermes-VTOL)

| Klasse | Max MTOM | Max Speed (C6) | Betrieb |
|---|---|---|---|
| C0 | <250 g | – | Open, keine Registrierung |
| C1 | <900 g | – | Open, A1/A3 |
| C2 | <4 kg | – | Open, A1/A2/A3 |
| **C3** | **<25 kg** | – | Open/Unter-Deklaration, A3 |
| C5 (STS-01) | <25 kg | – | Specific BVLOS ≤2 km |
| **C6 (STS-02)** | **<25 kg** | **≤50 m/s** | **Specific BVLOS ≤2 km, erweiterte Geographie** |

**Hermes-VTOL bei MTOW 16 kg** → fällt klar in **C3 / C5 / C6** (gleiche Gewichtsklasse wie Dragonfish Pro, JOUAV CW-15). Eine **C6-Kennzeichnung wäre ein Alleinstellungsmerkmal**.

---

## Preis-Bänder & Marktpositionierung für Hermes-VTOL

### Marktsegment-Preisspanne (USD, ohne Sensorik)

| Marktsegment | Preisspanne | Konkurrenz-Modelle |
|---|---|---|
| **Hobbyklasse / DIY** | <$5.000 | Lidl-Glider, Eigenbau (PX4/Ardupilot) |
| **Entry Commercial** | **$8.000–20.000** | T-DRONES VA23, DeltaQuad Pro, senseFly eBee X |
| **Mid Commercial (Zielgruppe Hermes)** | **$20.000–40.000** | WingtraOne Gen II, Quantum Trinity Pro, JOUAV CW-15 |
| **Enterprise** | $50.000–80.000 | Autel Dragonfish Standard, JOUAV CW-20E |
| **Enterprise / Defense** | $90.000–120.000+ | Autel Dragonfish Pro, WingtraRAY, DeltaQuad Evo (Quote) |

### Empfohlene Positionierung für Hermes-VTOL

Mit MTOW ~16 kg, 4 austauschbaren Payload-Containern + Universal-Modul, Quadplane-Topologie, PX4-Stack und geplantem Multi-Mission-Use:

- **Ziel-Preis:** **€30.000–50.000** (zzgl. MwSt, Schulung, Versicherung)
- **Vergleichbar:** JOUAV CW-15 ($40k), WingtraOne Gen II ($25k)
- **USP-Hebel:** Modularer Container-Slot (kein Mitbewerber bietet 4 austauschbare Module + Universal) + optionale C6-Zulassung + SORA-Vorlage als Bundle

---

## Architektur-Anleihen für Hermes-VTOL

| Hermes-VTOL-Designwahl | Beste Referenz | Übernommene Eigenschaft |
|---|---|---|
| Pusher-Quadplane (~2 m, CFK) | **T-DRONES VA23** | Größenklasse, CFK-Bauweise, günstige Lern-Referenz |
| 4 austauschbare Payload-Container | **DeltaQuad Pro** (#MAP/#VIEW/#CARGO) | Mission-Segmentierung als Vorbild, aber **funktionalere Container** statt nur Kamera-Tausch |
| IP43/IP54, Wind 12–15 m/s | **JOUAV CW-15 / Dragonfish** | Wind-Toleranz und IP-Schutzklassen sind Industriestandard |
| PX4/Ardupilot, ROS 2 | **DeltaQuad Evo/Pro** | Open-Source-Stack, MAVLink-Kompatibilität, kein Vendor-Lock-in |
| Carbon-Fiber-Rumpf | **Autel Dragonfish** | Alle Größen in CFK, IP43, modularer Payloadschnellverschluss |
| Dual-Akku + Akku-Redundanz | **DeltaQuad Evo** (Semi-Solid-State), Dragonfish (2 Smart-Batteries) | Safety-Argument für SORA OSO |
| Folding Landing Gear | **FX-79 Buffalo Conversion** mit Foxtech Hover-1 Kit | Transportabilität, sauberer Übergang Fixed-Wing/Copter |
| Wing-Loading 20–35 g/dm² | **Zbotic-VTOL-Guide** | Tuning-Empfehlung für stabile Transition |

---

## Alleinstellungsmerkmale (USPs) gegenüber dem Markt

1. **Modularer Payload-Container-Slot** (4 Module + Universal) statt nur wechselbarer Kameras
   - *Wingtra/senseFly*: nur RGB-/Multispektral-/LiDAR-Tausch
   - *DeltaQuad*: #MAP/#VIEW/#CARGO = verschiedene Kamera-Konfigurationen, kein Container-Konzept
   - *Autel Dragonfish*: Schnellverschluss, aber ebenfalls nur Sensor-Tausch
   - **Hermes**: Container sind komplette Funktionseinheiten (z. B. "SAR-Container" mit Thermal + Lautsprecher + Scheinwerfer + Funkrelais)

2. **Multi-Mission von Haus aus** (SAR + Wildschutz + Behörde + Vermessung in einer Plattform)
   - Wingtra/senseFly: reine Mapping-Plattformen
   - JOUAV/Dragonfish: breit, aber nicht klar in Mission-Container segmentiert

3. **EASA-C5/C6 als Ziel** (wenn erreicht)
   - Aktuell kein Mitbewerber in der Quadplane-Klasse auf der EASA-C-Class-Liste
   - Markteintritts-Vorteil 2–3 Jahre

4. **SORA-Vorlage + ConOps-Vorlage + Maintenance-Logbuch als Produkt-Bundle**
   - Kein Mitbewerber liefert ein fertiges Genehmigungs-Paket mit
   - Starker Verkaufshebel für europäische Behördenkunden

5. **Open-Source-Stack** (PX4/Ardupilot + ROS 2 + MAVLink)
   - Im Gegensatz zu Wingtra/senseFly/JOUAV/Autel (alle Closed-Source)
   - Erlaubt Kunden-Erweiterungen ohne Vendor-Lock-in
   - Relevant für Forschung, Militär-zivile Dual-Use-Kunden (mit Behörden-Zulassung), Verteidigungs-Startups

6. **Heimische Produktion (DE/DACH) + EU-Komponenten**
   - Quantum-Systems ist die einzige echte EU-Konkurrenz — aber kleiner und ohne Container-Konzept
   - Für EU-Behörden ein politischer Vorteil ("Made in Germany" + EU-Lieferkette)

---

## Quellen

### Hersteller-Websites

- [DeltaQuad Evo](https://www.deltaquad.com/products/evo) | [DeltaQuad Pro](https://www.deltaquad.com/) | [Evo Tech Specs](https://www.deltaquad.com/resources/technical-specifications)
- [T-DRONES VA23](https://www.t-drones.com/product/VA23.html) | [T-DRONES Hersteller-Seite](https://wurenji.io/product/va23-fixed-wing-vtol-drone)
- [Autel Dragonfish Series](https://www.autelrobotics.com/productdetail/dragonfish-series-drones/) | [Dragonfish-25](https://www.autelrobotics.com/productdetail/dragonfish-series-drones/) | [Dragonfish Lite/Pro US-Launch](https://www.autelrobotics.com/news/894)
- [JOUAV VTOL-Hauptseite](https://www.jouav.com/vtol-drone) | [JOUAV CW-15](https://www.jouav.com/products/cw-15.html) | [JOUAV Aeromagnetic System](https://www.jouav.com/products/gtk.html)
- [Wingtra Hauptseite](https://wingtra.com/) | [WingtraOne bei Advexure](https://advexure.com/pages/wingtraone-gen2) | [Wingtra VTOL-Drone-Guide](https://wingtra.com/vtol-drone/?srsltid=AU7gw4UnDWTUYnZr6wkymOrAfef5WfmoHvpuMpUEBu5Rvi06iWbmRB3x)
- [senseFly eBee X](https://www.sensefly.com/solutions/drones) | [eBee-X-Datenblatt (PDF)](https://cdn.prod.website-files.com/6641f2af27f839833a4a8490/6667bf30ab999b20dc8e612c_eBee-X-EN.pdf) | [Lidar News Launch](https://lidarnews.com/sensefly-launches-ebee-x-drone)
- [Quantum-Systems Trinity Pro (via Dronetrader Vergleich)](https://blog.dronetrader.com/vtol-vertical-take-off-and-landing-hybrid-drones-available-for-sale)

### Open-Source / DIY-Referenzen

- [PX4 Discuss: 4+1 VTOL 1,2 m wingspan](https://discuss.px4.io/t/4-1-vtol-drone-1-2-meter-wingspan-looking-for-feedback/37557)
- [Instructables: Quanum-Observer Quadplane](https://instructables.com/id/Quadplane-Hybrid-Drone)
- [Ardupilot Discuss: FX-79 Buffalo QuadPlane](https://discuss.ardupilot.org/t/fx-79-buffalo-quadplane-conversion-part-2/34493)
- [Printables: Lidl-Glider VTOL Plane](https://printables.com/model/1129488-lidl-glider-vtol-plane)
- [Zbotic VTOL-Build-Guide](https://zbotic.in/how-to-build-a-vtol-drone-fixed-wing-meets-multirotor)

### Regulatorik

- [EASA: Drones for EU Operations (C-Class-Liste)](https://www.easa.europa.eu/en/domains/drones-air-mobility/drones-evtol-designs/drones-eu-operations)
- [EASA: C0–C6 Klassen-FAQ](https://www.easa.europa.eu/en/the-agency/faqs/drones-class-identification-label-c0-c6)
- [EASA Opinion 05-2019 (STS-01, STS-02, C5/C6)](https://www.easa.europa.eu/sites/default/files/dfu/Opinion%20No%2005-2019.pdf)
- [EASA: Class Identification Labels](https://www.easa.europa.eu/en/document-library/general-publications/drone-class-identification-labels-and-information-notices)

### Übersichtsartikel

- [UAV Coach: Top VTOL Drones 2026](https://uavcoach.com/vtol-drones/)
- [Drone Pilot Ground School: VTOL Guide](https://www.dronepilotgroundschool.com/vtol-drones/)
- [Pilot Institute: Everything about VTOL Drones](https://pilotinstitute.com/everything-about-vtol-drones/)
- [Unmanned Systems Technology: Survey-Grade UAV](https://www.unmannedsystemstechnology.com/expo/survey-grade-uav/)
- [Dronetrader: VTOL Buyer's Guide 2026](https://blog.dronetrader.com/vtol-vertical-take-off-and-landing-hybrid-drones-available-for-sale)
- [sUAS News: Wingtra trade-in program](https://www.suasnews.com/2020/06/wingtra-trade-in-program/)
- [sUAS News: DeltaQuad Pro #INSPECT launch](https://www.suasnews.com/2019/03/vertical-technologies-launches-the-deltaquad-pro-inspect-for-utilities-wildlife-and-disaster-inspection)
- [Gerobo: DeltaQuad Pro #VIEW solution](https://gerobo.eu/iinspector)
- [max-robotics: WingtraOne Wiki](https://max-robotics.com/en/wiki/wingtraone-wingtra) | [max-robotics: WingtraOne Produkt](https://max-robotics.com/en/robots/cmqoc34y10002n1b2uyznk5ty)
- [robotics.press: DeltaQuad Company Profile](https://robotics.press/news/deltaquad-company-profile)
- [rcdrone: T-Drone VA23](https://rcdrone.top/products/t-drone-va23-vtol-drone)
- [rcdrone: JOUAV CW-15 (Preis)](https://rcdrone.top/products/jouav-cw-15-uav)
- [Dronepick: JOUAV CW-15 Review](https://dronepick.net/drones/jouav-cw-15)
- [GPS World: Dragonfish US launch](https://www.gpsworld.com/autel-robotics-tilt-rotor-dragonfish-lite-and-pro-uavs-available-in-us/)
- [Bavovna: DeltaQuad VTOL UAV](https://bavovna.ai/uav/deltaquad-vtol-uav)

---

## Versionsverlauf

| Version | Datum | Änderung |
|---------|-------|----------|
| 1.0 | 2026-09-23 | Initial — Ring-1/2/3-Matrix, Detail-Architekturmatrix, EASA-C-Class-Übersicht, Preis-Bänder, USPs |
