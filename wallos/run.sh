#!/usr/bin/with-contenv bashio
set -e

bashio::log.info "==================================================="
bashio::log.info " Starte Wallos Add-on..."
bashio::log.info "==================================================="

chmod -R 777 /var/www/html/db
chmod -R 777 /var/www/html/images/uploads/logos
chmod -R 777 /var/www/html/.tmp

if [ ! -f /var/www/html/db/wallos.db ]; then
    bashio::log.info "Erstelle neue Wallos Datenbank..."
    php /var/www/html/endpoints/cronjobs/createdatabase.php || true
fi

bashio::log.info "Führe Datenbank-Migrationen aus..."
php /var/www/html/endpoints/db/migrate.php || true

bashio::log.info "Starte PHP-FPM im Hintergrund..."
php-fpm83 -D

sleep 2

bashio::log.info "Starte Nginx Webserver..."
exec nginx -g "daemon off;"
