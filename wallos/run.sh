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
DATA_PATH="/data/wallos"
mkdir -p "${DATA_PATH}/db"
mkdir -p "${DATA_PATH}/logos"
mkdir -p "${DATA_PATH}/tmp"

# Backup existing data and create symlinks
if [ -d "/var/www/html/db" ] && [ ! -L "/var/www/html/db" ]; then
    cp -r /var/www/html/db/* "${DATA_PATH}/db/" 2>/dev/null || true
    rm -rf /var/www/html/db
fi
if [ -d "/var/www/html/images/uploads/logos" ] && [ ! -L "/var/www/html/images/uploads/logos" ]; then
    cp -r /var/www/html/images/uploads/logos/* "${DATA_PATH}/logos/" 2>/dev/null || true
    rm -rf /var/www/html/images/uploads/logos
fi
if [ -d "/var/www/html/.tmp" ] && [ ! -L "/var/www/html/.tmp" ]; then
    cp -r /var/www/html/.tmp/* "${DATA_PATH}/tmp/" 2>/dev/null || true
    rm -rf /var/www/html/.tmp
fi

# Create symlinks for persistent storage
ln -sf "${DATA_PATH}/db" /var/www/html/db
ln -sf "${DATA_PATH}/logos" /var/www/html/images/uploads/logos
ln -sf "${DATA_PATH}/tmp" /var/www/html/.tmp

# Set permissions
chmod -R 777 "${DATA_PATH}/db"
chmod -R 777 "${DATA_PATH}/logos"
chmod -R 777 "${DATA_PATH}/tmp"
chown -R www-data:www-data /var/www/html

# Initialize database if it doesn't exist
if [ ! -f "${DATA_PATH}/db/wallos.db" ]; then
    bashio::log.info "Creating new Wallos database..."
    php /var/www/html/endpoints/cronjobs/createdatabase.php || true
fi

# Run database migrations
bashio::log.info "Running database migrations..."
php /var/www/html/endpoints/db/migrate.php || true

# Use the original startup script
bashio::log.info "Starting Wallos services..."
exec /var/www/html/startup.sh
