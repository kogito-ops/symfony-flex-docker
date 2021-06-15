# vim:set ft=dockerfile:

FROM docker.io/library/composer:2.1.3
FROM docker.io/library/php:7.4.20-fpm-alpine3.13
LABEL maintainer="Kogito UG <hello@kogito.network>"

###> PHP extensions ###
RUN apk add --no-cache --virtual .persistent-deps \
    freetype \
    git \
    icu-libs \
    libjpeg \
    libpng \
    libpq \
    libzip \
    zlib

ENV APCU_VERSION 5.1.19
RUN set -xe \
    && apk add --no-cache --virtual .build-deps \
    $PHPIZE_DEPS \
    freetype-dev \
    icu-dev \
    jpeg-dev \
    libpng-dev \
    libzip-dev \
    postgresql-dev \
    zlib-dev \
    && docker-php-ext-configure gd \
    && docker-php-ext-install \
    gd \
    intl \
    pdo_mysql \
    pdo_pgsql \
    zip \
    && pecl install \
    apcu-${APCU_VERSION} \
    && docker-php-ext-enable --ini-name 20-apcu.ini apcu \
    && docker-php-ext-enable --ini-name 05-opcache.ini opcache \
    && docker-php-ext-enable --ini-name 30-pdo_mysql.ini pdo_mysql \
    && docker-php-ext-enable --ini-name 30-pdo_pgsql.ini pdo_pgsql \
    && apk del .build-deps

RUN set -xe \
    && apk add --no-cache --virtual .phpize-deps $PHPIZE_DEPS \
    && pecl install -o -f redis  \
    && echo "extension=redis.so" > /usr/local/etc/php/conf.d/redis.ini \
    && rm -rf /usr/share/php \
    && rm -rf /tmp/* \
    && apk del .phpize-deps

COPY docker/php-fpm/php.ini /usr/local/etc/php/php.ini
COPY --from=composer:2.1.3 /usr/bin/composer /usr/bin/composer
COPY docker/php-fpm/docker-entrypoint.sh /usr/local/bin/docker-app-entrypoint
RUN chmod +x /usr/local/bin/docker-app-entrypoint

WORKDIR /srv/app
ENTRYPOINT ["docker-app-entrypoint"]
CMD ["php-fpm"]

ENV SYMFONY_SRC_URL https://github.com/symfony/cli/releases/download/v4.25.2/symfony_linux_amd64.gz
RUN curl -fSL "${SYMFONY_SRC_URL}" -o "/tmp/symfony_linux_amd64.gz" \
    && gunzip "/tmp/symfony_linux_amd64.gz" \
    && mv -f "/tmp/symfony_linux_amd64" /usr/local/bin/symfony \
    && chmod +x /usr/local/bin/symfony \
    && rm -f "/tmp/symfony_linux_amd64"

# https://getcomposer.org/doc/03-cli.md#composer-allow-superuser
ENV COMPOSER_ALLOW_SUPERUSER 1

# Allow to use development versions of Symfony
ARG STABILITY=stable
ENV STABILITY ${STABILITY}

# Allow to use environments of Symfony
ARG APP_ENV=prod
ENV APP_ENV ${APP_ENV}

# Allow to select skeleton version
ARG VERSION="^5.2"
ENV VERSION ${VERSION}

# Download the Symfony skeleton and leverage Docker cache layers
RUN composer create-project "symfony/skeleton:${VERSION}" . --stability=$STABILITY --prefer-dist --no-dev --no-progress --no-scripts --no-plugins --no-interaction

RUN mkdir -p var/cache var/logs var/sessions \
    && composer install --prefer-dist --no-dev --no-scripts --no-progress --classmap-authoritative --no-interaction \
    && composer clear-cache \
    && chown -R www-data var
