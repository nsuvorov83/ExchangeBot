FROM php:7.0-apache

#docker build . -t nsuvorov/exchange-bot:apache-php-xdebug-mysql
RUN pecl install xdebug-2.5.0 \
    && docker-php-ext-install pdo pdo_mysql \
    && docker-php-ext-enable xdebug \
    && echo "xdebug.remote_enable=1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_autostart=1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_connect_back=0" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_host=docker_host" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.idekey=docker" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && docker-php-ext-install mysqli \
    && apt-get update \
    && apt-get -y install git \
    && apt-get -y install wget \
    && apt-get -y install mc \
    && ln -s /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled/rewrite.load

RUN rm /var/log/apache2/access.log \
    && rm /var/log/apache2/error.log \
    && rm /var/log/apache2/other_vhosts_access.log

EXPOSE 80