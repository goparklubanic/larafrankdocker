# 1.4-builder-php8.3-bookworm
FROM dunglas/frankenphp:1.4.2-builder-php8.2-bookworm

WORKDIR /app

COPY . /app/

# Install system dependencies (if needed - often already in the base image)
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    libzip-dev \
    unzip \
    git \
    && docker-php-ext-configure gd --with-freetype --with-jpeg

# Install PHP extensions using install-php-extensions (most common ones)
RUN install-php-extensions \
    pdo_mysql \
    gd \
    intl \
    zip \
    opcache \
    bcmath \
    mbstring \
    curl \ 
    xml \ 
    tokenizer

# If you *absolutely* need oci8 (Oracle), keep it.  Otherwise, remove it if you are not using oracle.
# RUN install-php-extensions oci8 # Only if you need Oracle.

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install Composer dependencies
# RUN composer install --no-interaction --no-dev --optimize-autoloader

# Laravel specific permissions
RUN chown -R www-data:www-data ./app/storage ./app/bootstrap/cache \
    && chmod -R 755 ./app/storage ./app/bootstrap/cache

# Generate application key (if you don't have it in .env - use with caution)
# RUN php artisan key:generate --force  # Better to set APP_KEY in .env

# Development server (if needed)
ENV SERVER_NAME=":80"
EXPOSE 80

# FrankenPHP worker mode (if needed)
# ENV FRANKENPHP_CONFIG="worker /app/public/frankenphp-worker.php"

# FrankenPHP configuration (adjust as needed)
# COPY frankenphp.conf /app/frankenphp.conf # Copy config file if you have one
# CMD ["frankenphp", "run", "--config", "/app/frankenphp.conf"] # Example with config

# Or, if you're *not* using a separate FrankenPHP config:
# CMD ["frankenphp", "run"] # Default FrankenPHP startup