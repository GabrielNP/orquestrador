FROM php:7.0-apache-stretch

COPY apache/sis-default.conf /etc/apache2/sites-available/
#COPY apache/sis-default.conf /etc/apache2/sites-available/

RUN apt-get update && apt-get -y upgrade

RUN a2enmod rewrite
RUN apt-get install -y zlib1g-dev libpng-dev libmcrypt-dev libpng-dev git nano
RUN docker-php-ext-install gettext && docker-php-ext-install pdo_mysql && docker-php-ext-install gd && docker-php-ext-install zip
RUN docker-php-ext-install mysqli && docker-php-ext-enable mysqli
#RUN pecl install mcrypt-1.0.1
RUN docker-php-ext-install mcrypt

RUN a2dissite 000-default.conf
RUN a2ensite sis-default.conf

RUN service apache2 restart
