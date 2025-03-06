FROM php:8.4.4-fpm AS base
RUN apt update && apt upgrade -y --no-install-recommends
RUN apt install -y --no-install-recommends \
    curl \
    unzip \
    # libpq-dev \
    # libonig-dev \
    # libssl-dev \
    # libxml2-dev \
    # libcurl4-openssl-dev \
    # libicu-dev \
    # libzip-dev \
    && docker-php-ext-install -j$(nproc) \
    # pdo \
    pdo_mysql \
    # pdo_pgsql \
    # pgsql \
    opcache \
    # intl \
    # zip \
    # soap \
    bcmath
# RUN pecl install redis && docker-php-ext-enable redis
RUN pecl install xdebug-3.4.1;
COPY ./docker/app/xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini
RUN docker-php-ext-enable xdebug
RUN apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

FROM base AS deps
COPY . /usr/share/nginx/html
WORKDIR /usr/share/nginx/html
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer install --no-dev --optimize-autoloader --no-interaction --no-progress --prefer-dist

FROM deps AS dev
COPY --from=deps /usr/share/nginx/html /usr/share/nginx/html
RUN chown -R www-data:www-data /usr/share/nginx/html/storage
# ENTRYPOINT [ "/usr/share/nginx/html/docker/app/entrypoint.sh" ]
EXPOSE 9000
CMD ["php-fpm"]

FROM deps AS prod
COPY --from=deps /usr/share/nginx/html /usr/share/nginx/html
RUN chown -R www-data:www-data /usr/share/nginx/html/storage
RUN php artisan config:cache
RUN php artisan route:cache
EXPOSE 9000
CMD ["php-fpm"]
