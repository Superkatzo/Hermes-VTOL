# XFLR5 Profil-Vergleich — Input-Sheet für Hermes-VTOL

> **Zweck:** Vorbereitete Eingabeparameter für eine XFLR5-Sitzung.
> **Was du mitnimmst:** Welche Profile, welche Re-Zahlen, welche α-Bereiche, was du am Ende wissen willst.
> **Empfohlene Sitzungs-Dauer:** 2-3 h

---

## 1. Profil-Auswahl (3 Kandidaten)

| # | Profil | Datei | Quelle |
|---|---|---|---|
| 1 | **Wortmann FX 63-137** | `FX_63_137.dat` | [airfoiltools.com](https://airfoiltools.com/airfoil/details?airfoil=fx63137-il) |
| 2 | **NACA 4412** | `naca4412-il.dat` | [airfoiltools.com](https://airfoiltools.com/airfoil/details?airfoil=naca4412-il) |
| 3 | **Eppler 423** | `e423-il.dat` | [airfoiltools.com](https://airfoiltools.com/airfoil/details?airfoil=e423-il) |

**Hinweis:** `.dat`-Format ist Standard für XFoil/XFLR5. Download in `02_Aerodynamik/Profile/`.

---

## 2. Analyse-Modi in XFLR5

### Modus 1: Direkte Profilanalyse (XFoil Direct)

**Weg:** XFLR5 → File → Open → Profile auswählen → `Direct Foil Analysis`

**Eingaben:**

| Parameter | Wert | Begründung |
|---|---|---|
| **Re-Zahlen** | 100.000 / 200.000 / 300.000 / 400.000 / 500.000 | Landeanflug → Reiseflug |
| **α-Bereich** | −5° bis +15° in 0,5°-Schritten | Deckt Cruise bis Stall ab |
| **Nkrit** | 9 (Standard) | Übliche Laminar-Grenze |
| **Max Iterationen** | 200 | Konvergenz |
| **Output:** | CL, CD, CM, CL/CD | Polaren + α-Kurven |

**Was am Ende rauskommt:**
- 15 α-Werte × 5 Re-Zahlen × 3 Profile = **225 Datenpunkte pro Profil**
- Polare: CD vs. CL, CL/CD vs. α
- Stall-Winkel, CL_max pro Re-Zahl

### Modus 2: Lifting-Line-Theory (LLT)

**Weg:** XFLR5 → `Design` → `Wing and Plane Design` → LLT-Analyse

**Eingaben für Hermes-Flügel:**

| Parameter | Wert |
|---|---|
| **Spannweite** | 2,0 m |
| **Flügelfläche** | ~50 dm² (geschätzt) |
| **Sehnentiefe** | Mittel 25 cm, variabel (Trapez?) |
| **V-Form** | 2°–4° |
| **Auftriebsverteilung** | Elliptisch (Sollwert) |
| **Profil** | nacheinander für alle 3 |
| **Anstellwinkel** | −2° bis +12° |

**Was am Ende rauskommt:**
- 3D-CL_alpha-Kurve für die ganze Fläche
- Induced Drag (CDi) bei verschiedenen α
- Effektive V-Form-Empfehlung

### Modus 3: VLM / 3D Panel (optional, später)

Genauer als LLT, aber langsamer. Empfohlen für **Detail-Design** nach Profil-Auswahl.

---

## 3. Was am Ende dokumentiert werden muss

Datei: `02_Aerodynamik/Profil-Vergleich-Ergebnisse.md`

### Inhalts-Template:

```markdown
# Profil-Vergleich-Ergebnisse (Hermes-VTOL)

## Test-Bedingungen
- Datum, XFLR5-Version
- Re-Zahlen-Liste

## Pro Profil: Tabelle

| Re | α_zero | CL_max | CD_min | L/D_max | Stall-α | Stall-Typ |
|---|---|---|---|---|---|---|
| 300.000 | ... | ... | ... | ... | ... | weich/hart |

## Ranking

| Kriterium | Gewicht | FX 63-137 | NACA 4412 | Eppler 423 | Gewinner |
|---|---|---|---|---|---|
| L/D max | 30 % | ⭐⭐⭐ | ⭐⭐ | ⭐⭐⭐ | FX/Ep |
| Stall-Sicherheit | 25 % | ⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐ | FX/NACA |
| ... | ... | ... | ... | ... | ... |

## Entscheidung

**Empfehlung:** FX 63-137 (oder was auch immer rauskommt)

**Begründung:** [aus den Daten]

## Konsequenz für Hermes-VTOL

- Profil wird in CAD übernommen (Flügel-Rippen-Layout, Holmradius)
- LLT-Bestätigung der Spannweite (vielleicht auf 2,1 m anpassen)
- Wing-Loading neu rechnen (Flügelfläche jetzt bekannt)
```

---

## 4. Vorab-Rechnungen (zur Plausibilisierung)

### Re-Zahl im Reiseflug

```
Re = (ρ × V × c) / μ
   = (1,225 × 18 × 0,25) / 1,81e-5
   ≈ 305.000
```

- ρ = 1,225 kg/m³ (Meereshöhe)
- V = 18 m/s (Cruise)
- c = 0,25 m (mittlere Sehnentiefe)
- μ = 1,81e-5 Pa·s (Luft-Viskosität)

### Re-Zahl bei Start (langsamer)

```
V_Takeoff = 15 m/s (Hub + langsamer Vorwärtsflug)
Re = 1,225 × 15 × 0,25 / 1,81e-5 ≈ 254.000
```

### Erwartete CD-Werte (zur Plausibilisierung)

| Profil | CD_min bei Re=300k | L/D_max | Quelle |
|---|---|---|---|
| FX 63-137 | ~0,0065 | ~40-45 | typische Wert aus UIUC-Datenbank |
| NACA 4412 | ~0,0080 | ~28-35 | NACA-Report |
| Eppler 423 | ~0,0060 | ~35-42 | UIUC-Datenbank |

**Wenn deine Ergebnisse um >30% davon abweichen → Re-Berechnung, Re-Zahl-Eingabe prüfen.**

---

## 5. Workflow-Schritte (konkret)

| # | Schritt | Dauer |
|---|---|---|
| 1 | Profile als `.dat` downloaden | 5 min |
| 2 | XFLR5 öffnen, Profil laden | 2 min |
| 3 | Direkte Analyse für Re 300k | 10 min |
| 4 | Dasselbe für alle 3 Profile | 30 min |
| 5 | Re 100k, 200k, 400k, 500k ergänzen | 30 min |
| 6 | LLT-Analyse mit FX 63-137 | 30 min |
| 7 | Ergebnisse dokumentieren | 30 min |
| 8 | Ranking + Entscheidung | 15 min |

**Total:** ~2,5 h

---

## 6. Was du danach hast

- ✅ Klarer Profil-Favorit für Hermes-Flügel
- ✅ L/D_max-Bestätigung (oder Kurskorrektur)
- ✅ Stall-Margin dokumentiert
- ✅ Daten für CAD (Rippen-Schablonen, Holm-Höhe)
- ✅ Daten für Lastenheft (Flugleistung, Endurance)

---

## 7. Tipps & Tricks

- **Nkrit = 9** ist Standard; niedrigere Werte (z. B. 5) simulieren verschmutztere Oberflächen
- **Max α** nicht zu hoch setzen (XFOil konvergiert schlecht bei >15°)
- **Triangular-Sweep:** Für schnellen Überblick erst bei Re = 300k alle 3 Profile rechnen, dann nur die zwei besten genauer
- **Speichern:** XFLR5 speichert Projekte als `.xfl` — gut für Wieder-Verwendung
- **Export:** Rechtsklick auf Graph → `Export CSV` für Daten-Export in Python/MATLAB

---

## 8. Referenzen

- **XFLR5 Download:** [sourceforge.net/projects/xflr5](https://sourceforge.net/projects/xflr5/)
- **UIUC Airfoil Database:** [m-selig.ae.illinois.edu/ads.html](https://m-selig.ae.illinois.edu/ads.html)
- **Airfoiltools:** [airfoiltools.com](https://airfoiltools.com/)
- **Tutorial-Videos:** YouTube "XFLR5 tutorial" (z. B. [RC Soaring](https://www.youtube.com/results?search_query=xflr5+tutorial))
- **Wortmann FX-Serie Paper:** [Wortmann FX 63-137 Originaldokument](http://www.dfrc.nasa.gov/Dfrc/Wordfiles/Wortmann.pdf)
