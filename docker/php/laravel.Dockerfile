FROM php:8.4-fpm

WORKDIR /var/www/html/laravel

# ------------------------
# System dependencies
# ------------------------
RUN apt-get update && apt-get install -y \
    unzip git curl libzip-dev zip default-mysql-client gnupg \
    && docker-php-ext-install pdo pdo_mysql zip

# ------------------------
# Redis
# ------------------------
RUN pecl install redis && docker-php-ext-enable redis

# ------------------------
# Xdebug
# ------------------------
RUN pecl install xdebug \
    && docker-php-ext-enable xdebug \
    && echo "xdebug.mode=off" > /usr/local/etc/php/conf.d/xdebug.ini

# ------------------------
# Composer
# ------------------------
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

COPY ./backend /var/www/html/laravel

# ------------------------
# Env template
# ------------------------
COPY ./docker/php/.env.docker /usr/local/etc/.env.docker

# ------------------------
# Entry point
# ------------------------
COPY ./docker/php/php-entrypoint.sh /usr/local/bin/php-entrypoint.sh

RUN chmod +x /usr/local/bin/php-entrypoint.sh \
    && sed -i 's/\r$//' /usr/local/bin/php-entrypoint.sh

ENTRYPOINT ["php-entrypoint.sh"]

EXPOSE 9000

CMD ["php-fpm", "-F"]