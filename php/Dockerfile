FROM php:5.6-fpm

MAINTAINER zhenyangze <zhenyangze@gmail.com>

# Fix docker-php-ext-install script error
RUN sed -i 's/docker-php-\(ext-$ext.ini\)/\1/' /usr/local/bin/docker-php-ext-install

# Install other needed extensions
RUN apt-get update && apt-get install -y git make libpcre3-dev gcc libfreetype6 libjpeg62-turbo libmcrypt4 libpng12-0 sendmail --no-install-recommends 
RUN buildDeps=" \
        libfreetype6-dev \
        libjpeg-dev \
        libldap2-dev \
        libmcrypt-dev \
        libpng12-dev \
        zlib1g-dev \
    "; \
    set -x \
    && apt-get update && apt-get install -y $buildDeps --no-install-recommends \
    && docker-php-ext-configure gd --enable-gd-native-ttf --with-jpeg-dir=/usr/lib/x86_64-linux-gnu --with-png-dir=/usr/lib/x86_64-linux-gnu --with-freetype-dir=/usr/lib/x86_64-linux-gnu \
    && docker-php-ext-install gd \
    && docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu \
    && docker-php-ext-install ldap \
    && docker-php-ext-install mbstring \
    && docker-php-ext-install mcrypt \
    && docker-php-ext-install mysql \
    && docker-php-ext-install mysqli \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install zip \
    && apt-get purge -y --auto-remove $buildDeps \
    && cd /usr/src/php \
    && make clean

# Install PHP
RUN apt-get -y install php-apc php5-cli php5-dev libevent-dev

# Install Extra PHP Modules
RUN apt-get -y install  php5-mongo php5-sqlite php5-xsl php5-mcrypt

# Install Cached
RUN apt-get -y install memcached php5-memcached php5-memcache php5-redis

# Install Phalcon
#RUN apt-add-repository ppa:phalcon/stable -y
#RUN apt-get update
#RUN apt-get -y install php5-phalcon

# Install Composer for Laravel
RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer

# Setup timezone to Etc/UTC
RUN cat /usr/src/php/php.ini-production | sed 's/^;\(date.timezone.*\)/\1 \"Asia\/Shanghai\"/' > /usr/local/etc/php/php.ini

# Disable cgi.fix_pathinfo in php.ini
RUN sed -i 's/;\(cgi\.fix_pathinfo=\)1/\10/' /usr/local/etc/php/php.ini

RUN rm -rf /var/lib/apt/lists/* 

WORKDIR /tmp
RUN /usr/bin/git clone git://github.com/phalcon/cphalcon.git && \
    cd cphalcon/build/ && \
    ./install && \
    cd /tmp && \
    /bin/rm -rf /tmp/cphalcon/ 
RUN /bin/echo 'extension=phalcon.so' >/etc/php5/mods-available/phalcon.ini
RUN /bin/echo 'extension=phalcon.so' > /usr/local/etc/php/conf.d/phalcon.ini
RUN /usr/sbin/php5enmod phalcon

RUN composer global require --dev 'phalcon/devtools' && \
    ln -s ~/.composer/vendor/bin/phalcon.php /usr/bin/phalcon && \
        chmod ugo+x /usr/bin/phalcon

WORKDIR /var/www
