# 07_Tests

Boden- und Flugtests, Protokolle.

## Inhalt

| Ordner | Zweck |
| -------- | ------- |
| **Boden_Tests/** | Vibration, EMV, IP-Rating, Temperatur-Schock |
| **Flug_Tests/** | Hover, Transition, Endurance, BVLOS |
| **Test_Protokolle/** | Ausgefüllte Testberichte, Checklisten |
| **Wind_Tunnel/** | (optional) Aerodynamik-Validierung |

## Test-Phasen (gemäß Lastenheft Kapitel 6.2.1)

| Phase | Dauer | Betriebsbewilligung |
| ------- | ------- | --------------------- |
| 1 — Ground Tests | 2 Wo | keine |
| 2 — Tethered Hover | 1 Wo | Indoor / gesichert |
| 3 — Free Hover | 2 Wo | Open-A1 |
| 4 — Transition Tests | 2 Wo | Open-A2 mit Aufsicht |
| 5 — Endurance | 2 Wo | PDRA-S01 |
| 6 — BVLOS | 4 Wo | Specific Category / SORA |

## Wichtige Validierungen

- Stall-Speed-Bestimmung (XFLR5-Vorhersage verifizieren)
- L/D-Verifikation im Reiseflug (Energie-Methode)
- Transition-Sicherheit (mehrere Geschwindigkeitsbereiche)
- Schub-Reserve bei 12 m/s Wind
- BVLOS-Latenz-Messung (C2-Link)
- SAR-Sensorik-Reichweite (Thermal-Personen-Detektion bei 200 m)
