#!/usr/bin/with-contenv bashio
set -e

echo "=== Wallos Home Assistant Add-on ==="
echo "Starting up..."

# Set timezone from config
if [ -n "$TZ" ]; then
    echo "Setting timezone to: $TZ"
    cp /usr/share/zoneinfo/$TZ /etc/localtime
    echo "$TZ" > /etc/timezone
fi

# Export environment variables for PHP
export DEMO_MODE="${DEMO_MODE:-false}"
export DISABLE_LOGIN="${DISABLE_LOGIN:-false}"
export DISABLE_REGISTRATION="${DISABLE_REGISTRATION:-true}"
export MAX_USERS="${MAX_USERS:-0}"
export ENABLE_EMAIL_VERIFICATION="${ENABLE_EMAIL_VERIFICATION:-false}"

# SMTP Settings
export SMTP_ADDRESS="${SMTP_ADDRESS:-}"
export SMTP_PORT="${SMTP_PORT:-587}"
export SMTP_USERNAME="${SMTP_USERNAME:-}"
export SMTP_PASSWORD="${SMTP_PASSWORD:-}"
export SMTP_ENCRYPTION="${SMTP_ENCRYPTION:-tls}"
export FROM_EMAIL="${FROM_EMAIL:-}"
export SERVER_URL="${SERVER_URL:-}"

# Save Supervisor token for SSO
if [ -n "$SUPERVISOR_TOKEN" ]; then
    echo "$SUPERVISOR_TOKEN" > /run/supervisor_token
    chmod 600 /run/supervisor_token
    echo "Supervisor token saved for SSO."
fi

# Create necessary directories
mkdir -p /var/www/html/db
mkdir -p /var/www/html/images/uploads/logos/avatars
mkdir -p /var/www/html/.tmp

# Set permissions
chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html/db
chmod -R 755 /var/www/html/images/uploads/logos

# Create database if it doesn't exist
if [ ! -f /var/www/html/db/wallos.db ]; then
    echo "Database does not exist. Creating it..."
    php /var/www/html/endpoints/cronjobs/createdatabase.php
fi

# Run database migrations
echo "Running database migrations..."
php /var/www/html/endpoints/db/migrate.php

# Apply environment-based settings to database
echo "Applying configuration from environment variables..."
php << 'PHPEOF'
<?php
$db = new SQLite3('/var/www/html/db/wallos.db');

// Update admin settings from environment variables
$settings = [
    'registrations_open' => getenv('DISABLE_REGISTRATION') === 'true' ? 0 : 1,
    'max_users' => (int)getenv('MAX_USERS'),
    'require_email_verification' => getenv('ENABLE_EMAIL_VERIFICATION') === 'true' ? 1 : 0,
    'server_url' => getenv('SERVER_URL') ?: '',
    'smtp_address' => getenv('SMTP_ADDRESS') ?: '',
    'smtp_port' => (int)(getenv('SMTP_PORT') ?: 587),
    'smtp_username' => getenv('SMTP_USERNAME') ?: '',
    'smtp_password' => getenv('SMTP_PASSWORD') ?: '',
    'encryption' => getenv('SMTP_ENCRYPTION') ?: 'tls',
    'from_email' => getenv('FROM_EMAIL') ?: '',
];

// Check if admin table exists and has data
$result = $db->query("SELECT COUNT(*) as count FROM admin");
$row = $result->fetchArray(SQLITE3_ASSOC);

if ($row['count'] > 0) {
    // Update existing admin settings
    foreach ($settings as $key => $value) {
        $stmt = $db->prepare("UPDATE admin SET $key = :value WHERE id = 1");
        $stmt->bindValue(':value', $value);
        $stmt->execute();
    }
    echo "Admin settings updated from environment variables.\n";
} else {
    echo "No admin user found. Settings will be applied after first registration.\n";
}

$db->close();
?>
PHPEOF

# Run initial cronjobs
echo "Running initial setup..."
php /var/www/html/endpoints/cronjobs/updatenextpayment.php || true
php /var/www/html/endpoints/cronjobs/updateexchange.php || true
php /var/www/html/endpoints/cronjobs/checkforupdates.php || true

# Start cron daemon
echo "Starting cron daemon..."
crond -b -l 2

# Start PHP-FPM in background
echo "Starting PHP-FPM..."
php-fpm83 -D

# Wait for PHP-FPM to be ready
sleep 2

# Start Nginx in foreground
echo "Starting Nginx..."
echo "Wallos is ready!"
nginx -g "daemon off;"
