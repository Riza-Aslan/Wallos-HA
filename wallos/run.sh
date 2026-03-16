#!/usr/bin/with-contenv bashio
set -e

bashio::log.info "==================================================="
bashio::log.info " Starting Wallos Add-on..."
bashio::log.info "==================================================="

# Debug: Check /data contents
bashio::log.info "Inhalt von /data beim Start:"
ls -R /data

# Nginx Fix: HTTPS-Header für Proxy-Betrieb erzwingen (stoppt Redirect-Loop)
bashio::log.info "Passe Nginx für Proxy-Betrieb an..."
sed -i 's/fastcgi_params;/fastcgi_params;\n        fastcgi_param HTTPS on;/' /etc/nginx/http.d/default.conf

# Get timezone from config
TIMEZONE=$(bashio::config 'timezone')
if [ -n "${TIMEZONE}" ]; then
    bashio::log.info "Setting timezone to ${TIMEZONE}"
    cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime
    echo "${TIMEZONE}" > /etc/timezone
    export TZ="${TIMEZONE}"
fi

# Ensure data directory exists and has correct permissions
mkdir -p /data/wallos/logos
mkdir -p /data/wallos/tmp

# Create symlinks for persistent storage
ln -sf /data/wallos/logos /var/www/html/images/uploads/logos
ln -sf /data/wallos/tmp /var/www/html/.tmp

# Set permissions for logos and tmp
chmod -R 777 /data/wallos/logos
chmod -R 777 /data/wallos/tmp

bashio::log.info "Isoliere das Datenbank-Verzeichnis..."
mkdir -p /data/db

# 1. Alte Datenbank in den neuen Ordner umziehen, falls vorhanden
if [ -f /data/wallos.db ]; then
    bashio::log.info "Verschiebe bestehende Datenbank in den neuen Ordner..."
    mv /data/wallos.db /data/db/wallos.db
fi

# 2. Falls der Ordner IMMER NOCH leer ist, sauber initialisieren!
if [ ! -f /data/db/wallos.db ]; then
    bashio::log.info "Keine Datenbank gefunden. Initialisiere sauberes Fundament..."
    mkdir -p /var/www/html/db
    php /var/www/html/endpoints/cronjobs/createdatabase.php
    mv /var/www/html/db/* /data/db/ 2>/dev/null || true
fi

# 3. Ordner-Symlink setzen
rm -rf /var/www/html/db
ln -sf /data/db /var/www/html/db
chown -R nginx:nginx /data/db
chmod -R 777 /data/db

# SQL-Fix nur ausführen, wenn die Spalte 'val' oder 'value' existiert
if [ -f /data/db/wallos.db ]; then
    if sqlite3 /data/db/wallos.db "PRAGMA table_info(settings);" | grep -qE 'val|value'; then
        bashio::log.info "Führe SQL-Redirect-Fix aus..."
        sqlite3 /data/db/wallos.db "UPDATE settings SET val = '0' WHERE name = 'https';" || true
        sqlite3 /data/db/wallos.db "UPDATE settings SET value = '0' WHERE name = 'https';" || true
        sqlite3 /data/db/wallos.db "UPDATE settings SET val = 'https://hass.as-lan.eu' WHERE name = 'url';" || true
        sqlite3 /data/db/wallos.db "UPDATE settings SET value = 'https://hass.as-lan.eu' WHERE name = 'url';" || true
    else
        bashio::log.warning "Alte Datenbank-Struktur erkannt. Überspringe SQL-Fix, Nginx übernimmt."
    fi
fi

# Set permissions for web directory
chmod -R 755 /var/www/html
chown -R nginx:nginx /var/www/html

bashio::log.info "Führe Datenbank-Migrationen aus..."
cd /var/www/html/endpoints/db
# Wir warten kurz, um Sperr-Konflikte zu vermeiden
sleep 2
php migrate.php || true
cd /var/www/html

# Create PHP socket directory
mkdir -p /run/php
chown -R nginx:nginx /run/php

# Configure PHP-FPM for Alpine (user is nginx, not www-data)
sed -i 's/user = .*/user = nginx/' /etc/php83/php-fpm.d/www.conf
sed -i 's/group = .*/group = nginx/' /etc/php83/php-fpm.d/www.conf

# Start PHP-FPM in background (allow root with -R)
bashio::log.info "Starting PHP-FPM..."
php-fpm83 -R -D

# Wait for PHP-FPM to be ready
sleep 2

# Start Nginx
bashio::log.info "Starting Nginx web server..."
exec nginx -g "daemon off;"
