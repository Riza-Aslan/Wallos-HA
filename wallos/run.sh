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

# 1. Nginx Proxy-Fix (Intelligent: nur hinzufügen, wenn noch nicht vorhanden)
if ! grep -q "fastcgi_param HTTPS on;" /etc/nginx/http.d/default.conf; then
    sed -i 's/fastcgi_params;/fastcgi_params;\n        fastcgi_param HTTPS on;/' /etc/nginx/http.d/default.conf
fi

# 2. Persistenz
bashio::log.info "Setze Datenbank-Persistenz..."
mkdir -p /data/db

rm -rf /var/www/html/db
ln -sf /data/db /var/www/html/db

chown -R nginx:nginx /data/db
chmod -R 777 /data/db

# 3. Persistenz für Logos und Temp - direkt einbinden
mkdir -p /data/wallos/logos
mkdir -p /data/wallos/tmp

# Logos: Persistentes Verzeichnis direkt einbinden
rm -rf /var/www/html/images/uploads/logos
ln -sf /data/wallos/logos /var/www/html/images/uploads/logos

# Temp: Persistentes Verzeichnis direkt einbinden
rm -rf /var/www/html/.tmp
ln -sf /data/wallos/tmp /var/www/html/.tmp

# Berechtigungen setzen
chown -R nginx:nginx /data/wallos/logos
chown -R nginx:nginx /data/wallos/tmp
chmod -R 777 /data/wallos/logos
chmod -R 777 /data/wallos/tmp

# Debug: Symlinks überprüfen
bashio::log.info "Logo-Symlink: $(readlink -f /var/www/html/images/uploads/logos)"
bashio::log.info "Temp-Symlink: $(readlink -f /var/www/html/.tmp)"

# 4. Wallos System-Start (Zwingend erforderlich gegen weiße Seite)
bashio::log.info "Prüfe Wallos Datenbank-Status..."
if [ ! -f /data/db/wallos.db ]; then
    php /var/www/html/endpoints/cronjobs/createdatabase.php || true
fi

bashio::log.info "Führe Wallos System-Checks aus..."
cd /var/www/html/endpoints/db
php migrate.php || true
cd /var/www/html

# 5. Web-Verzeichnis Rechte
chmod -R 755 /var/www/html
chown -R nginx:nginx /var/www/html

# 6. PHP-FPM Konfiguration
mkdir -p /run/php
chown -R nginx:nginx /run/php
sed -i 's/user = .*/user = nginx/' /etc/php83/php-fpm.d/www.conf
sed -i 's/group = .*/group = nginx/' /etc/php83/php-fpm.d/www.conf

# 7. PHP-FPM starten
bashio::log.info "Starting PHP-FPM..."
php-fpm83 -R -D

# Wait for PHP-FPM to be ready
sleep 2

# 8. Nginx starten
bashio::log.info "Starting Nginx web server..."
exec nginx -g "daemon off;"
