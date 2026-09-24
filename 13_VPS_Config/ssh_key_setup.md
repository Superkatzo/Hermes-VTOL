# SSH-Key-Setup für Hostinger-VPS

## Übersicht

| Schritt | Aktion |
| --------- | -------- |
| **1** | SSH-Key generieren (auf deinem PC) |
| **2** | Public-Key im Hostinger-Webpanel hinterlegen |
| **3** | Beim VPS-Setup "SSH-Key-Auth" wählen |
| **4** | Verbindung testen |

## Generierter Schlüssel

Du hast bereits ein Schlüsselpaar erstellt:

| Datei | Pfad | Zweck |
|-------|------|-------|
| **Privat** | `~/.ssh/hostinger_vps` | Bleibt auf deinem PC |
| **Öffentlich** | `~/.ssh/hostinger_vps.pub` | Wird auf den VPS kopiert |

### Fingerprint

```text
SHA256:Adi1Y6xKW5p4zzgaPFzuPWIctTKPv9kjVMUE6cB/32k
```text

### Public Key (zur Anzeige)

```bash
cat ~/.ssh/hostinger_vps.pub
```text

## SSH-Config (auf deinem PC)

Datei: `~/.ssh/config`

```text
Host hermes-vps
    HostName <IP-des-VPS>
    User hermes
    Port 22
    IdentityFile ~/.ssh/hostinger_vps
    IdentitiesOnly yes
    ServerAliveInterval 60
    ServerAliveCountMax 3
```text

**Verbindung testen:**

```bash
ssh hermes-vps
```text

## Hostinger-Webpanel: Public-Key eintragen

1. Login auf **hpanel.hostinger.com**
2. **VPS** → dein VPS auswählen
3. **SSH-Schlüssel** oder **SSH Access** Sektion
4. **"Schlüssel hinzufügen"** klicken
5. **Public-Key einfügen** (Inhalt von `~/.ssh/hostinger_vps.pub`)
6. Speichern
7. Beim nächsten VPS-Setup die Option "SSH-Key" wählen

## Verbindung testen (Schritt-für-Schritt)

```bash
# Vom PC aus
ssh hermes-vps

# Du solltest eine Welcome-Nachricht sehen und
# einen Shell-Prompt: hermes@<hostname>:~$
```text

Falls die Verbindung fehlschlägt:

- IP-Adresse korrekt eingetragen in `~/.ssh/config`?
- Public-Key richtig im Hostinger-Panel?
- Firewall auf deinem PC aktiv (Port 22 outbound)?
- SSH-Agent läuft? → `eval $(ssh-agent)` + `ssh-add ~/.ssh/hostinger_vps`

## Mehrere SSH-Keys verwalten

Falls du weitere VPS oder Dienste hast, kannst du in `~/.ssh/config` weitere Hosts anlegen:

```text
Host github.com
    IdentityFile ~/.ssh/id_ed25519_github

Host anderer-server
    HostName 192.168.1.50
    User pi
    IdentityFile ~/.ssh/id_ed25519_raspi
```text

## Sicherheit

- **Niemals** den privaten Schlüssel (`hostinger_vps`) teilen!
- Bei Verlust: neuen Schlüssel generieren und alten aus dem VPS entfernen
- Bei Sicherheitsbedenken: Schlüssel widerrufen (aus `~/.ssh/authorized_keys` auf dem VPS löschen)
