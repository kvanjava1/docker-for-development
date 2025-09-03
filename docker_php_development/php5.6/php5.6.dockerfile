FROM php:5.6-fpm

# Arguments defined in docker-compose.yml
ARG user
ARG uid

# Update the sources list to use the archived repositories and remove security updates
RUN sed -i 's/deb.debian.org/archive.debian.org/g' /etc/apt/sources.list && \
    sed -i 's/security.debian.org\/debian-security/archive.debian.org\/debian-security/g' /etc/apt/sources.list && \
    sed -i '/stretch-updates/d' /etc/apt/sources.list && \
    echo 'Acquire::Check-Valid-Until "false";' > /etc/apt/apt.conf.d/99no-check-valid-until

# Install system dependencies with --allow-unauthenticated flag
RUN apt-get update && apt-get install -y --allow-unauthenticated \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    libssl-dev \
    libmemcached-dev \
    libz-dev \
    libpq-dev \
    libjpeg-dev \
    libpng-dev \
    libfreetype6-dev \
    libmcrypt-dev \
    zlib1g-dev \
    libicu-dev \
    libbz2-dev \
    libpng-dev \
    libjpeg-dev \
    libmcrypt-dev \
    libreadline-dev \
    libfreetype6-dev \
    g++ \
    libwebp-dev \
    libjpeg62-turbo-dev \
    pkg-config \
    libvpx-dev


RUN pecl install \
    mongodb-1.7.5 \
    redis-4.3.0

RUN docker-php-ext-enable \
    mongodb \
    redis

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Configure and install GD extension with WebP support
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --with-vpx-dir=/usr/include/

# Install PDO extensions
RUN docker-php-ext-install gd pdo pdo_mysql pdo_pgsql

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Create a non-root user
RUN useradd -ms /bin/bash laravel

# Set working directory
WORKDIR /var/www/php/php5.6

# Switch to non-root user
USER laravel

# Command to run PHP-FPM
CMD ["php-fpm"]