FROM php:8.3-fpm

ARG app_mode

COPY "./.deploy/fpm/conf.d/$app_mode/php.ini" "$PHP_INI_DIR/php.ini"

RUN apt-get update && apt-get install --no-install-recommends -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    zip \
    unzip \
    sudo \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install \
    pdo \
    pdo_mysql \
    mbstring \
    exif \
    pcntl \
    bcmath \
    gd \
    zip \
    opcache \
    sockets \
    intl \
    > /dev/null

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www
