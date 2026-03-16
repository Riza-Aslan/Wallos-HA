#!/bin/bash
set -e

echo "==================================================="
echo " Starting Wallos Add-on..."
echo "==================================================="

# Source bashio if available
if [ -f /usr/lib/bashio/bashio.sh ]; then
    source /usr/lib/bashio/bashio.sh
fi

# Get timezone from config
if command -v bashio &> /dev/null; then
    TIMEZONE=$(bashio::config 'timezone')
else
    TIMEZONE="Europe/Berlin"
fi

if [ -n "${TIMEZONE}" ]; then
    echo "Setting timezone to ${TIMEZONE}"
    cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime
    echo "${TIMEZONE}" > /etc/timezone
    export TZ="${TIMEZONE}"
fi

# Ensure data directory exists and has correct permissions
DATA_PATH="/data/wallos"
mkdir -p "${DATA_PATH}/db"
mkdir -p "${DATA_PATH}/logos"
mkdir -p "${DATA_PATH}/tmp"

# Create symlinks for persistent storage
ln -sf "${DATA_PATH}/db" /var/www/html/db
ln -sf "${DATA_PATH}/logos" /var/www/html/images/uploads/logos
ln -sf "${DATA_PATH}/tmp" /var/www/html/.tmp

# Set permissions
chmod -R 777 "${DATA_PATH}/db"
chmod -R 777 "${DATA_PATH}/logos"
chmod -R 777 "${DATA_PATH}/tmp"

# Initialize database if it doesn't exist
if [ ! -f "${DATA_PATH}/db/wallos.db" ]; then
    echo "Creating new Wallos database..."
    php /var/www/html/endpoints/cronjobs/createdatabase.php || true
fi

# Run database migrations
echo "Running database migrations..."
php /var/www/html/endpoints/db/migrate.php || true

# Start PHP-FPM in background
echo "Starting PHP-FPM..."
php-fpm -D

# Wait for PHP-FPM to be ready
sleep 2

# Start Nginx
echo "Starting Nginx web server..."
exec nginx -g "daemon off;"
