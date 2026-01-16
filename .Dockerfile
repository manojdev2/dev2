FROM php:8.2-cli

# Install mysqli + pdo_mysql
RUN docker-php-ext-install mysqli pdo pdo_mysql

WORKDIR /
COPY . .

EXPOSE 10000

CMD ["php", "-S", "0.0.0.0:10000", "-t", "public"]
