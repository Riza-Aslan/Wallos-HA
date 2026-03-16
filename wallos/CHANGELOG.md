# Changelog

## 2.3.2

- Added auto-migration for existing databases to the new directory structure and fixed initial setup crash

## 2.3.1

- Refactored database persistence from file-level to directory-level to prevent SQLite WAL-file loss upon container restart

## 2.3.0

- Critical fix: Corrected bashio logging and prioritized Nginx redirect fix

## 2.2.9

- Bugfix: Corrected bashio log command and improved symlink reliability for persistent storage

## 2.2.8

- Fix: Corrected bashio log command and forced HTTPS param in Nginx to break redirect loops

## 2.2.7

- Fix: Resolved redirect loop via Nginx fastcgi_param and improved DB schema compatibility

## 2.2.6

- Fixed persistent storage mapping and improved SQL migration compatibility

## 2.2.5

- Critical: Fixed database persistence and dynamic column detection for redirect loops

## 2.2.4

- Improved SQL fix for redirect loops (compatibility for different DB schemas)

## 2.2.3

- Debug: Added /data directory logging at startup

## 2.2.2

- Fix: Resolved redirect loop after database import by disabling internal HTTPS enforcement

## 1.0.0

- Initial release
- Wallos 2.38.0
- Home Assistant Ingress support
- Multi-architecture support (armhf, armv7, aarch64, amd64, i386)
- Timezone configuration
- Persistent data storage
- Health check monitoring
