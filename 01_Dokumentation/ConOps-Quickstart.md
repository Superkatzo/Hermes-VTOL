# ConOps Quickstart — Hermes-VTOL (1-Seiten-Übersicht für Käufer)

> **Zweck:** Kompakte 1-Seiten-Übersicht für SAR-/Wildschutz-/Behörden-Käufer, die ihre ConOps schnell aufsetzen wollen.
> **Detail-Vorlage:** siehe `ConOps-Vorlage-SAR.md` (vollständige Vorlage, 370 Zeilen, 10 Sektionen)

---

## Was ist eine ConOps und warum brauchst du sie?

Eine **Concept of Operations (ConOps)** ist Pflicht-Anlage für jeden SORA-Antrag (Specific Operations Risk Assessment) nach EU 2019/947. Ohne ConOps → keine Betriebsgenehmigung in der **Specific Category**.

Diese Quickstart hilft dir, die ConOps in **30 Minuten** aufzusetzen statt in 8 h.

---

## Schritt 1: Basics (5 min)

| Frage | Beispiel-Antwort |
|---|---|
| **Wer fliegt?** | Bergwacht Bereitschaft XYZ, Pilot: M. Mustermann |
| **Was?** | Vermisstensuche im alpinen Gelände |
| **Wo?** | Bayern, Oberland, bis 2 km Radius um die Basis |
| **Wann?** | Tageslicht, Wochenenden + Feiertage |

## Schritt 2: Equipment (10 min)

| Hermes-VTOL-Komponente | Deine Konfiguration |
|---|---|
| **M1 SAR-Modul** | ✅ Thermal (640×512), Lautsprecher, Scheinwerfer, TETRA-Relay |
| **Akku** | 14S3P Molicel P45B, ~700 Wh |
| **Bodenstation** | QGroundControl auf Rugged-Laptop |
| **C2-Link** | 2,4 GHz, ~10 km Reichweite, verschlüsselt |
| **Notfall-Landing** | Auto-Landing bei Link-Loss > 5 s |

## Schritt 3: Personal (10 min)

| Rolle | Person | Zertifikat |
|---|---|---|
| **PIC (Pilot-in-Command)** | M. Mustermann | A2 + STS-01 |
| **Beobachter (VO)** | optional | Online-Training |
| **Operator-Manager** | E. Schmidt | LBA-Registrierung |

## Schritt 4: Sicherheits-Konzept (5 min)

- **Geo-Caging:** Aktiv (max. Operationsradius 2 km um Startpunkt)
- **FTS:** Auto-Landing bei C2-Loss > 5 s
- **M2-Mitigation:** Fallschirm (optional, empfohlen für SAR)
- **Wettergrenzen:** < 10 m/s Wind, kein Regen > 2 mm/h, Sicht > 5 km
- **No-Fly-Zonen:** Menschenansammlungen, Flughäfen (5 km Puffer)

## Schritt 5: Anhangs-Liste (zum Erstellen)

- [ ] Karte des Operationsgebiets (mit No-Fly-Zonen)
- [ ] Notfall-Response-Plan (Kontaktliste: Rettungsleitstelle, LBA)
- [ ] Wartungs-Logbuch-Vorlage (siehe Hermes-VTOL Maintenance-Logbuch.md)
- [ ] Pilot-Schulungs-Zertifikate (Kopien)
- [ ] Versicherungs-Nachweis (Halterhaftpflicht, ≥ €1,5 Mio)

---

## Welche SORA-Stufe erreichst du damit?

Mit dieser Quickstart + vollständiger ConOps-Vorlage erreichst du typischerweise **SAIL II**, was bedeutet:

- **BVLOS bis 2 km** (mit C5/STS-01)
- **Reduzierte OSO-Anforderungen** (~6 statt 12)
- **Declaration statt vollständigem LBA-Antrag**

→ **Time-to-Market:** ca. 6-8 Wochen für SORA-Consultant + LBA

## Nächste Schritte

1. Vollständige Vorlage durcharbeiten: `ConOps-Vorlage-SAR.md`
2. SORA-Schritte 2-5 durchgehen (siehe `09_Regulatorik/EU_SORA/`)
3. EASA-C-Class prüfen: `Drohnenklasse_C0_bis_C6.md`
4. Beim LBA (Landesluftfahrtbehörde) registrieren als Operator

## Weiterführende Links

- **EASA Opinion No 05-2019** (STS-01/02, C5/C6): [easa.europa.eu](https://www.easa.europa.eu/sites/default/files/dfu/Opinion%20No%2005-2019.pdf)
- **SORA-Paket (JARUS)**: [jarus-unmanned.org](https://jarus-unmanned.org/)
- **Hermes-VTOL SORA-Schritte-Skelett:** siehe Skill `vtol-experte` Sektion 13
