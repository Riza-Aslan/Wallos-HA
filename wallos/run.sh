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

bashio::log.info "Bereite Wallos vor..."

# 1. Nginx Proxy-Fix (verhindert den Redirect-Loop hinter Home Assistant)
sed -i 's/fastcgi_params;/fastcgi_params;\n        fastcgi_param HTTPS on;/' /etc/nginx/http.d/default.conf

# 2. Persistenz simpel und sicher
bashio::log.info "Setze Datenbank-Persistenz..."
mkdir -p /data/db

# Falls Wallos beim Image-Build schon eine leere DB erstellt hat, rüberkopieren (nur wenn /data noch leer ist)
if [ ! -f /data/db/wallos.db ] && [ -f /var/www/html/db/wallos.db ]; then
    cp -a /var/www/html/db/* /data/db/
fi

# Original löschen und Symlink setzen
rm -rf /var/www/html/db
ln -sf /data/db /var/www/html/db

# Rechte vergeben
chown -R nginx:nginx /data/db
chmod -R 777 /data/db

# 3. Persistenz für Logos und Temp
mkdir -p /data/wallos/logos
mkdir -p /data/wallos/tmp
ln -sf /data/wallos/logos /var/www/html/images/uploads/logos
ln -sf /data/wallos/tmp /var/www/html/.tmp
chmod -R 777 /data/wallos/logos
chmod -R 777 /data/wallos/tmp

# 4. Web-Verzeichnis Rechte
chmod -R 755 /var/www/html
chown -R nginx:nginx /var/www/html

# 5. PHP-FPM Konfiguration
mkdir -p /run/php
chown -R nginx:nginx /run/php
sed -i 's/user = .*/user = nginx/' /etc/php83/php-fpm.d/www.conf
sed -i 's/group = .*/group = nginx/' /etc/php83/php-fpm.d/www.conf

# 6. PHP-FPM starten
bashio::log.info "Starting PHP-FPM..."
php-fpm83 -R -D

# Wait for PHP-FPM to be ready
sleep 2

# 7. Nginx starten
bashio::log.info "Starting Nginx web server..."
exec nginx -g "daemon off;"
