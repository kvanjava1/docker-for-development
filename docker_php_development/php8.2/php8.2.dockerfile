FROM php:8.2-fpm

# Install system dependencies for WEBP, MySQL, Redis, MongoDB, and ZIP
RUN apt-get update && apt-get install -y \
    zip unzip git curl libpng-dev libjpeg-dev libfreetype6-dev libonig-dev \
    libwebp-dev \
    libmcrypt-dev \
    libmemcached-dev \
    libz-dev \
    libssl-dev \
    libsasl2-dev \
    libcurl4-openssl-dev \
    libicu-dev \
    libxml2-dev \
    libzip-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp \
    && docker-php-ext-install gd mbstring pdo pdo_mysql exif pcntl bcmath zip \
    && pecl install redis \
    && pecl install mongodb \
    && docker-php-ext-enable redis mongodb

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Create a non-root user
RUN useradd -ms /bin/bash laravel

# Set working directory
WORKDIR /var/www/php/php8.2

# Switch to non-root user
USER laravel

# Command to run PHP-FPM
CMD ["php-fpm"]