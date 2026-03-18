# Changelog

## 2.6.15

- Fix: Added DNS configuration for external API calls (logo web search)
- Fix: Ensured Google DNS servers are available for external requests
- Docs: Updated README with current version and sponsor links

## 2.6.14

- Fix: Removed non-existent php83-filter and php83-phar packages (filter is built-in)
- Fix: Build errors resolved

## 2.6.13

- Fix: Added php83-filter and php83-phar extensions for logo web search functionality
- Fix: Removed duplicate PHP extension loading from php.ini
- Fix: Added allow_url_include = Off for security

## 2.6.12

- Revert: Rolled back problematic Nginx configuration changes that broke web interface
- Fix: Restored working configuration from version 2.6.8
- Note: Logo URL double-slash issue still under investigation

## 2.6.8

- Fix: Normalized double slashes in logo URLs via Nginx merge_slashes directive
- Debug: Added symlink verification logging at startup

## 2.6.7

- Fix: Direct persistent binding of logo and temp directories without migration
- Simplified directory structure for better reliability

## 2.6.0

- Docs: Added comprehensive API documentation with all endpoints and 6 REST sensors

## 2.5.2

- Docs: Updated Data Storage and Redirect Loop sections, replaced homeassistant.local with localhost

## 2.5.1

- Docs: Improved documentation with correct URLs, ports, and English translations

## 2.5.0

- Docs: Added Home Assistant REST sensor integration guide and UI examples

## 2.4.1

- Fix: Resolved white screen issue by restoring native Wallos database initialization and migration scripts

## 2.4.0

- Major Refactoring: Removed legacy SQL hacks and simplified directory persistence to allow native UI database imports

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
