ARG BUILD_FROM
FROM ${BUILD_FROM}

# Set version label
LABEL io.hass.type="addon"
LABEL io.hass.name="Wallos"
LABEL io.hass.description="Open-Source Subscription Tracker"

# Wallos version (must be after FROM to be available in RUN)
ARG WALLOS_VERSION=v4.8.0

# Install minimal dependencies (PHP 8.3 from edge)
RUN echo "https://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories && \
    echo "https://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
    apk update && apk upgrade && \
    apk add --no-cache \
    libxml2 \
    nginx \
    php83 \
    php83-fpm \
    php83-sqlite3 \
    php83-pdo_sqlite \
    php83-curl \
    php83-dom \
    php83-gd \
    php83-intl \
    php83-mbstring \
    php83-openssl \
    php83-zip \
    php83-xml \
    php83-session \
    php83-tokenizer \
    php83-xmlwriter \
    php83-simplexml \
    php83-ctype \
    php83-iconv \
    php83-fileinfo \
    php83-exif \
    php83-calendar \
    php83-bcmath \
    php83-sockets \
    php83-posix \
    sqlite \
    curl \
    git \
    jq \
    tzdata

# Create symlinks for php commands
RUN ln -sf /usr/bin/php83 /usr/bin/php && \
    ln -sf /usr/sbin/php-fpm83 /usr/sbin/php-fpm

# Download and extract Wallos
RUN git clone --depth 1 --branch ${WALLOS_VERSION} https://github.com/ellite/Wallos.git /tmp/wallos_download && \
    mkdir -p /var/www/html && \
    cp -a /tmp/wallos_download/. /var/www/html/ && \
    rm -rf /tmp/wallos_download

# Configure PHP-FPM
RUN sed -i "s|;daemonize = yes|daemonize = no|g" /etc/php83/php-fpm.conf && \
    sed -i "s|user = nobody|user = nginx|g" /etc/php83/php-fpm.d/www.conf && \
    sed -i "s|group = nobody|group = nginx|g" /etc/php83/php-fpm.d/www.conf && \
    sed -i "s|listen = 127.0.0.1:9000|listen = /run/php/php-fpm.sock|g" /etc/php83/php-fpm.d/www.conf && \
    sed -i "s|;listen.owner = nobody|listen.owner = nginx|g" /etc/php83/php-fpm.d/www.conf && \
    sed -i "s|;listen.group = nobody|listen.group = nginx|g" /etc/php83/php-fpm.d/www.conf && \
    sed -i "s|;listen.mode = 0660|listen.mode = 0666|g" /etc/php83/php-fpm.d/www.conf

# Configure PHP upload settings
RUN echo "upload_max_filesize = 50M" >> /etc/php83/php.ini && \
    echo "post_max_size = 50M" >> /etc/php83/php.ini && \
    echo "max_execution_time = 300" >> /etc/php83/php.ini && \
    echo "memory_limit = 256M" >> /etc/php83/php.ini && \
    echo "file_uploads = On" >> /etc/php83/php.ini && \
    echo "upload_tmp_dir = /var/www/html/.tmp" >> /etc/php83/php.ini && \
    echo "allow_url_fopen = On" >> /etc/php83/php.ini && \
    echo "allow_url_include = Off" >> /etc/php83/php.ini

# Configure NGINX
COPY nginx.conf /etc/nginx/nginx.conf

# Copy run script to s6 service directory
COPY run.sh /etc/services.d/wallos/run

# Create necessary directories (DB will be created at runtime in /data)
RUN mkdir -p /var/www/html/db && \
    mkdir -p /var/www/html/images/uploads && \
    chmod -R 755 /var/www/html

# Fix line endings and permissions for s6 service
RUN sed -i 's/\r$//' /etc/services.d/wallos/run && \
    chmod a+x /etc/services.d/wallos/run
