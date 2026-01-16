FROM php:8.2-cli

# System deps
RUN apt-get update && apt-get install -y \
    unzip \
    git \
    curl \
    libjpeg-dev \
    libpng-dev \
    libfreetype6-dev

# PHP extensions
RUN docker-php-ext-install \
    pdo \
    pdo_mysql \
    mysqli \
    exif

# Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /app
COPY . .

# 🔑 CREATE SQLITE FILE (THIS FIXES YOUR ERROR)
RUN mkdir -p database \
    && touch database/database.sqlite

# Install dependencies
RUN composer install --no-dev --optimize-autoloader

EXPOSE 10000

CMD ["php", "-S", "0.0.0.0:10000", "-t", "public"]
