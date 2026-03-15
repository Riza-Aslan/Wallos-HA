ARG BUILD_FROM
FROM ${BUILD_FROM}

LABEL maintainer="Riza Aslan"
LABEL description="Wallos - Open-Source Subscription Tracker for Home Assistant"
LABEL org.opencontainers.image.source="https://github.com/ellite/Wallos"

# Set working directory
WORKDIR /var/www/html

# Install system dependencies
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
    shadow \
    sqlite \
    sqlite-dev \
    tzdata \
    unzip

# Install PHP extensions required by Wallos
RUN docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp && \
    docker-php-ext-install -j$(nproc) calendar gd intl pdo pdo_sqlite zip && \
    apk add --no-cache --virtual .build-deps $PHPIZE_DEPS && \
    pecl install imagick && \
    docker-php-ext-enable imagick && \
    apk del .build-deps

# Clone Wallos from GitHub (latest stable release)
# Automatically fetches the latest release tag from GitHub API
RUN apk add --no-cache jq && \
    WALLOS_VERSION=$(curl -s https://api.github.com/repos/ellite/Wallos/releases/latest | jq -r '.tag_name') && \
    echo "Building with Wallos version: ${WALLOS_VERSION}" && \
    git clone --depth 1 --branch ${WALLOS_VERSION} https://github.com/ellite/Wallos.git /tmp/wallos && \
    cp -r /tmp/wallos/* /var/www/html/ && \
    rm -rf /tmp/wallos && \
    # Store version info
    echo "${WALLOS_VERSION}" > /var/www/html/WALLOS_VERSION && \
    # Remove unnecessary files
    rm -f /var/www/html/Dockerfile \
          /var/www/html/docker-compose.yml \
          /var/www/html/.dockerignore \
          /var/www/html/.gitignore \
          /var/www/html/README.md \
          /var/www/html/LICENSE && \
    apk del jq

# Copy Nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf
COPY nginx.default.conf /etc/nginx/http.d/default.conf

# Remove nginx conf files from webroot if they exist
RUN rm -f /var/www/html/nginx.conf /var/www/html/nginx.default.conf

# Copy the custom crontab file
COPY cronjobs /etc/cron.d/cronjobs

# Setup cron, permissions and PHP-FPM configuration
RUN dos2unix /etc/cron.d/cronjobs && \
    chmod 0644 /etc/cron.d/cronjobs && \
    /usr/bin/crontab /etc/cron.d/cronjobs && \
    mkdir -p /var/log/cron && \
    mkdir -p /var/www/html/db && \
    mkdir -p /var/www/html/images/uploads/logos/avatars && \
    mkdir -p /var/www/html/.tmp && \
    chown -R www-data:www-data /var/www/html && \
    # PHP-FPM tuning
    echo 'pm = dynamic' >> /usr/local/etc/php-fpm.d/zz-docker.conf && \
    echo 'pm.max_children = 15' >> /usr/local/etc/php-fpm.d/zz-docker.conf && \
    echo 'pm.start_servers = 2' >> /usr/local/etc/php-fpm.d/zz-docker.conf && \
    echo 'pm.min_spare_servers = 1' >> /usr/local/etc/php-fpm.d/zz-docker.conf && \
    echo 'pm.max_spare_servers = 4' >> /usr/local/etc/php-fpm.d/zz-docker.conf && \
    echo 'pm.max_requests = 500' >> /usr/local/etc/php-fpm.d/zz-docker.conf && \
    # PHP configuration
    echo 'upload_max_filesize = 100M' >> /usr/local/etc/php/conf.d/custom.ini && \
    echo 'post_max_size = 100M' >> /usr/local/etc/php/conf.d/custom.ini && \
    echo 'memory_limit = 256M' >> /usr/local/etc/php/conf.d/custom.ini && \
    echo 'max_execution_time = 300' >> /usr/local/etc/php/conf.d/custom.ini

# Copy run script
COPY run.sh /run.sh
RUN chmod +x /run.sh

# Expose port 80 for Nginx
EXPOSE 80

ENTRYPOINT ["dumb-init", "--"]

# Start the application
CMD ["/run.sh"]
