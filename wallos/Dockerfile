ARG BUILD_FROM
FROM ${BUILD_FROM}

# Set version label
LABEL io.hass.type="addon"
LABEL io.hass.name="Wallos"
LABEL io.hass.description="Open-Source Subscription Tracker"

# Set environment variables
ENV WALLOS_VERSION="2.38.0"

# Install system dependencies (PHP 8.2 is available in Alpine 3.19)
RUN apk upgrade --no-cache && \
    apk add --no-cache \
    nginx \
    php82 \
    php82-fpm \
    php82-pdo \
    php82-pdo_sqlite \
    php82-sqlite3 \
    php82-curl \
    php82-dom \
    php82-gd \
    php82-intl \
    php82-mbstring \
    php82-openssl \
    php82-zip \
    php82-xml \
    php82-session \
    php82-phar \
    php82-ctype \
    php82-fileinfo \
    php82-posix \
    php82-iconv \
    php82-exif \
    php82-sodium \
    php82-opcache \
    php82-tokenizer \
    php82-xmlwriter \
    php82-simplexml \
    php82-xmlreader \
    php82-bcmath \
    php82-calendar \
    php82-sockets \
    php82-imagick \
    sqlite \
    sqlite-dev \
    curl \
    jq \
    tzdata

# Create symlinks for php commands
RUN ln -sf /usr/bin/php82 /usr/bin/php && \
    ln -sf /usr/sbin/php-fpm82 /usr/sbin/php-fpm

# Download and extract Wallos
RUN mkdir -p /var/www/html && \
    curl -sL "https://github.com/ellite/Wallos/archive/refs/tags/v${WALLOS_VERSION}.tar.gz" | \
    tar xz -C /var/www/html --strip-components=1

# Configure PHP-FPM
RUN sed -i "s|;daemonize = yes|daemonize = no|g" /etc/php82/php-fpm.conf && \
    sed -i "s|user = nobody|user = www-data|g" /etc/php82/php-fpm.d/www.conf && \
    sed -i "s|group = nobody|group = www-data|g" /etc/php82/php-fpm.d/www.conf && \
    sed -i "s|listen = 127.0.0.1:9000|listen = /var/run/php-fpm.sock|g" /etc/php82/php-fpm.d/www.conf && \
    sed -i "s|;listen.owner = nobody|listen.owner = www-data|g" /etc/php82/php-fpm.d/www.conf && \
    sed -i "s|;listen.group = nobody|listen.group = www-data|g" /etc/php82/php-fpm.d/www.conf && \
    sed -i "s|;listen.mode = 0660|listen.mode = 0666|g" /etc/php82/php-fpm.d/www.conf && \
    echo 'pm.max_children = 15' >> /etc/php82/php-fpm.d/www.conf && \
    echo 'pm.max_requests = 500' >> /etc/php82/php-fpm.d/www.conf

# Configure NGINX
COPY nginx.conf /etc/nginx/nginx.conf

# Copy run script
COPY run.sh /run.sh
RUN chmod a+x /run.sh

# Create necessary directories and set permissions
RUN mkdir -p /var/www/html/db && \
    mkdir -p /var/www/html/images/uploads/logos && \
    mkdir -p /var/www/html/.tmp && \
    chown -R www-data:www-data /var/www/html

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
    CMD curl -f http://localhost/health.php || exit 1

CMD [ "/run.sh" ]
