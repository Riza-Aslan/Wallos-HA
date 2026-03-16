ARG BUILD_FROM
FROM ${BUILD_FROM}

# Set version label
LABEL io.hass.type="addon"
LABEL io.hass.name="Wallos"
LABEL io.hass.description="Open-Source Subscription Tracker"

# Set environment variables
ENV WALLOS_VERSION="2.38.0"

# Install minimal dependencies
RUN apk add --no-cache \
    nginx \
    php82 \
    php82-fpm \
    php82-sqlite3 \
    php82-pdo_sqlite \
    php82-curl \
    php82-dom \
    php82-gd \
    php82-intl \
    php82-mbstring \
    php82-openssl \
    php82-zip \
    php82-xml \
    sqlite \
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
    sed -i "s|user = nobody|user = root|g" /etc/php82/php-fpm.d/www.conf && \
    sed -i "s|group = nobody|group = root|g" /etc/php82/php-fpm.d/www.conf && \
    sed -i "s|listen = 127.0.0.1:9000|listen = /var/run/php-fpm.sock|g" /etc/php82/php-fpm.d/www.conf && \
    sed -i "s|;listen.owner = nobody|listen.owner = root|g" /etc/php82/php-fpm.d/www.conf && \
    sed -i "s|;listen.group = nobody|listen.group = root|g" /etc/php82/php-fpm.d/www.conf && \
    sed -i "s|;listen.mode = 0660|listen.mode = 0666|g" /etc/php82/php-fpm.d/www.conf

# Configure NGINX
COPY nginx.conf /etc/nginx/nginx.conf

# Copy run script to s6 service directory
COPY run.sh /etc/services.d/wallos/run

# Create necessary directories and set permissions
RUN mkdir -p /var/www/html/db && \
    mkdir -p /var/www/html/images/uploads/logos && \
    mkdir -p /var/www/html/.tmp && \
    chmod -R 777 /var/www/html/db && \
    chmod -R 777 /var/www/html/images/uploads/logos && \
    chmod -R 777 /var/www/html/.tmp

# Fix line endings and permissions for s6 service
RUN sed -i 's/\r$//' /etc/services.d/wallos/run && \
    chmod a+x /etc/services.d/wallos/run
