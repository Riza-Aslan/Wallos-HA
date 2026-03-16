#!/usr/bin/with-contenv bashio
set -e

bashio::log.info "==================================================="
bashio::log.info " Starting Wallos Add-on..."
bashio::log.info "==================================================="

# Debug: Check /data contents
bashio::log.info "Inhalt von /data beim Start:"
ls -R /data

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

# Datenbank verlinken
mkdir -p /var/www/html/db
if [ -f /data/wallos.db ]; then
    bashio::log.info "Verlinke persistente Datenbank..."
    rm -f /var/www/html/db/wallos.db
    ln -sf /data/wallos.db /var/www/html/db/wallos.db
    chown nginx:nginx /data/wallos.db
    chmod 777 /data/wallos.db
else
    bashio::log.info "Keine Datenbank gefunden. Initialisiere neu..."
    cd /var/www/html/endpoints/cronjobs
    php createdatabase.php
    cd /var/www/html
    mv /var/www/html/db/wallos.db /data/wallos.db
    rm -f /var/www/html/db/wallos.db
    ln -sf /data/wallos.db /var/www/html/db/wallos.db
    chown nginx:nginx /data/wallos.db
    chmod 777 /data/wallos.db
fi

# SQL-Fix nur ausführen, wenn die Spalte 'val' oder 'value' existiert
if sqlite3 /data/wallos.db "PRAGMA table_info(settings);" | grep -qE 'val|value'; then
    bashio::log.info "Führe SQL-Redirect-Fix aus..."
    sqlite3 /data/wallos.db "UPDATE settings SET val = '0' WHERE name = 'https';" || true
    sqlite3 /data/wallos.db "UPDATE settings SET value = '0' WHERE name = 'https';" || true
    sqlite3 /data/wallos.db "UPDATE settings SET val = 'https://hass.as-lan.eu' WHERE name = 'url';" || true
    sqlite3 /data/wallos.db "UPDATE settings SET value = 'https://hass.as-lan.eu' WHERE name = 'url';" || true
else
    bashio::log.warning "Alte Datenbank-Struktur erkannt. Überspringe SQL-Fix, Nginx übernimmt."
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

# Nginx Konfiguration für Proxy-Betrieb anpassen (Redirect-Loop Fix)
bashio::log.info "Passe Nginx für Proxy-Betrieb an..."
sed -i 's/fastcgi_params;/fastcgi_params;\n        fastcgi_param HTTPS on;/' /etc/nginx/http.d/default.conf

# Start PHP-FPM in background (allow root with -R)
bashio::log.info "Starting PHP-FPM..."
php-fpm83 -R -D

# Wait for PHP-FPM to be ready
sleep 2

# Start Nginx
bashio::log.info "Starting Nginx web server..."
exec nginx -g "daemon off;"
