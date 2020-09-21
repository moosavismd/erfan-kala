FROM php:7.2-apacheFROM php:7.2-apache
RUN a2enmod rewrite
RUN set -xe \
    && apt-get update \
    && apt-get install -y libpng-dev libjpeg-dev libmcrypt-dev \
    && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
    && docker-php-ext-install gd mbstring mysqli zip \
    && pecl install mcrypt-1.0.1 \
    && docker-php-ext-enable mcrypt
COPY site-data/ /var/www/html/
WORKDIR /var/www/html/
RUN set -xe \
    && chown -R www-data:www-data /var/www/
