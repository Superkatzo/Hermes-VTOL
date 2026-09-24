# 06_Avionik_Software

Flight-Controller-Konfiguration, Companion-Computer-Code, KI-Modelle.

## Inhalt

| Ordner | Zweck |
| -------- | ------- |
| **PX4_Config/** | Airframe-Config, Parameter-Files, Mixer-Setups für Quadplane |
| **Jetson_Code/** | Python/C++ Code für Jetson Orin NX (Objekterkennung, Bildverarbeitung) |
| **YOLO_Modelle/** | Trainierte YOLO/RT-DETR Modelle für SAR, Wildschutz, Behörden |
| **ROS2_Pakete/** | ROS 2 Humble Packages (Mavros-Bridge, Sensor-Driver) |
| **Telemetrie/** | C2-Link-Konfiguration, MAVLink-Profile, Verschlüsselung |

## PX4-Quadplane-Setup

- Airframe: `Generic Quadplane VTOL`
- Konfiguration: `4x Hub-Quad am Rumpf + 1x Heck-Pusher`
- Transition: Schwellwert-basiert (Front-Airspeed > 14 m/s)
- Modes: `Mission`, `Position`, `Hold`, `Return`, `Land`, `Offboard` (für Companion-PC)
- Failsafes: Akku, GPS, RC, Telemetrie

## Jetson-Pipeline

```text
Boson 640 (Thermal)
        │
        ▼
GStreamer-Pipeline
        │
        ├──▶ YOLOv10 / RT-DETR (Detektion)
        │
        └──▶ MAVLink Telemetry → GCS
```text

## KI-Modelle

- **SAR-Personen-Detektion:** YOLOv10n auf Thermal-Daten (FLIR ADAS)
- **Wildschutz-Tiererkennung:** Custom-trainiert auf lokale Fauna
- **Behörden-Fahrzeugerkennung:** COCO-pre-trained, fine-tuned auf Polizei-Assets
