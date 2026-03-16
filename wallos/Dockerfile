ARG BUILD_FROM
FROM ${BUILD_FROM}

# Set version label
LABEL io.hass.type="addon"
LABEL io.hass.name="Wallos"
LABEL io.hass.description="Open-Source Subscription Tracker"

# Set environment variables
ENV WALLOS_VERSION="2.38.0"

# Install system dependencies and PHP 8.3 from edge repository
RUN echo "https://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories && \
    echo "https://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
    apk upgrade --no-cache && \
    apk add --no-cache \
    nginx \
    php83 \
    php83-fpm \
    php83-pdo \
    php83-pdo_sqlite \
    php83-sqlite3 \
    php83-curl \
    php83-dom \
    php83-gd \
    php83-intl \
    php83-mbstring \
    php83-openssl \
    php83-zip \
    php83-xml \
    php83-session \
    php83-phar \
    php83-ctype \
    php83-fileinfo \
    php83-posix \
    php83-iconv \
    php83-exif \
    php83-sodium \
    php83-opcache \
    php83-tokenizer \
    php83-xmlwriter \
    php83-simplexml \
    php83-xmlreader \
    php83-bcmath \
    php83-calendar \
    php83-sockets \
    php83-imagick \
    sqlite \
    sqlite-dev \
    curl \
    jq \
    tzdata

# Create symlinks for php commands
RUN ln -sf /usr/bin/php83 /usr/bin/php && \
    ln -sf /usr/sbin/php-fpm83 /usr/sbin/php-fpm

# Download and extract Wallos
RUN mkdir -p /var/www/html && \
    curl -sL "https://github.com/ellite/Wallos/archive/refs/tags/v${WALLOS_VERSION}.tar.gz" | \
    tar xz -C /var/www/html --strip-components=1

# Configure PHP-FPM
RUN sed -i "s|;daemonize = yes|daemonize = no|g" /etc/php83/php-fpm.conf && \
    sed -i "s|user = nobody|user = www-data|g" /etc/php83/php-fpm.d/www.conf && \
    sed -i "s|group = nobody|group = www-data|g" /etc/php83/php-fpm.d/www.conf && \
    sed -i "s|listen = 127.0.0.1:9000|listen = /var/run/php-fpm.sock|g" /etc/php83/php-fpm.d/www.conf && \
    sed -i "s|;listen.owner = nobody|listen.owner = www-data|g" /etc/php83/php-fpm.d/www.conf && \
    sed -i "s|;listen.group = nobody|listen.group = www-data|g" /etc/php83/php-fpm.d/www.conf && \
    sed -i "s|;listen.mode = 0660|listen.mode = 0666|g" /etc/php83/php-fpm.d/www.conf && \
    echo 'pm.max_children = 15' >> /etc/php83/php-fpm.d/www.conf && \
    echo 'pm.max_requests = 500' >> /etc/php83/php-fpm.d/www.conf

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
