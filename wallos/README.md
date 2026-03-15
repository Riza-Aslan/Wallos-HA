# Home Assistant Add-on: Wallos

Wallos ist ein Open-Source Abonnement-Tracker, der dir hilft, deine wiederkehrenden Zahlungen im Auge zu behalten.

![Supports aarch64 Architecture][aarch64-shield] ![Supports amd64 Architecture][amd64-shield] ![Supports armhf Architecture][armhf-shield] ![Supports armv7 Architecture][armv7-shield] ![Supports i386 Architecture][i386-shield]

## Funktionen

- Abonnement-Verwaltung mit Kategorien
- Mehrwährungs-Unterstützung
- Benachrichtigungen (E-Mail, Telegram, Discord, etc.)
- Kalenderansicht für anstehende Zahlungen
- Statistiken und Auswertungen
- Mehrbenutzer-Unterstützung
- OIDC/OAuth-Unterstützung
- Zwei-Faktor-Authentifizierung
- **Home Assistant Ingress Integration**

## Installation

1. Füge dieses Repository zu deinen Home Assistant Add-ons hinzu
2. Installiere das "Wallos" Add-on
3. Konfiguriere die Optionen (siehe unten)
4. Starte das Add-on
5. Öffne Wallos über die Sidebar (Ingress) oder direkt unter `http://[HA-IP]:8282`

## Konfiguration

### Allgemeine Optionen

| Option | Beschreibung | Standard |
|--------|--------------|----------|
| `TZ` | Zeitzone | `Europe/Berlin` |
| `DEMO_MODE` | Demo-Modus aktivieren | `false` |
| `DISABLE_LOGIN` | Login deaktivieren (nicht empfohlen) | `false` |
| `DISABLE_REGISTRATION` | Registrierung deaktivieren | `true` |
| `MAX_USERS` | Maximale Benutzeranzahl (0 = unbegrenzt) | `0` |

### E-Mail / SMTP Optionen

| Option | Beschreibung | Standard |
|--------|--------------|----------|
| `ENABLE_EMAIL_VERIFICATION` | E-Mail-Verifizierung erforderlich | `false` |
| `SMTP_ADDRESS` | SMTP Server Adresse | - |
| `SMTP_PORT` | SMTP Server Port | `587` |
| `SMTP_USERNAME` | SMTP Benutzername | - |
| `SMTP_PASSWORD` | SMTP Passwort | - |
| `SMTP_ENCRYPTION` | Verschlüsselung (tls/ssl/none) | `tls` |
| `FROM_EMAIL` | Absender E-Mail-Adresse | - |
| `SERVER_URL` | Öffentliche Server URL | - |

### Beispiel-Konfiguration

```yaml
TZ: Europe/Berlin
DEMO_MODE: false
DISABLE_REGISTRATION: true
MAX_USERS: 5
ENABLE_EMAIL_VERIFICATION: true
SMTP_ADDRESS: smtp.gmail.com
SMTP_PORT: 587
SMTP_USERNAME: deine@email.de
SMTP_PASSWORD: dein-app-passwort
SMTP_ENCRYPTION: tls
FROM_EMAIL: wallos@deine-domain.de
SERVER_URL: https://wallos.deine-domain.de
```

## Ingress & SSO

Das Add-on unterstützt Home Assistant Ingress mit **Single Sign-On (SSO)**:

### Ingress
- Wallos ist direkt über die Home Assistant Sidebar erreichbar
- Keine Port-Freigaben im Router notwendig
- SSL/TLS wird von Home Assistant übernommen

### SSO (Single Sign-On)
- **Automatisches Einloggen** mit deinem Home Assistant Benutzer
- Kein separates Passwort für Wallos nötig
- Benutzer werden automatisch erstellt
- Funktioniert nur über die Sidebar (Ingress)

## Datenpersistenz

Alle Daten werden im Home Assistant Config-Verzeichnis gespeichert:
- `/config/wallos/db/` - SQLite Datenbank
- `/config/wallos/logos/` - Hochgeladene Logos und Avatare

**Wichtig:** Sichere regelmäßig das `/config/wallos/` Verzeichnis!

## Erster Start

1. Nach dem ersten Start öffne Wallos über die Sidebar
2. Erstelle einen Admin-Account
3. Konfiguriere deine Währung und Zahlungsmethoden
4. Füge deine Abonnements hinzu

## Automatische Updates

Das Add-on wird wöchentlich automatisch über GitHub Actions neu gebaut, um die neueste Wallos-Version zu erhalten.

## Support

- [Wallos GitHub](https://github.com/ellite/Wallos)
- [Wallos Dokumentation](https://github.com/ellite/Wallos/wiki)
- [Add-on Issues](https://github.com/Riza-Aslan/Wallos-HA/issues)

[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
[armhf-shield]: https://img.shields.io/badge/armhf-yes-green.svg
[armv7-shield]: https://img.shields.io/badge/armv7-yes-green.svg
[i386-shield]: https://img.shields.io/badge/i386-yes-green.svg
