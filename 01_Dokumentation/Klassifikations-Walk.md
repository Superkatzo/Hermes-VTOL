# 🎯 Welche Klasse bekommt mein VTOL? — Klassifikations-Walk

> **Die zentrale Frage für jeden Drohnen-Hersteller.** Welche Klasse bekommt dein Gerät?

---

## 🪜 Schritt 1: Ist es eine Drohne?

| Frage | Antwort |
|-------|---------|
| Unbemanntes Luftfahrzeug? | ✅ ja |
| Wird außerhalb der Person des Betreibers betrieben? | ✅ ja |

→ **Ja, es ist eine Drohne (UAS).**

---

## 🪜 Schritt 2: Wo fällt es in das Klassensystem?

### Größengrenze 25 kg

| Was | Masse |
|-----|-------|
| 16 kg | **<25 kg** |

→ **Unter 25 kg — kommt in das Klassen-System C0-C4.**

⚠️ **ABER**: Wenn deine Drohne ÜBER Personen fliegen soll (SAR), kann sie aus der „Open Category" fallen → **Specific Category**.

### Klasse der Drohne (Produkt-Kennzeichnung)

| Klasse | Definition | Wahrscheinlich? |
| -------- | ----------- | ----------------- |
| **C0** | ≤250 g, Public-Safety, langsam | ❌ du bist 16 kg |
| **C1** | ≤80 Joule kinetische Energie, ≤900 g | ❌ du bist zu schwer |
| **C2** | 80–<500 Joule, ≤4 kg | ❌ du bist zu schwer |
| **C3** | <25 kg, mit Personen-Überflug eingeschränkt | ⚠️ möglich |
| **C4** | <25 kg, nicht über Unbeteiligte, „Controlled Ground Area" | ⚠️ möglich |

**→ Dein 16-kg VTOL fällt in Klasse C3 oder C4.**

---

## 🪜 Schritt 3: Welche Sub-Klasse genau?

### C3 vs C4

| Frage | C3 | C4 |
| ------- | ---- | ---- |
| **Max MTOM** | 25 kg | 25 kg |
| **Personen-Überflug** | Eingeschränkt möglich | **Nein** |
| **Annex-Teil der VO 945** | Part 1, Anhang | Part 1, Anhang |
| **Geschwindigkeitslimit** | Keine Angabe | Nein |
| **Höhenlimit** | 120 m | 120 m |
| **Pilot-Sichtverbindung** | VLOS/EVLOS möglich | VLOS/EVLOS |
| **Geo-Awareness** | Pflicht | Pflicht |

### 🎯 Welche passt für SAR?

| Use-Case | Empfehlung |
| ---------- | ------------ |
| **SAR** (Über Suchgebieten) | **C3** — eingeschränkter Personen-Überflug möglich |
| **Wildschutz** (über Wald/Tier) | **C3 oder C4** — beide möglich |
| **Infrastruktur-Inspektion** (Brücken, Strom) | **C3** — oft über Strassen/Parkplätze |
| **Landwirtschaft** (offene Felder) | **C4** möglich |

**→ Für SAR meist C3, weil du über Menschen in Not suchst/findest.**

---

## 🪜 Schritt 4: Wann fällt es aus dem C-System raus?

### 🚨 „Specific Category" (= SORA-Pflicht)

Deine Drohne kommt in die **Specific Category**, wenn:

| Bedingung | Relevant für dich? |
| ----------- | --------------------- |
| Über Menschenmengen | ✅ SAR möglich |
| Betrieb außerhalb Sichtweite (BVLOS) | ✅ du brauchst BVLOS |
| Über Wohngebieten | ⚠️ wenn du in Städten suchst |
| Nachts | ✅ du fliegst Tag+Nacht |
| Mit危险品 (Gefahrgut) | ❌ du hast keine Gefahrstoffe |
| >25 kg | ❌ du bist 16 kg |

→ **Du brauchst die Specific Category für deine Use-Cases.**

→ **Das bedeutet: Käufer braucht SORA-Analyse + LBA-Genehmigung.**

### 🚨 „Certified Category" (= Type-Certificate)

| Wann? | Relevant? |
| ------- | ----------- |
| Transport von Menschen | ❌ nein |
| >25 kg, hohes Risiko | ❌ du bist 16 kg |
| Flughafen-Nähe, hohes Risiko | ⚠️ je nach Mission |
| Betrieb in 5+ km CTR | möglich |
| Über Menschenansammlungen > 50 Personen | möglich |

**→ Wahrscheinlich bist du NICHT in der Certified Category**, weil du nur 16 kg wiegst und primär Wildschutz/SAR machst.

**→ Bestätigung: Specific Category mit SORA.**

---

## 🎯 Deine finale Klassifikation

| Frage | Antwort |
| ------- | --------- |
| **Produkt-Klasse** | **C3** (oder C4 wenn keine SAR-Personen-Überflüge) |
| **Betriebs-Kategorie** | **Specific Category** (SORA erforderlich) |
| **Type-Design-Requirement** | entsprechend Klasse C3 herstellen |
| **Käufer braucht** | **SORA-Analyse** + LBA-Specific-Cat-Genehmigung |

---

## 📋 Was du als Hersteller bauen musst

### Pflicht-Komponenten für C3

| Komponente | Pflicht |
| ----------- | --------- |
| **Direct Remote Identification** (Broadcast von ID + Position) | 🔴 Pflicht |
| **Geo-Awareness** (eingebaut, update-fähig) | 🔴 Pflicht |
| **Akustisches Limit** (z.B. 85 dB) | 🔴 Pflicht |
| **Lichter** (Sichtbar, Ortung) | 🔴 Pflicht |
| **Batterie-Warnung** (Reichweite, Spannung) | 🔴 Pflicht |
| **Betriebs-Manual** mit Sicherheits-Hinweisen | 🔴 Pflicht |

### Freiwillig, aber für SAR + BVLOS dringend empfohlen

| Komponente | Warum |
| ----------- | ------- |
| **Fallschirm-System** | ASTM F3322 konform, Notfall-Landung über Menschen |
| **Auto-Landing** | wenn Funkverbindung weg |
| **Geo-Fence** | virtuelle NO-FLY-Zonen |
| **Daten-Logging** (Black-Box) | für Forensik nach Unfällen |
| **Redundante Sensoren** | IMU, GPS, Kompass, Barometer |

---

## 💰 Was kostet die Zulassung?

### Variante 1: Klasse C3 + Specific-Betrieb (Käufer macht SORA)

| Was | Kosten |
| ----- | -------- |
| **C3-Compliance nachweisen** | intern (€5–15k) |
| **Konformitäts-Test** | Zertifizierer (€5–10k) |
| **Bedienungs-Anleitung** | extern (€2–5k) |
| **Produkthaftpflicht** | Versicherung (€500–2k/Jahr) |
| **Designer-Zeit** | ~6 Monate Vollzeit (deine Zeit) |

### Variante 2: Klasse C5 oder Certified (falls nötig)

| Was | Kosten |
| ----- | -------- |
| **EASA Type-Certificate** | €80–250k |
| **C5-Compliance** | €20–50k |
| **Zertifizierer** | zusätzlich |
| **Designer-Zeit** | ~12–24 Monate |

**→ Deine C3+SORA-Konstellation ist die pragmatischste Wahl. Käufer macht den Rest.**

---

## 🛡️ „Was wenn ich >25 kg werde?"

Falls du irgendwann auf 25–150 kg skalieren willst:

| Klasse | Größe | Aufwand |
| -------- | ------- | --------- |
| **C5** | 25–100 kg, „privat" | mittel-hoch (eigenes Zertifizierungs-Verfahren) |
| **C6** | wie C5, eingeschränkt | mittel-hoch |
| **Certified** | kommerziell behördlich | hoch |

**Aktuell bleibst du bei 16 kg und C3 — das ist optimal für deinen Pilot-Markt.**

---

## 📂 Welche Original-Dokumente für was?

| Dokument | Welche Kapitel? |
| ---------- | ----------------- |
| **EU-VO 2019/945** | Annex Part 1 (Klasse C3/C4 Definitionen) |
| **EU-VO 2019/947** | Artikel 5 (Specific Category Definition) |
| **JARUS SORA 2.5** | die ganze Methodik |

---

## Letzte Aktualisierung

2026-09-22
