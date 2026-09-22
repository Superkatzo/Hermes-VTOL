# Hermes-VTOL

**VTOL-Zivildrohne (Quadplane-Konfiguration) für SAR, Wildschutz, Behörden und kommerzielle Anwendungen**

## Projektübersicht

Dieses Repository dokumentiert die Entwicklung einer modularen, zivilen VTOL-Drohne mit austauschbaren Payload-Containern. Ziel ist eine kombinierte Plattform für:

- 🚁 **Safety & Rescue (SAR)** — Personensuche, Lageerkundung
- 🦌 **Wildschutz** — Tierbeobachtung, Anti-Wilderei
- 👮 **Behördeneinsatz** — Polizei, Feuerwehr, Katastrophenschutz
- 📐 **Kommerziell** — Vermessung, Inspektion, Landwirtschaft

## Status

| Phase | Status |
|-------|--------|
| Lastenheft v1.1 | ✅ fertig |
| Profil-Recherche (XFLR5) | 🔜 in Arbeit |
| Aerodynamik-Profil-Analyse | 🔜 in Arbeit |
| OpenVSP-Konzeptmodell | 🔜 geplant |
| Fusion 360 Vollmodell | 🔜 geplant |
| Fertigungs-Workflow (CNC + 3D-Druck) | 🔜 geplant |
| SORA-II-Dokumentation | 🔜 geplant |

## System-Hauptdaten

| Parameter | Wert |
|-----------|------|
| MTOM | 16,0 kg |
| Spannweite | 2,3 m (klappbar auf 1,18 m) |
| Profil | Wortmann FX 63-137 |
| Konfiguration | Quadplane: 4× Hub + 1× Pusher |
| Antrieb | T-Motor P60 KV170 (Hub) + MN501-S KV340 (Pusher) |
| Akku | 14S3P + 14S2P asymmetrisch, MOSFET-trennbar |
| Endurance | 68–73 min |
| Reichweite | ~75 km |
| Schwebeschub-Faktor | 2,10× |
| Windtoleranz im Hover | bis 10 m/s |
| Payload (Universal-Container) | bis 2,28 kg |
| Sensorik-Standard | FLIR Boson 640 + Arducam 4K |
| Companion-PC | NVIDIA Jetson Orin NX 16GB |
| Avionik | Holybro Pixhawk 6X (PX4 Quadplane) |

## Verzeichnisstruktur

```
Hermes-VTOL/
├── 01_Dokumentation/          Lastenheft, Pflichtenheft, SORA, Zulassung, Protokolle
├── 02_Aerodynamik/            XFLR5-Profile, OpenVSP-Modelle, Polaren
├── 03_CAD/                    Fusion-360-Master, STEP/IGES-Exporte
├── 04_FEM_Simulation/         Lastfälle, FEM-Modelle, Reports
├── 05_Fertigung/              CNC-Programme, 3D-Druck, Layup-Schedules
├── 06_Avionik_Software/       PX4-Config, Jetson-Code, YOLO-Modelle, ROS2
├── 07_Tests/                  Boden-/Flugtests, Protokolle
├── 08_Payload_Module/         4 Container-Module + Universal-Container
├── 09_Regulatorik/            EU SORA, EASA PDRA, FAA Part 107, Versicherung
├── 10_Beschaffung/            Lieferanten, Datenblätter, Bestellungen
├── 11_Bilder_Renderings/      CAD-Renderings, Prototyp-Fotos
├── 12_Skripte_Tools/          Python-Simulationen, OpenVSP-Batch, CAD-Makros
├── 13_VPS_Config/             Hostinger-VPS-Setup (Hermes-Agent-Instanz)
├── build/                     Generierte Outputs (Git-ignored)
└── .github/                   CI/CD Workflows + Issue-Templates
```

## Dokumentation

- **[Lastenheft v1.1](01_Dokumentation/Lastenheft/Lastenheft-VTOL-Zivildrohne.md)** — vollständige Spezifikation (667 Zeilen)

## Tooling

- **CAD:** Fusion 360 (Haupt-CAD) + Onshape (Kleinteile-Ausnahmen)
- **CAM:** Fusion 360 (Werkzeugwege für CNC-Fräse)
- **Aerodynamik:** OpenVSP + XFLR5
- **FEM:** Fusion 360 Simulation
- **Software:** PX4 Autopilot, ROS 2 Humble, JetPack 6.0+

## Workflow

```bash
# Initial-Setup (einmalig)
git clone https://github.com/Superkatzo/Hermes-VTOL.git
cd Hermes-VTOL

# Änderungen committen
git add .
git commit -m "Aussagekräftige Beschreibung"
git push
```

## Lizenz

Aktuell **privates Repository** — Lizenzentscheidung ausstehend.

## Kontakt

Superkatzo (@Superkatzo)
