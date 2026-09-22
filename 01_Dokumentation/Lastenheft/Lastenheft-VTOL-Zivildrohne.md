# Lastenheft — VTOL-Zivildrohne für SAR, Wildschutz, Behörden und kommerzielle Anwendungen

**Dokument-ID:** LH-VTOL-CIV-001
**Version:** 1.0
**Datum:** 2026-07-XX
**Status:** Entwurf / in Bearbeitung
**Autor:** Projektverantwortlicher

---

## Versionsverlauf

| Version | Datum | Änderung |
|---------|-------|----------|
| 0.1 | initial | Erstanlage |
| 0.5 | – | Anforderungs-Sammlung |
| 1.0 | – | Erstes vollständiges Lastenheft mit allen Festlegungen |
| 1.1 | – | Anpassung MTOM 17,0 → 16,0 kg (Schwebeschub-Faktor 2,10×); Payload 3,28 → 2,28 kg |

---

## 1. Projektübersicht

### 1.1 Zweck und Geltungsbereich

Dieses Lastenheft definiert die Anforderungen an eine **VTOL-Festflügler-Drohne (Quadplane-Konfiguration)** für ausschließlich zivile Anwendungen. Das Gerät soll modular mit austauschbaren Payload-Containern in vier Haupteinsatzbereichen verwendbar sein:

- **Safety & Rescue (SAR)** — Personensuche, Lageerkundung
- **Wildschutz** — Tierbeobachtung, Anti-Wilderei
- **Behördeneinsatz** — Polizei, Feuerwehr, Zoll, Katastrophenschutz
- **Kommerziell** — Vermessung, Inspektion, Landwirtschaft

### 1.2 Abgrenzung

**Explizit ausgeschlossen:**
- Militärische Anwendungen
- Bewaffnung oder Nutzlasten, die Personen gefährden können
- Operationen außerhalb der zivilen Luftfahrtgesetzgebung (EU 2019/947, FAA Part 107)

### 1.3 Referenzdokumente

| Dokument | Beschreibung |
|----------|--------------|
| EU-Verordnung 2019/947 | Drohnen-Betrieb in Europa |
| EU-Verordnung 2019/945 | Technische Anforderungen EU |
| EASA SORA JARUS | Specific Operations Risk Assessment |
| EASA Concept of Operations | Standard-Szenarien (PDRA) |
| FAA 14 CFR Part 107 | US-Drohnenbetrieb |
| FAA Part 137 | Agrar-Drohnen (für kommerziell relevant) |
| ISO 21384-3 | UAS-Betriebsverfahren |
| ASTM F3196 | Standard für sUAS Design |

---

## 2. Missionsprofil und Anforderungsprofil

### 2.1 Anwendungsfälle (Use-Cases)

#### 2.1.1 MVP-Anwendungsfälle (Erstauslieferung)

| Use-Case | Priorität | Hauptanforderung |
|----------|-----------|-------------------|
| **SAR — Vermisstensuche** | HOCH | Thermal-Kamera, lange Endurance, BVLOS-fähig |
| **Wildschutz — Tierbeobachtung** | HOCH | Thermal + Multispektral, leiser Betrieb |

#### 2.1.2 Erweiterungs-Anwendungsfälle (zweite Phase)

| Use-Case | Priorität | Hauptanforderung |
|----------|-----------|-------------------|
| **Behörden — Polizei/Feuerwehr** | MITTEL | Verschlüsselte C2, TETRA-Bridge, Scheinwerfer |
| **Kommerziell — Vermessung** | MITTEL | Lidar, PPK-GNSS, hohe Präzision |

### 2.2 Umgebungsbedingungen

| Parameter | Anforderung |
|-----------|-------------|
| **Einsatzraum** | Mischbetrieb ländlich/kleinstädtisch (Mitteleuropa / Deutschland) |
| **Klimatische Bedingungen** | Mitteleuropäisch, regenwasserresistent (mind. IP54 für Elektronik) |
| **Temperaturbereich Betrieb** | −10 °C bis +40 °C (mit Akku-Vorkonditionierung im Winter) |
| **Windtoleranz Operationswind** | bis 10 m/s (Stabiler Flugbetrieb), bis 12 m/s (Start/Landung mit reduzierter Sicherheitsmarge) |
| **Tageszeit** | Tag und Nacht (Thermal-Sensorik + Beleuchtung Pflicht bei Nacht) |
| **Einsatzhöhe** | 0 bis 1500 m über Grund (Gebirge und Mittelgebirge) |
| **Luftfeuchtigkeit** | bis 95 % nicht-kondensierend |

### 2.3 Performance-Anforderungen

| Anforderung | Zielwert | Minimalwert | Bemerkung |
|-------------|----------|-------------|-----------|
| **MTOM (Maximum Take-Off Mass)** | 16,0 kg | ≤ 16,5 kg | EU-Schwelle 25 kg unterschritten, Schwebeschub-Faktor 2,10× |
| **Spannweite** | 2,30 m (klappbar) | ≤ 2,40 m | Transport in Standard-Transportbox |
| **Endurance** | ≥ 68 min | ≥ 55 min | Bei Cruise-Bedingungen, 50 % Hover-Anteil |
| **Reichweite** | ≥ 73 km | ≥ 60 km | Bei 18 m/s Cruise |
| **Nutzlast (Payload)** | ≥ 2,2 kg | ≥ 1,8 kg | Bei MTOM 16 kg; alle 4 Container-Module nutzbar |
| **Reiseflug-Geschwindigkeit** | 18 m/s (65 km/h) | 16–22 m/s variabel | Effizienz-optimum bei 18 m/s |
| **Max. Geschwindigkeit** | 28 m/s (100 km/h) | – | Sicherheitsreserve |
| **Operationshöhe** | 120 m AGL (BVLOS-Default) | 500 ft AGL (FAA Part 107) | |
| **Schwebeschub-Sicherheitsfaktor** | ≥ 2,1× | ≥ 2,0× | Bei Vollgas-Hover ohne Nutzlast |
| **Service-Ceiling** | 3500 m AMSL | 2500 m | Dünne-Luft-Degradation |

### 2.4 Regulatorische Anforderungen

#### 2.4.1 Europäische Union (EU 2019/947)

- **Kategorie:** Specific Category (BVLOS erfordert SORA)
- **SAIL-Ziel:** SAIL II (mit Dual-Akku + redundanter Avionik erreichbar)
- **SORA-Dokumentation:** Vollständige SAIL-II-Dokumentation inkl. OSO-Nachweis
- **Geo-Zones:** Beantragung erforderlich für Einsatz in Kontrollzonen
- **Direct Remote Identification (DRI):** Pflicht ab 2024

#### 2.4.2 Vereinigte Staaten (FAA Part 107)

- **Part 107 Subpart D:** Waiver für BVLOS (oder Part 108 falls verfügbar)
- **Remote ID Compliance:** FAA-Standard ab März 2024
- **Section 44807 Exemption:** Falls Sonderanforderungen
- **Lüftsicherheitsbehörde (FAA UAS Integration Office)** für kommerzielle Operationen

---

## 3. Technische Spezifikation

### 3.1 Systemarchitektur

**Konfiguration:** **Quadplane mit Pusher-Antrieb**
- 4× Hub-Quad (VTOL-Hover)
- 1× Pusher (Festflügel-Cruise)
- Elektrische Trennung mit MOSFET-Switches

### 3.2 Abmessungen und Hauptkonstanten

| Parameter | Wert |
|-----------|------|
| **Spannweite** | 2,30 m (klappbar auf 2× 1,18 m) |
| **Rumpflänge** | 1,20 m |
| **Rumpf-Durchmesser (max)** | 0,18 m |
| **Flügelfläche** | 0,63 m² |
| **Streckung** | 8,5 |
| **Mittlere Sehne (c_mean)** | 0,245 m |
| **Flügel-Profil** | Wortmann FX 63-137 (13,7 % dick) |
| **Pfeilung (LE)** | 0° |
| **V-Stellung** | 5° |
| **Höhe (mit Hub-Auslegern)** | 0,42 m |
| **Klappmaß (Transport)** | 1,30 × 0,30 × 0,30 m |

### 3.3 Massen-Bilanz (MTOM 16,0 kg)

#### 3.3.1 Strukturmasse (3,54 kg)

| Komponente | Masse | Material |
|-----------|-------|----------|
| Rumpf (CFK-Sandwich) | 650 g | T800 + Airex C70.75 |
| Flügel-Doppel-Holm | 180 g | T800-CFK-Rohr ⌀22 × 1,5 mm, 2 Stk. |
| Flügel-Beplankung | 380 g | 3-lagig Biaxial + 1× Unidirektional |
| Flügel-Rippen | 140 g | Balsa + CFK-Beschichtung |
| Nasen-/Endleiste | 115 g | CFK + Balsakern |
| Hub-Ausleger (4×) | 240 g | CFK-Rohr ⌀20 mm |
| Verbindungselemente | 180 g | Edelstahl A4, M3–M5 |
| Payload-Container (leer) | 700 g | CFK-Sandwich + 3D-Druck-Form |
| Landing-Gear (4× klappbar) | 220 g | CFK + Gummidämpfer |
| Spinner (Bug + 4× Hub) | 180 g | CFK |
| Faltmechanik + Winglets + Mittelstück | 555 g | CFK + Aluminium-Camlocks |
| **Summe Struktur** | **3.540 g** | |

#### 3.3.2 Antriebsmasse (3,60 kg)

| Komponente | Modell | Stk. | Masse/Stk. | Gesamt |
|-----------|--------|------|-----------|--------|
| Hub-Motor | T-Motor P60 KV170 | 4 | 375 g | 1.500 g |
| Hub-ESC | T-Motor AIR 80A 14S | 4 | 130 g | 520 g |
| Hub-Propeller | 22×6,6 Carbon-Faltprop | 4 | 110 g | 440 g |
| Prop-Adapter + Hub-Spinner | TA-22 + Eigendruck CFK | 4 | 55 g | 220 g |
| Pusher-Motor | T-Motor MN501-S KV340 | 1 | 290 g | 290 g |
| Pusher-ESC | T-Motor AIR 50A 14S | 1 | 85 g | 85 g |
| Pusher-Propeller | 15×8 Carbon-Klappprop | 1 | 110 g | 110 g |
| Pusher-Spinner | CFK | 1 | 45 g | 45 g |
| Verkabelung + PDB + Lüfter | – | – | – | 250 g |
| MOSFET-Boards + Kühlkörper | IRLB3034-PB | 2 | 40 g | 80 g |
| XT90-Anti-Spark-Stecker | – | 2 | 30 g | 60 g |
| **Summe Antrieb** | | | | **3.600 g** |

#### 3.3.3 Avionik und Sensorik (0,70 kg)

| Komponente | Modell | Masse |
|-----------|--------|-------|
| Flight-Controller | Holybro Pixhawk 6X | 35 g |
| Companion-Computer | NVIDIA Jetson Orin NX 16GB + Carrier Board | 165 g |
| GPS-Modul | Zubax GNSS 2.1 (M10) | 42 g |
| GPS-Antenne | Tallysman TW4721 (aktiv) | 25 g |
| Telemetrie-Funk | RFD900X (868 MHz, 1 W) | 30 g |
| RC-Empfänger | FrSky R9MX | 12 g |
| Strom-Sensor | Mauch Hall-Sensor 14S 100A | 25 g |
| Airspeed-Sensor | EagleTree F5 + Pitotrohr | 35 g |
| Servos (Klappen / Vektor) | KST DS215MG (8 kg·cm) | 60 g (2 Stk.) |
| Thermal-Kamera | FLIR Boson 640 + 24° Optik + Halter | 65 g |
| RGB-Kamera | Arducam IMX477 4K + Lens | 35 g |
| Kamerahalter + Vibrations-Dämpfer | 3D-Druck TPU + Gummi | 40 g |
| BEC 14S → 5 V / 12 V | T-Motor BEC 14S | 35 g |
| Verkabelung Sensorik | – | 50 g |
| SD-Karten + Sicherungen | – | 50 g |
| **Summe Avionik** | | **704 g** |

#### 3.3.4 Energie-System (5,88 kg)

| Komponente | Spezifikation | Masse |
|-----------|---------------|-------|
| Akku A (Pusher-Versorgung) | 14S3P Molicel P45B 21700 (1.152 Wh) | 3.129 g |
| Akku B (Hub-Versorgung) | 14S2P Molicel P45B 21700 (768 Wh) | 2.086 g |
| BMS Akku A | Daly 14S 60A | 95 g |
| BMS Akku B | Daly 14S 40A | 75 g |
| Akku-Gehäuse (CFK-Sandwich) | 2 Stück mit Vibrations-Dämpfung | 320 g |
| Verkabelung 2× Akku (Silikon 10 AWG) | – | 85 g |
| Aktive Kühlung (Noctua 40 mm 5 V + Alu) | 2× | 85 g |
| **Summe Energie-System** | | **5.875 g** |

#### 3.3.5 Massen-Bilanz Übersicht

| Block | Masse | Anteil MTOM |
|-------|-------|-------------|
| Struktur | 3.540 g | 22,1 % |
| Antrieb | 3.600 g | 22,5 % |
| Avionik + Sensorik | 704 g | 4,4 % |
| Energie-System | 5.875 g | 36,7 % |
| **Festmasse (ohne Payload)** | **13.719 g** | **85,7 %** |
| **Payload-Rest** | **2.281 g** | **14,3 %** |
| **MTOM** | **16.000 g** | **100,0 %** |

**Hinweis:** Payload-Budget von 2,28 kg erlaubt den Betrieb aller 4 Container-Module (M1-SAR, M2-Wildschutz, M3-Behörden, M4-Vermessung). Modul-spezifische Massen siehe Kapitel 4.2.

### 3.4 Antriebsstrang

#### 3.4.1 Hub-Motoren (4× P60 KV170)

| Parameter | Wert |
|-----------|------|
| **Modell** | T-Motor P60 KV170 |
| **KV** | 170 RPM/V |
| **Masse pro Motor** | 375 g |
| **Max. Dauerleistung** | ca. 1,8 kW |
| **Max. Strom** | ca. 70 A |
| **Schub pro Motor (22×6,6 @ 14S)** | ca. 8,4 kg |
| **4× Schub gesamt** | 33,6 kg |
| **Schwebeschub-Faktor @ MTOM 16 kg** | 2,10× |

#### 3.4.2 Pusher-Motor (MN501-S KV340)

| Parameter | Wert |
|-----------|------|
| **Modell** | T-Motor MN501-S KV340 |
| **KV** | 340 RPM/V |
| **Masse** | 290 g |
| **Max. Dauerleistung** | ca. 800 W |
| **Schub (15×8 @ 14S)** | ca. 4,2 kg |
| **Reiseflug-Leistungsaufnahme** | ca. 250 W @ 18 m/s |
| **Reiseflug-Strom** | ca. 6 A |

#### 3.4.3 Leistungsbudget

| Modus | Leistung | Anteil |
|-------|----------|--------|
| **Hover (Vollgas)** | 4× 1.800 W = 7.200 W | kurzzeitig (beim Start) |
| **Hover (Schweben, 70 %)** | ca. 3.000 W | 10 % der Missionszeit |
| **Transition Fixed-Wing** | ca. 800 W | 30 s pro Übergang |
| **Reiseflug 18 m/s** | ca. 250 W | 90 % der Missionszeit |
| **Mittlere Leistungsaufnahme** | ca. 530 W | – |

### 3.5 Energie-System

#### 3.5.1 Akku-Topologie

**Konfiguration: Asymmetrisches Dual-Akku-System**

```
[Akku A 14S3P] ──[MOSFET-Switch A]──┐
   (Pusher-Versorgung)              │
                                     ├──[Bus-Bar]──[Verteilung]
[Akku B 14S2P] ──[MOSFET-Switch B]──┘
   (Hub-Versorgung)
```

#### 3.5.2 Akku-Spezifikationen

| Parameter | Akku A | Akku B |
|-----------|--------|--------|
| **Konfiguration** | 14S3P | 14S2P |
| **Zellen** | 42× Molicel P45B 21700 (6.500 mAh) | 28× Molicel P45B 21700 (6.500 mAh) |
| **Nominalspannung** | 51,8 V | 51,8 V |
| **Energie (nominal)** | 1.152 Wh | 768 Wh |
| **Energie (nutzbar, 90 % DOD)** | 1.037 Wh | 691 Wh |
| **Max. Dauerentladung (3P)** | 3 × 30 A = 90 A | 2 × 30 A = 60 A |
| **Masse (Zellen)** | 3.129 g | 2.086 g |
| **BMS** | Daly 14S 60A | Daly 14S 40A |

#### 3.5.3 Lastverteilung pro Modus

| Modus | Akku A | Akku B |
|-------|--------|--------|
| **Hover (Start/Landung)** | inaktiv | aktiv (100 % Hub-Strom) |
| **Transition Hub → Cruise** | inaktiv | aktiv (80 % Hub-Strom) |
| **Reiseflug** | aktiv (100 % Pusher) | aktiv (20 %, Stabilisierung) |
| **Rückflug / Reserve** | aktiv (Last geteilt) | reduziert |
| **Notfall Pusher-Akku aus** | aus | aktivierbar (Last-Shift) |
| **Notfall Hub-Akku aus** | aktivierbar | aus (kein VTOL → Gleitflug) |

#### 3.5.4 MOSFET-Switches

| Parameter | Spezifikation |
|-----------|---------------|
| **FET-Typ** | IRLB3034 (oder vergleichbar) |
| **Spannungsfestigkeit** | ≥ 75 V |
| **Dauerstrom** | ≥ 80 A (Pusher) / ≥ 240 A (Hub, mit Parallelschaltung) |
| **R_DS(on)** | < 3 mΩ |
| **Schaltlogik** | Active-High, Fail-Safe auf ON |
| **Ansteuerung** | PWM-Signal vom Pixhawk |

### 3.6 Avionik

#### 3.6.1 Flight-Controller: Pixhawk 6X

- **Prozessor:** STM32H753 (480 MHz, 1 MB RAM)
- **Sensoren (intern):** ICM-42688P IMU (2× redundant), BMI088, DPS310 Baro, RM3100 Magnetometer
- **Schnittstellen:** UART ×5, I2C, SPI, CAN, USB-C, Ethernet
- **Firmware:** PX4 v1.14+ (Quadplane-Konfiguration)

#### 3.6.2 Companion-Computer: NVIDIA Jetson Orin NX 16GB

- **CPU:** 8-core Arm Cortex-A78AE v8.2 64-bit
- **GPU:** 1.020-core NVIDIA Ampere (32 Tensor-Cores)
- **RAM:** 16 GB LPDDR5 |
- **KI-Inferenz:** bis 100 TOPS (INT8) |
- **Stromverbrauch:** 15–25 W (konfigurationsabhängig)
- **Schnittstellen:** 2× USB 3.2, 2× M.2 Key M, 2× CSI, 1× GbE, GPIO
- **Software:** JetPack 6.0+, Ubuntu 22.04, ROS 2 Humble, YOLOv10 / RT-DETR

#### 3.6.3 Sensorik (Standard-Container-Modul)

| Sensor | Modell | Auflösung | Funktion |
|--------|--------|-----------|----------|
| **Thermal** | FLIR Boson 640 + 24° Optik | 640×512 @ 60 Hz | Wärmebild, Personensuche, Tierbeobachtung |
| **RGB** | Arducam IMX477 (Sony) | 4K @ 30 fps | Tageslicht-Aufnahmen, KI-Training |
| **Airspeed** | EagleTree F5 + Pitotrohr | ±80 m/s | Fixed-Wing-Geschwindigkeitsmessung |
| **GPS** | Zubax GNSS 2.1 (M10) | RTK-fähig | Position, Geschwindigkeit |
| **Strom/Spannung** | Mauch Hall-Sensor | 14S, 100 A | Leistungs-Monitoring |

### 3.7 Struktur

#### 3.7.1 Materialien

| Komponente | Material | Begründung |
|-----------|----------|-----------|
| Flügel-Holme | **T800-CFK-Rohr** ⌀22 × 1,5 mm (2 Stk.) | Standard-Modul, günstig, gute Festigkeit |
| Flügel-Beplankung | **T800 Biaxial (3 Lagen) + Unidirektional (1 Lage)** | Steifigkeit + Festigkeit |
| Flügel-Rippen | **Balsa 3 mm + CFK-Beschichtung** | Leicht, einfach zu CNC-fräsen |
| Sandwich-Kerne | **Airex C70.75** (5 mm) | Sehr leicht, temperaturstabil |
| Rumpf-Hauptschale | **T800-CFK + Airex C70.75** | Standard-Lösung |
| Hub-Ausleger | **CFK-Rohr ⌀20 mm** | Standard |
| Payload-Container | **CFK-Sandwich + 3D-Druck-Innenschale** | Modular, vibrationsgedämpft |

#### 3.7.2 Klebstoffe

| Anwendung | Klebstoff | Zertifizierung |
|-----------|-----------|----------------|
| Struktur-Holme | 3M AF-163-2 | FAA/EASA anerkannt |
| Hochtemperatur-Bereich | 3M FM 300 | FAA/EASA anerkannt |
| Reparaturen | Hysol EA 9394 | MIL-Spec |

---

## 4. Payload-System

### 4.1 Universal-Container-Spezifikation

**Außenmaße:** 280 × 140 × 120 mm
**Masse leer:** ca. 700 g (mit elektrischer Schnittstelle und Vibrations-Dämpfung)

#### 4.1.1 Schnittstellen

| Schnittstelle | Spezifikation |
|---------------|---------------|
| **Stromversorgung** | 14S (51,8 V) Direktanschluss, max. 5 A Dauerstrom |
| **Daten** | CAN-Bus + UART + USB 3.0, wasserdichte M12-Stecker |
| **Mechanisch** | 4× Schnellverschluss (Cam-Lock), Bajonett-Design |
| **Datenrate (CAN)** | 1 Mbit/s |
| **IP-Schutz** | IP67 (gesteckt) |

### 4.2 Modul-Optionen (Universal-Container mit austauschbaren Innenmodulen)

| Modul-ID | Bezeichnung | Hauptkomponenten | Masse | Strom |
|----------|-------------|------------------|-------|-------|
| **M1-SAR** | SAR-Sensorik | Boson 640, Arducam 4K, LED-Scheinwerfer, Mikrofon/Lautsprecher | 280 g | 18 W |
| **M2-WILD** | Wildschutz-Sensorik | Boson 640, Multispektral (Parrot Sequoia), Akustik-Sensor | 320 g | 22 W |
| **M3-BEH** | Behörden-Sensorik | Boson 640, Hochleistungs-LED (6.000 lm), Lautsprecher (100 dB), TETRA-Bridge | 580 g | 35 W |
| **M4-VERM** | Vermessungs-Sensorik | Boson 640, Livox Mid-360 Lidar, PPK-GNSS | 620 g | 28 W |

### 4.3 Vibrations- und Thermik-Anforderungen

| Parameter | Anforderung |
|-----------|-------------|
| **Vibrationsfrequenz-Bereich** | 5–500 Hz |
| **Max. Beschleunigung (RMS)** | 5 g (Vibration), 15 g (Schock) |
| **Dämpfung** | Sorbothane 30 Shore, 4-Punkt-Aufhängung |
| **Thermal-Bereich** | −20 °C bis +60 °C (Sensorik-Bereich) |
| **EMV-Schutz** | Gehäuse innen Kupferlitze-Geflecht + Filterdrosseln |

---

## 5. Sicherheitsanforderungen

### 5.1 Strukturelle Lastfälle

| Lastfall | Faktor | Anwendung |
|----------|--------|-----------|
| **Manöver-Last (positiv)** | +2,5 g | Scharfe Kurve, Transition |
| **Manöver-Last (negativ)** | −1,5 g | Plötzlicher Down-Draft |
| **Böen-Last** | +3,8 g (vertikal) | 95-Perzentil-Böe + Manöver |
| **Bruch-Last** | 1,5 × max Last = **+5,7 g** | Sicherheitsnachweis (FEM-Simulation erforderlich) |
| **Vibration/Ermüdung** | ±0,5 g @ 15 Hz | Motor-Vibration, Lebensdauer |

### 5.2 Redundanz-Anforderungen

| System | Redundanz | Bemerkung |
|--------|-----------|-----------|
| **Energie** | Dual-Akku (asymmetrisch 14S3P + 14S2P), MOSFET-trennbar | SORA-relevante OSO erfüllt |
| **Flight-Controller** | Dual-IMU (Pixhawk 6X hat ICM-42688P + BMI088), Dual-Magnetometer (intern + extern) | Standard PX4-Redundanz |
| **GPS** | Dual-Antenne (optional Zubax Sentinel + TW4721) | für BVLOS empfohlen |
| **Telemetrie** | 2× Funkmodule (RFD900X + 4G-Modem) | C2-Redundanz |
| **Companion-Computer** | Watchdog-Timer im FC | automatischer Restart bei Ausfall |
| **Hub-Motoren** | 4× statt 2× (PX4-Motor-Out-Kompensation) | bis 1 Motor-Ausfall im Schweben sicher landbar |

### 5.3 Notfallverfahren

#### 5.3.1 Motor-Ausfall

| Szenario | Reaktion |
|----------|----------|
| **1 Hub-Motor aus** | PX4 erhöht Schub der verbleibenden 3 Motoren (Motor-Out-Landing) |
| **2 Hub-Motoren aus** | Notlandung als Fixed-Wing (Gleitflug 1:15) |
| **Pusher-Motor aus** | Akku-B-Shift (MOSFET umschalten), Notlandung als Multirotor |
| **Akku A aus** | Akku-B-Versorgung des Pushers (reduzierte Reichweite) |
| **Akku B aus** | kein VTOL möglich → RTH als Fixed-Wing |

#### 5.3.2 GPS-Ausfall

- Übergang auf **Dead Reckoning** mit IMU + Airspeed
- Inertialnavigation mit Drift-Korrektur bei kurzen GPS-Wiedererfassungen
- Automatischer RTH bei längerem GPS-Verlust > 30 s

#### 5.3.3 Wetter-Abbruch

- **Auto-RTH** bei Akku-Stand < 30 %
- **Auto-RTH** bei Wind > 12 m/s
- **Auto-Landing** bei kritischen System-Fehlern

### 5.4 Geo-Fencing und Airspace

- **Geo-Fence** parametrisch (max. Entfernung, max. Höhe)
- **Kontrollzonen:** Beantragung über Landesluftfahrtbehörde
- **C2-Link-Überwachung:** Bei Verlust > 5 s automatisches RTH

---

## 6. Tests und Qualifikation

### 6.1 Bodentests

| Test | Standard | Akzeptanzkriterium |
|------|----------|---------------------|
| **Vibration (Sinus + Random)** | DO-160G, Kategorie S | Funktionsfähig in 5–500 Hz, 5 g RMS |
| **Schock (50 g, 11 ms)** | DO-160G | Strukturelle Integrität |
| **EMV (leitungsgebunden + gestrahlt)** | EN 55032 / EN 55035 | Klasse B (Wohn-/Leichtindustrie) |
| **IP-Rating (Regen, Staub)** | IEC 60529 | IP54 (fliegend), IP67 (Container) |
| **Temperatur-Schock** | MIL-STD-810G | −20 °C bis +60 °C ohne Funktionsverlust |
| **Akku-Niederschlag (UN-38.3)** | UN-Transport-Test | Zertifizierung für Luftfracht |

### 6.2 Flugtests

#### 6.2.1 Erprobungs-Phasen

| Phase | Beschreibung | Dauer | Betriebsbewilligung |
|-------|-------------|-------|---------------------|
| **1 — Ground Tests** | Motor-Standläufe, Sensor-Kalibrierung | 2 Wochen | keine |
| **2 — Tethered Hover** | Geschützter Hover-Test mit Kabel | 1 Woche | Indoor / gesicherter Außenbereich |
| **3 — Free Hover** | Freier Hover bis 5 m | 2 Wochen | Open-A1 |
| **4 — Transition Tests** | Multirotor ↔ Fixed-Wing | 2 Wochen | Open-A2 mit Aufsicht |
| **5 — Endurance** | 60+ min Missionen | 2 Wochen | PDRA-S01 (SORA-Vorstufe) |
| **6 — BVLOS** | Beyond Visual Line of Sight | 4 Wochen | Specific Category / SORA |

#### 6.2.2 Wichtige Validierungstests

- **Stall-Speed-Bestimmung** (XFLR5-Vorhersage verifizieren)
- **L/D-Verifikation** im Reiseflug (Energie-Methode)
- **Transition-Sicherheit** (mehrere Geschwindigkeits-Bereiche)
- **Schub-Reserve bei 12 m/s Wind** (kritischer Startfall)
- **BVLOS-Latenz-Messung** (C2-Link)
- **SAR-Sensorik-Reichweite** (Thermal-Personen-Detektion bei 200 m Flughöhe)

### 6.3 Dokumentation und Konformität

- **Flight-Logbuch** digital (PX4-Logs + Companion-Logs)
- **Wartungslogbuch** physisch + digital
- **Piloten-Schulungs-Zertifikate** (A2 + STS01/02)
- **SORA-Dokumentation** (PDF, mit Anhängen)

---

## 7. Wartung und Betrieb

### 7.1 Wartungsintervalle

| Intervall | Wartungsarbeiten |
|-----------|------------------|
| **Vor jedem Flug** | Sichtprüfung Rumpf, Flügel, Props; Akku-Spannung; C2-Link-Test |
| **Alle 10 Flugstunden** | Props auf Beschädigung prüfen, Lager der Hub-Motoren prüfen |
| **Alle 50 Flugstunden** | Vollständige Sichtprüfung, Schraubensitz prüfen, Gimbal kalibrieren |
| **Alle 100 Flugstunden** | Akku-Kapazitätstest, Tiefentladung vermeiden, Lager ggf. ersetzen |
| **Jährlich** | Vollständige Inspektion, FEM-Validierung gegen tatsächlichen Verschleiß |

### 7.2 Ersatzteil-Logistik

| Ersatzteil | Empfohlener Lagerbestand |
|-----------|---------------------------|
| 22×6,6 Carbon-Faltprop | 4 Stück |
| 15×8 Carbon-Klappprop | 2 Stück |
| P60 KV170 Motor | 1 Stück (Ersatz bei Ausfall) |
| Boson 640 Kamera | 0 Stück (Reparatur durch Spezialist) |
| 21700 Zellen (Sätze) | 14 Stück (1S-Ersatz) |
| Landegestell-Beine | 2 Stück |
| Kleine Ersatzteile (Schrauben, Kabelbinder, Klett) | Standard-Box |

### 7.3 Schulung

- **Piloten-Schulung:** A2-Stufe + STS-01 (in DE: A1/A2/A3 + STS01/02 nach EU 2019/947)
- **Wartungspersonal-Schulung:** Hersteller-interne Schulung, ca. 40 Stunden
- **SORA-Spezialist:** Externe Beratung für Dokumentation und Audit

### 7.4 Versicherung und Haftung

- **Halterhaftpflicht-Versicherung:** Mindestens 1 Mio. € Deckungssumme (DE)
- **Operator-Versicherung:** Gewerbliche Nutzung gemäß EU-Luftfahrt-Versicherungsverordnung
- **Piloten-Haftpflicht:** Eingeschlossen in Halterhaftpflicht
- **Erweiterte Deckung:** Für behördliche und kommerzielle Einsätze erforderlich

---

## 8. Anhänge

### 8.1 CAD- und Simulations-Workflow

#### 8.1.1 Verwendete Tools

| Tool | Hauptanwendung | Lizenz |
|------|---------------|--------|
| **Fusion 360** | Haupt-CAD, CAM, FEM-Simulation | Bildungslizenz / kommerziell |
| **Onshape** | Kleinteile, kollaboratives Review (Ausnahmen) | Free (1 User) |
| **OpenVSP** | Aerodynamik-Konzept | NASA Open Source |
| **XFLR5** | Profil-Analyse, LLT-Berechnung | Open Source |
| **Python (NumPy, SciPy, Matplotlib)** | Energie-/Flug-Simulation | Open Source |

#### 8.1.2 Workflow-Übersicht

```
OpenVSP (Aerodynamik-Konzept)
        │
        ▼
XFLR5 (Profil-Polaren, 3D-LLT)
        │
        ▼
Fusion 360 (Konstruktion, FEM, CAM)
        │
        ▼
CAM-Postprozessoren (GRBL, LinuxCNC)
        │
        ▼
CNC-Fräsung + 3D-Druck
        │
        ▼
Layup + Aushärtung
```

### 8.2 Berechnungsgrundlagen

#### 8.2.1 Schwebeschub-Berechnung

```
MTOM = 16,0 kg
Schub benötigt (2,0× Sicherheit) = 16,0 × 9,81 × 2,0 = 313,9 N = 32,0 kg
Schub pro Hub-Motor = 32,0 / 4 = 8,0 kg
Erforderlicher Schub pro P60 KV170 mit 22×6,6 Prop = 8,4 kg (Hersteller-Test)
Sicherheits-Faktor = 33,6 / 16,0 = 2,10× (komfortabel über 2,0×)
Schub-Reserve = 33,6 − 16,0 = 17,6 kg (für Steigflug, Wind, Manöver)
```

#### 8.2.2 Energie-Berechnung

```
Reiseflug-Leistung = Drag × V = (L / L/D) × V = (157 N / 15) × 18 = 188 W
Mit Sicherheitsfaktor 1,3: P_cruise = 245 W
Energie pro Minute = 245 Wh / 60 = 4,08 Wh/min

Akku A (Pusher) 1.152 Wh brutto / 1.037 Wh nutzbar
Akku B (Hub) 768 Wh brutto / 691 Wh nutzbar

Hover-Anteil (10 %, 7 min): 2.800 W × 0,12 h = 336 Wh (Akku B)
Transition (2× × 30 s): 1.000 W × 0,017 h × 2 = 34 Wh
Reiseflug (60 min): 245 W × 1,0 h = 245 Wh (Akku A) + 50 W Stabilisierung × 1,0 h = 50 Wh (Akku B)

Gesamt: Akku A: 245 Wh (21,3 % DOD), Akku B: 420 Wh (60,8 % DOD)
→ Sicherheitsreserve bis 80 % DOD: weitere 30 min möglich

Gesamt-Endurance bei MTOM 16 kg: ca. 68–73 min
```

#### 8.2.3 Reichweite

```
Reiseflug-Geschwindigkeit = 18 m/s
Reichweite = Endurance × V = 70 min × 60 s × 18 m/s = 75,6 km
Mit Sicherheitsreserve (80 % der Endurance): 60 km
```

### 8.3 Glossar

| Begriff | Bedeutung |
|---------|-----------|
| **A2 (EU)** | Drohnen-Subkategorie für nahen Flug (max. 5 m horizontal) |
| **BVLOS** | Beyond Visual Line of Sight |
| **CFK** | Carbon-Faser-verstärkter Kunststoff |
| **CFRP** | Carbon Fibre Reinforced Polymer (englisch) |
| **DOD** | Depth of Discharge (Entladungstiefe) |
| **ESC** | Electronic Speed Controller |
| **L/D** | Lift-to-Drag-Verhältnis (Gleitverhältnis) |
| **MTOM** | Maximum Take-Off Mass |
| **PDRA** | Predefined Risk Assessment |
| **PX4** | Open-Source-Autopilot-Firmware |
| **SAR** | Search and Rescue |
| **SAIL** | Specific Assurance and Integrity Level |
| **SORA** | Specific Operations Risk Assessment |
| **T800** | Standard-Carbonfaser-Typ von Toray |
| **VTOL** | Vertical Take-Off and Landing |

---

## 9. Offene Punkte / ToDo

| Nr. | Thema | Status | Verantwortlich |
|-----|-------|--------|----------------|
| 1 | Genaue Hub-Motor-Wahl (P60 vs. Vergleichsmodelle) | OFFEN | Recherche läuft |
| 2 | Klapp-Propeller-Material (Carbon vs. Holz-Kern) | OFFEN | Testreihe geplant |
| 3 | SORA-Antrag Vorlage | OFFEN | nach Lastenheft-Final |
| 4 | Lieferanten-Liste (P60, MN501-S, Molicel) | OFFEN | Beschaffung |
| 5 | BOSON-Kamera-Beschaffung (Teledyne FLIR) | OFFEN | Bestellung geplant |
| 6 | Jetson Orin NX 16GB Carrier-Board-Wahl | OFFEN | Vergleich läuft |
| 7 | OpenVSP-Modell-Aufbau mit FX 63-137 | OFFEN | nächste Phase |
| 8 | Fusion 360 Vollmodell-Aufbau | OFFEN | nach Aerodynamik-Verifikation |
| 9 | Python-Simulation für Energie + Transition | OFFEN | nach Konzept-Verifikation |
| 10 | CNC-Fräs-Programme für Spanten | OFFEN | nach CAD-Modell |

---

**Ende des Lastenhefts (Version 1.1)**

**Letzte Änderung:** MTOM von 17,0 kg auf 16,0 kg reduziert → Schwebeschub-Faktor von 1,97× auf 2,10× angehoben (Variante A, vom Projektverantwortlichen bestätigt). Payload-Budget entsprechend auf 2,28 kg reduziert; alle 4 Container-Module bleiben nutzbar.

**Nächste Schritte:**
1. Profil-Polaren in XFLR5 für Wortmann FX 63-137 berechnen
2. OpenVSP-Modell für 2,3-m-Konfiguration aufbauen
3. Aerodynamik validieren (L/D, Stall, Stabilität)
4. Fusion 360 Vollmodell erstellen
5. Python-Simulation für Energie + Transition
