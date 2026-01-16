FROM php:8.2-cli

# System dependencies
RUN apt-get update && apt-get install -y \
    unzip \
    git \
    curl \
    libjpeg-dev \
    libpng-dev \
    libfreetype6-dev

# PHP extensions (IMPORTANT: exif)
RUN docker-php-ext-install \
    mysqli \
    pdo \
    pdo_mysql \
    exif

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /app
COPY . .

# Install PHP dependencies
RUN composer install --no-dev --optimize-autoloader

EXPOSE 10000

CMD ["php", "-S", "0.0.0.0:10000", "-t", "public"]
