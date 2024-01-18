# syntax=docker/dockerfile:1
FROM php:8-apache

LABEL AUTHOR="Léo Carvalho" \
    io.churchcrm.version="3.0.0" \
    io.churchcrm.release-date="2021-10-01" \
    io.churchcrm.version.is-production="true"

RUN apt update && \
    apt install -y \
        libxml2-dev \
        gettext \
        libpng-dev \
        libzip-dev \
        libfreetype6-dev \
        libmcrypt-dev \
        libjpeg-dev \
        git \
        unzip \
        jq && \
    apt dist-upgrade -y && \
    apt clean && \
    apt autoremove && \
    rm -rf /var/lib/apt/lists/* && \
    pecl install --force redis \
    && rm -rf /tmp/pear \
    && docker-php-ext-enable redis

RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install -j$(nproc) xml exif pdo_mysql gettext iconv mysqli zip intl bcmath fileinfo gd

RUN a2enmod rewrite && a2enmod headers && a2enmod expires

# Configure PHP
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini" && \
    sed -i 's/^upload_max_filesize.*$/upload_max_filesize = 24M/g' $PHP_INI_DIR/php.ini && \
    sed -i 's/^register_globals.*$/register_globals = 0/g' $PHP_INI_DIR/php.ini && \
    sed -i 's/^post_max_size.*$/post_max_size = 8M/g' $PHP_INI_DIR/php.ini && \
    sed -i 's/^memory_limit.*$/memory_limit = 32M/g' $PHP_INI_DIR/php.ini && \
    sed -i 's/^max_execution_time.*$/max_execution_time = 120/g' $PHP_INI_DIR/php.ini && \
    mkdir -p /etc/run_always

COPY 60-churchcrm /etc/run_always
COPY src/index.php /tmp

RUN chmod +x /etc/run_always/60-churchcrm

EXPOSE 80

ENTRYPOINT [ "/etc/run_always/60-churchcrm" ]
