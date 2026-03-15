# Home Assistant Add-on: Wallos

## Einrichtung

### 1. Add-on installieren

1. Gehe zu **Einstellungen** → **Add-ons** → **Add-on-Store** (drei Punkte oben rechts → Repositories)
2. Füge dieses Repository hinzu: `https://github.com/Riza-Aslan/Wallos-HA`
3. Suche nach "Wallos" und klicke auf **Installieren**
4. Konfiguriere die Optionen nach deinen Wünschen
5. Starte das Add-on

### 2. Erster Zugriff

Nach dem Start kannst du Wallos auf zwei Arten erreichen:

- **Ingress (Empfohlen)**: Klicke auf "Öffnen" oder nutze die Sidebar
- **Direkt**: Öffne `http://[HA-IP]:8282` in deinem Browser

### 3. Admin-Account erstellen

Beim ersten Zugriff wirst du aufgefordert, einen Admin-Account zu erstellen.

## Umgebungsvariablen

Alle Konfigurationsoptionen werden als Umgebungsvariablen an den Container übergeben. Dies ermöglicht eine einfache Konfiguration über die Home Assistant Add-on UI.

### Verfügbare Variablen

| Variable | Typ | Standard | Beschreibung |
|----------|-----|----------|--------------|
| `TZ` | string | `Europe/Berlin` | Zeitzone für korrekte Datumsanzeige |
| `DEMO_MODE` | bool | `false` | Aktiviert Demo-Modus (keine Datenänderungen) |
| `DISABLE_LOGIN` | bool | `false` | Deaktiviert Login (Sicherheitsrisiko!) |
| `DISABLE_REGISTRATION` | bool | `true` | Verhindert neue Registrierungen |
| `MAX_USERS` | int | `0` | Max. Benutzer (0 = unbegrenzt) |
| `ENABLE_EMAIL_VERIFICATION` | bool | `false` | E-Mail-Verifizierung für neue Accounts |
| `ENABLE_SSO` | bool | `true` | Home Assistant SSO Auto-Login |
| `SMTP_ADDRESS` | string | - | SMTP Server für E-Mails |
| `SMTP_PORT` | port | `587` | SMTP Port |
| `SMTP_USERNAME` | string | - | SMTP Login |
| `SMTP_PASSWORD` | password | - | SMTP Passwort |
| `SMTP_ENCRYPTION` | list | `tls` | tls, ssl oder none |
| `FROM_EMAIL` | email | - | Absenderadresse |
| `SERVER_URL` | url | - | Öffentliche URL (für Links in E-Mails) |

## Ingress Konfiguration

Das Add-on ist für Home Assistant Ingress konfiguriert:

```json
"ingress": true,
"ingress_port": 80,
"ingress_entry": "/",
"ingress_stream": true
```

### Vorteile von Ingress

- Keine Port-Freigaben notwendig
- SSL/TLS über Home Assistant
- Einheitlicher Login
- Zugriff über Sidebar

### Direkter Zugriff (optional)

Wenn du Wallos auch direkt (ohne Ingress) erreichen möchtest:
- Port 8282 auf dem Host ist verfügbar
- Nützlich für API-Zugriffe oder mobile Apps

## Home Assistant SSO (Single Sign-On)

Das Add-on unterstützt automatisches Einloggen über deinen Home Assistant Benutzer!

### Wie funktioniert SSO?

1. Du klickst auf "Wallos" in der Home Assistant Sidebar
2. Das Add-on erkennt die HA Ingress-Verbindung
3. Es fragt die Home Assistant API nach deinem Benutzernamen
4. Ein Wallos-Benutzer wird automatisch erstellt (falls nicht vorhanden)
5. Du bist sofort eingeloggt - ohne Passwort!

### SSO aktivieren

In der Add-on Konfiguration:
```yaml
ENABLE_SSO: true
```

### Voraussetzungen

- Zugriff über **Home Assistant Ingress** (Sidebar)
- SSO funktioniert **nicht** beim direkten Zugriff über Port 8282
- Der HA-Benutzername wird als Wallos-Benutzername verwendet

### Benutzerzuordnung

| Home Assistant | Wallos |
|----------------|--------|
| `Max Mustermann` | `Max_Mustermann` |
| `admin` | `admin` |
| `john.doe` | `john_doe` |

Sonderzeichen werden durch Unterstriche ersetzt.

### SSO deaktivieren

Falls du manuelle Anmeldung bevorzugst:
```yaml
ENABLE_SSO: false
```

Dann musst du dich normal über den Wallos-Login anmelden.

## E-Mail Konfiguration

### Gmail Beispiel

```
SMTP_ADDRESS: smtp.gmail.com
SMTP_PORT: 587
SMTP_USERNAME: deine@gmail.com
SMTP_PASSWORD: xxxx xxxx xxxx xxxx  (App-Passwort!)
SMTP_ENCRYPTION: tls
FROM_EMAIL: deine@gmail.com
```

### Outlook/Office365 Beispiel

```
SMTP_ADDRESS: smtp.office365.com
SMTP_PORT: 587
SMTP_USERNAME: deine@outlook.de
SMTP_PASSWORD: dein-passwort
SMTP_ENCRYPTION: tls
FROM_EMAIL: deine@outlook.de
```

## Datensicherung

Die Daten werden im `/config/wallos/` Verzeichnis gespeichert:

```
/config/wallos/
├── db/
│   └── wallos.db          # SQLite Datenbank
└── logos/
    └── avatars/           # Hochgeladene Bilder
```

### Backup erstellen

1. **Automatisch**: Nutze das Home Assistant Backup-System
2. **Manuell**: Kopiere das `/config/wallos/` Verzeichnis

### Wiederherstellen

1. Stoppe das Add-on
2. Stelle das `/config/wallos/` Verzeichnis wieder her
3. Starte das Add-on

## Problemlösung

### Add-on startet nicht

- Prüfe die Add-on Logs auf Fehler
- Stelle sicher, dass Port 8282 nicht belegt ist (falls ohne Ingress)
- Prüfe ob genügend Speicherplatz vorhanden ist

### Ingress funktioniert nicht

- Aktualisiere Home Assistant auf die neueste Version
- Leere den Browser-Cache
- Prüfe die Browser-Konsole auf Fehler

### Datenbankfehler

- Lösche `/config/wallos/db/wallos.db` und starte neu
- Dies erstellt eine neue, leere Datenbank
- Vorherige Daten gehen verloren!

### E-Mails werden nicht versendet

- Prüfe SMTP-Einstellungen
- Bei Gmail: App-Passwort verwenden, nicht das normale Passwort
- Prüfe die Logs auf SMTP-Fehler

## GitHub Actions

Das Add-on wird automatisch über GitHub Actions gebaut:

- **Trigger**: Push zu main, PR, wöchentlich (Sonntag 3:00 UTC)
- **Architekturen**: aarch64, amd64, armhf, armv7, i386
- **Registry**: GitHub Container Registry (ghcr.io)
- **Versionierung**: Automatisch basierend auf Datum (YYYY.MM.DD)

### Automatische Wallos-Version

Das Dockerfile holt sich **automatisch die neueste stabile Version** von Wallos:

```dockerfile
# Fragt die GitHub API nach dem neuesten Release
WALLOS_VERSION=$(curl -s https://api.github.com/repos/ellite/Wallos/releases/latest | jq -r '.tag_name')
```

Durch den **wöchentlichen Rebuild** (Sonntag 3:00 UTC) wird das Add-on automatisch mit der neuesten Wallos-Version aktualisiert, sobald ein neues Release erscheint.

### Manueller Rebuild

Falls du sofort ein Update erzwingen möchtest:
1. Gehe zu **Actions** in deinem GitHub Repository
2. Wähle **Build Wallos HA Add-on**
3. Klicke auf **Run workflow** → **Run workflow**
