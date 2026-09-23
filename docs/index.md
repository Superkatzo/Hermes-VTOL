---
layout: default
title: Hermes-VTOL
---

# 🚁 Hermes-VTOL

**Zivile VTOL-Drohne (Quadplane) für SAR, Wildschutz, Behörden und kommerzielle Inspektion.**

> *„Der Pickup-Truck der Lüfte" — vielseitig, modular, nützlich.*

---

## 🎯 Was ist Hermes-VTOL?

Hermes-VTOL ist eine Quadplane-Plattform mit Klappmechanismus, konzipiert für **professionelle Anwendungen** in zivilen Einsätzen:

- 🚁 **Search and Rescue (SAR)** — Vermisstensuche, Lageerkundung
- 🦌 **Wildschutz** — Tierbeobachtung, Anti-Wilderei
- 🏛️ **Behörden-Einsätze** — Polizei, Zoll, Feuerwehr
- ⚡ **Infrastruktur-Inspektion** — Stromleitungen, Windkraft, Pipelines

## 📊 Eckdaten

| Parameter | Wert |
|-----------|------|
| Spannweite | 2,2–2,4 m (klappbar) |
| MTOM | 16 kg |
| Payload | 2,3 kg |
| Antrieb | 4 Hub + 1 Pusher, elektrisch |
| Akku | 14S4P Li-Ion 6500 mAh (325 Wh/kg) |
| Endurance | 45–60 min |

## 📖 Wer profitiert von diesem Projekt?

Diese Dokumentation entsteht für:
- 🤖 **SAR-Vereine** — die eine Drohne für mehrere Missionen suchen
- 🏞️ **Wildschutz-Behörden** — die täglich Waldgebiete überwachen
- 🏛️ **Behörden** — die eine modulare Plattform brauchen
- ⚡ **Infrastruktur-Betreiber** — die Inspektionen automatisieren wollen

---

## 📰 Neueste Updates

{% for post in site.posts limit:5 %}
### {{ post.date | date: "%d.%m.%Y" }} — [{{ post.title }}]({{ post.url }})
{% if post.excerpt %}{{ post.excerpt | strip_html | truncate: 200 }}{% endif %}
{% endfor %}

## 🔗 Weiterführend

- 📋 [Lastenheft (v1.1, MTOM 16 kg)]({{ site.baseurl }}/lastenheft.html)
- 📜 [Regulatorik-Kurzfassung (Hersteller-Sicht)]({{ site.baseurl }}/regulatorik-kurzfassung.html)
- 🛡️ [ConOps-Vorlage SAR]({{ site.baseurl }}/conops-vorlage-sar.html)
- 💰 [Kosten-Realität]({{ site.baseurl }}/kosten-realtaet.html)

## 📚 Projekt-Repository

Alle Quellen, Skripte und Dokumentation sind offen verfügbar:

🔗 [github.com/Superkatzo/Hermes-VTOL](https://github.com/Superkatzo/Hermes-VTOL)

---

*Hard-Rules: Zivil-only. Keine militärische Verwendung. Keine Waffen. Professional, ruhig, klar — keine Cyberpunk-Ästhetik.*
