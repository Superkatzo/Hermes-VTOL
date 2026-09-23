# 🔑 GitHub Personal Access Token (PAT) — für Telegram ↔ GitHub Push

> **Wozu:** Der `telegram_to_github.sh` auf dem VPS braucht GitHub-Auth, um Todo-Updates zu pushen.
> `gh auth` (CLI-Login) funktioniert auf dem VPS nicht — er ist auf deinem **lokalen PC** als `Superkatzo` aktiv.

---

## ⚠️ Sicherheits-Empfehlung: **Fine-Grained PAT** statt klassischer PAT

GitHub rät seit 2023 zu **Fine-Grained Personal Access Tokens**, weil sie:
- Nur **einzelne Repos** autorisieren (nicht alle)
- Nur **nötige Scopes** haben
- **Ablaufdatum** haben (du vergisst sie nicht ewig)

---

## 📋 Schritt-für-Schritt (30 Sekunden im Browser)

### 1. Browser-URL öffnen

👉 https://github.com/settings/tokens?type=beta

### 2. „Generate new token" klicken

### 3. Einstellungen

| Feld | Wert |
|---|---|
| **Token name** | `hermes-vps-telegram-bot` |
| **Expiration** | 90 days (du wirst erinnert) |
| **Description** | `Telegram-Bot auf VPS → Push Todo-Liste Updates in Hermes-VTOL Repo` |

### 4. Repository access

→ **Only select repositories**
→ **Superkatzo/Hermes-VTOL** wählen

### 5. Repository permissions (nur diese zwei nötig)

| Permission | Access |
|---|---|
| **Contents** | Read and write |
| **Metadata** | Read-only (Default, nicht ändern) |

### 6. „Generate token" klicken

### 7. **Token SOFORT kopieren** — er wird nur einmal angezeigt!

Format: `github_pat_11XXXXXX...`

---

## 📤 Token an mich übergeben

Schick mir den Token als Antwort im Chat, z. B.:

```
Mein GitHub-PAT: github_pat_11XXXXXX...rest
```

Ich werde ihn dann:
1. Per `ssh hermes-vps` sicher auf den VPS übertragen
2. In `/docker/hermes-agent-ekgx/data/.env` als `GITHUB_PAT=<token>` ablegen
3. Den `telegram_to_github.sh` so anpassen, dass er den Token nutzt (statt SSH-Key)
4. **Test-Push** machen (z. B. einen Dummy-Todo-Eintrag) und gleich wieder rückgängig machen
5. Token aus meinem **Chat-Verlauf** vergessen — keine Persistenz

---

## 🔒 Was du danach behältst

- Token läuft in 90 Tagen ab — du wirst vom GitHub-Cleaning-Tag (freitags 11:30 MESZ) erinnert, einen neuen zu generieren
- Wenn du früher widerrufen willst: https://github.com/settings/tokens?type=beta → Token anklicken → „Delete"

---

## 🛡️ Alternative (wenn du keinen Browser-PAT willst)

Ich kann auch einen **SSH-Deploy-Key** für das Repo anlegen — der ist noch sicherer als PAT. Ablauf:

1. Auf VPS: `ssh-keygen -t ed25519 -C "hermes-vps-deploy" -f ~/.ssh/github_deploy`
2. Public Key zu GitHub → Repo → Settings → Deploy keys → „Add deploy key" (mit **Write access**)
3. SSH-Config auf VPS: `Host github.com User git IdentityFile ~/.ssh/github_deploy`
4. `git push` benutzt dann den Key automatisch

**Sag mir einfach „SSH-Deploy-Key" wenn du das bevorzugst — ich richte alles ein.**
