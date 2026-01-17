FROM php:8.2-cli

RUN apt-get update && apt-get install -y \
    unzip \
    git \
    curl \
    libjpeg-dev \
    libpng-dev \
    libfreetype6-dev

RUN docker-php-ext-install \
    pdo \
    pdo_mysql \
    mysqli \
    exif

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /app
COPY . .

# ✅ SAFE: no failure if folders don't exist
RUN mkdir -p database \
    && touch database/database.sqlite \
    && if [ -d storage ]; then chmod -R 777 storage; fi \
    && if [ -d bootstrap/cache ]; then chmod -R 777 bootstrap/cache; fi

RUN composer install --no-dev --optimize-autoloader

EXPOSE 10000

CMD ["sh", "-c", "php -S 0.0.0.0:${PORT:-10000} -t public"]
