ARG BUILD_FROM
FROM alpine:3.19 AS builder

RUN apk add --no-cache git jq curl && \
    git clone --depth 1 https://github.com/ellite/Wallos.git /tmp/wallos

FROM ${BUILD_FROM}

RUN apk add --no-cache \
    nginx php83 php83-fpm php83-ctype php83-curl php83-dom \
    php83-fileinfo php83-gd php83-iconv php83-intl php83-mbstring \
    php83-opcache php83-openssl php83-pdo php83-pdo_sqlite php83-session \
    php83-simplexml php83-sqlite3 php83-tokenizer php83-xml \
    php83-xmlreader php83-xmlwriter php83-zip sqlite

RUN ln -sf /usr/bin/php83 /usr/bin/php && \
    ln -sf /usr/sbin/php-fpm83 /usr/sbin/php-fpm

COPY --from=builder /tmp/wallos /var/www/html

COPY nginx.conf /etc/nginx/nginx.conf
COPY nginx.default.conf /etc/nginx/http.d/default.conf
RUN rm -f /var/www/html/nginx.conf /var/www/html/nginx.default.conf

RUN mkdir -p /var/www/html/db /var/www/html/images/uploads/logos/avatars /var/www/html/.tmp /run/nginx /run/php && \
    chown -R root:root /var/www/html && \
    chmod -R 755 /var/www/html

RUN mkdir -p /etc/services.d/wallos
COPY run.sh /etc/services.d/wallos/run

RUN sed -i 's/\r$//' /etc/services.d/wallos/run && \
    chmod a+x /etc/services.d/wallos/run