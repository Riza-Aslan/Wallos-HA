ARG BUILD_FROM
FROM ${BUILD_FROM}

# Set version label
LABEL io.hass.type="addon"
LABEL io.hass.name="Wallos"
LABEL io.hass.description="Open-Source Subscription Tracker"

# Set environment variables
ENV WALLOS_VERSION="2.38.0"
ENV PHP_VERSION="83"

# Install dependencies
RUN apk add --no-cache \
    nginx \
    php${PHP_VERSION} \
    php${PHP_VERSION}-fpm \
    php${PHP_VERSION}-pdo \
    php${PHP_VERSION}-pdo_sqlite \
    php${PHP_VERSION}-sqlite3 \
    php${PHP_VERSION}-curl \
    php${PHP_VERSION}-dom \
    php${PHP_VERSION}-gd \
    php${PHP_VERSION}-intl \
    php${PHP_VERSION}-mbstring \
    php${PHP_VERSION}-openssl \
    php${PHP_VERSION}-zip \
    php${PHP_VERSION}-xml \
    php${PHP_VERSION}-session \
    php${PHP_VERSION}-tokenizer \
    php${PHP_VERSION}-xmlwriter \
    php${PHP_VERSION}-simplexml \
    php${PHP_VERSION}-phar \
    php${PHP_VERSION}-ctype \
    php${PHP_VERSION}-fileinfo \
    php${PHP_VERSION}-xmlreader \
    php${PHP_VERSION}-posix \
    php${PHP_VERSION}-iconv \
    php${PHP_VERSION}-exif \
    php${PHP_VERSION}-sodium \
    php${PHP_VERSION}-opcache \
    php${PHP_VERSION}-pecl-imagick \
    sqlite \
    sqlite-dev \
    curl \
    jq \
    tzdata

# Download and extract Wallos
RUN mkdir -p /var/www/html && \
    curl -sL "https://github.com/ellite/Wallos/archive/refs/tags/v${WALLOS_VERSION}.tar.gz" | \
    tar xz -C /var/www/html --strip-components=1

# Configure PHP-FPM
RUN sed -i "s|;daemonize = yes|daemonize = no|g" /etc/php${PHP_VERSION}/php-fpm.conf && \
    sed -i "s|user = nobody|user = root|g" /etc/php${PHP_VERSION}/php-fpm.d/www.conf && \
    sed -i "s|group = nobody|group = root|g" /etc/php${PHP_VERSION}/php-fpm.d/www.conf && \
    sed -i "s|listen = 127.0.0.1:9000|listen = /var/run/php-fpm.sock|g" /etc/php${PHP_VERSION}/php-fpm.d/www.conf && \
    sed -i "s|;listen.owner = nobody|listen.owner = root|g" /etc/php${PHP_VERSION}/php-fpm.d/www.conf && \
    sed -i "s|;listen.group = nobody|listen.group = root|g" /etc/php${PHP_VERSION}/php-fpm.d/www.conf && \
    sed -i "s|;listen.mode = 0660|listen.mode = 0666|g" /etc/php${PHP_VERSION}/php-fpm.d/www.conf

# Configure NGINX
COPY nginx.conf /etc/nginx/nginx.conf

# Copy run script
COPY run.sh /run.sh
RUN chmod a+x /run.sh

# Create necessary directories and set permissions
RUN mkdir -p /var/www/html/db && \
    mkdir -p /var/www/html/images/uploads/logos && \
    mkdir -p /var/www/html/.tmp && \
    chmod -R 777 /var/www/html/db && \
    chmod -R 777 /var/www/html/images/uploads/logos && \
    chmod -R 777 /var/www/html/.tmp

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
    CMD curl -f http://localhost/health.php || exit 1

CMD [ "/run.sh" ]
