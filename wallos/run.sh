#!/usr/bin/with-contenv bashio
set -e

bashio::log.info "==================================================="
bashio::log.info " Starting Wallos Add-on..."
bashio::log.info "==================================================="

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

# Sicherstellen, dass das Datenbank-Verzeichnis im Web-Ordner existiert
mkdir -p /var/www/html/db

# Falls die Datenbank noch nicht in /data liegt, dorthin verschieben oder neu erstellen
if [ ! -f /data/wallos.db ]; then
    bashio::log.info "Initialisiere persistente Datenbank in /data..."
    # Falls durch den Build eine leere DB in /var/www/html/db liegt, diese als Basis nehmen
    [ -f /var/www/html/db/wallos.db ] && mv /var/www/html/db/wallos.db /data/wallos.db
    touch /data/wallos.db
fi

# Symbolischen Link setzen, damit Wallos die Datenbank in /data findet
ln -sf /data/wallos.db /var/www/html/db/wallos.db
chown nginx:nginx /data/wallos.db
chmod 777 /data/wallos.db

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
