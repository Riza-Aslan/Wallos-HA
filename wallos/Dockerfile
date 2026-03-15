# Declare build arg before any FROM (required for Docker)
ARG BUILD_FROM

# Build stage for fetching Wallos
FROM alpine:3.19 AS builder

RUN apk add --no-cache git jq curl && \
    WALLOS_VERSION=$(curl -s https://api.github.com/repos/ellite/Wallos/releases/latest | jq -r '.tag_name') && \
    echo "Building with Wallos version: ${WALLOS_VERSION}" && \
    git clone --depth 1 --branch ${WALLOS_VERSION} https://github.com/ellite/Wallos.git /tmp/wallos && \
    echo "${WALLOS_VERSION}" > /tmp/wallos/WALLOS_VERSION

# Use Home Assistant base image for Supervisor API compatibility
FROM ${BUILD_FROM}

LABEL maintainer="Riza Aslan"
LABEL description="Wallos - Open-Source Subscription Tracker for Home Assistant"
LABEL org.opencontainers.image.source="https://github.com/ellite/Wallos"

# Set working directory
WORKDIR /var/www/html

# Install PHP 8.3 and all dependencies
RUN apk upgrade --no-cache && \
    apk add --no-cache \
    bash \
    curl \
    dcron \
    dos2unix \
    dumb-init \
    freetype \
    freetype-dev \
    git \
    icu-data-full \
    icu-dev \
    imagemagick \
    imagemagick-dev \
    libgomp \
    libjpeg-turbo \
    libjpeg-turbo-dev \
    libpng \
    libpng-dev \
    libwebp-dev \
    libzip-dev \
    nginx \
    php83 \
    php83-fpm \
    php83-ctype \
    php83-curl \
    php83-dom \
    php83-exif \
    php83-fileinfo \
    php83-gd \
    php83-iconv \
    php83-intl \
    php83-mbstring \
    php83-opcache \
    php83-openssl \
    php83-pdo \
    php83-pdo_sqlite \
    php83-phar \
    php83-session \
    php83-simplexml \
    php83-sqlite3 \
    php83-tokenizer \
    php83-xml \
    php83-xmlreader \
    php83-xmlwriter \
    php83-zip \
    php83-pecl-imagick \
    shadow \
    sqlite \
    sqlite-dev \
    tzdata \
    unzip

# Create PHP symlinks
RUN ln -sf /usr/bin/php83 /usr/bin/php && \
    ln -sf /usr/sbin/php-fpm83 /usr/sbin/php-fpm

# Copy Wallos from builder stage
COPY --from=builder /tmp/wallos/ /var/www/html/

# Remove unnecessary files
RUN rm -f /var/www/html/Dockerfile \
          /var/www/html/docker-compose.yml \
          /var/www/html/.dockerignore \
          /var/www/html/.gitignore \
          /var/www/html/README.md \
          /var/www/html/LICENSE

# Copy Nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf
COPY nginx.default.conf /etc/nginx/http.d/default.conf

# Remove nginx conf files from webroot if they exist
RUN rm -f /var/www/html/nginx.conf /var/www/html/nginx.default.conf

# Copy the custom crontab file
COPY cronjobs /etc/cron.d/cronjobs

# Setup PHP-FPM configuration
RUN mkdir -p /run/php && \
    cat > /etc/php83/php-fpm.d/www.conf << 'EOF'
[www]
user = www-data
group = www-data
listen = 127.0.0.1:9000
listen.owner = www-data
listen.group = www-data
pm = dynamic
pm.max_children = 15
pm.start_servers = 2
pm.min_spare_servers = 1
pm.max_spare_servers = 4
pm.max_requests = 500
clear_env = no
EOF

# PHP configuration
RUN cat > /etc/php83/conf.d/custom.ini << 'EOF'
upload_max_filesize = 100M
post_max_size = 100M
memory_limit = 256M
max_execution_time = 300
EOF

# Setup cron, permissions
RUN dos2unix /etc/cron.d/cronjobs && \
    chmod 0644 /etc/cron.d/cronjobs && \
    /usr/bin/crontab /etc/cron.d/cronjobs && \
    mkdir -p /var/log/cron && \
    mkdir -p /var/www/html/db && \
    mkdir -p /var/www/html/images/uploads/logos/avatars && \
    mkdir -p /var/www/html/.tmp && \
    chown -R www-data:www-data /var/www/html

# Copy run script
COPY run.sh /run.sh
RUN chmod +x /run.sh

# Expose port 80 for Nginx
EXPOSE 80

ENTRYPOINT ["dumb-init", "--"]

# Start the application
CMD ["/run.sh"]
