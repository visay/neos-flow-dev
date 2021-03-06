# Pull base image
FROM ubuntu:16.04

MAINTAINER Visay Keo  <keo@visay.info>

# Set the locales
RUN locale-gen en_US.UTF-8 en_GB.UTF-8 de_DE.UTF-8 es_ES.UTF-8 fr_FR.UTF-8 it_IT.UTF-8 km_KH sv_SE.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV DEBIAN_FRONTEND noninteractive

# Upgrade the base system
RUN apt-get update && apt-get upgrade -y -q --no-install-recommends

# Install packages as per recommendation (https://docs.docker.com/articles/dockerfile_best-practices/)
# And clean up APT
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    ghostscript \
    git \
    imagemagick \
    sendmail \
    sqlite3 \
    wget \
    php7.0-cli \
    php7.0-curl \
    php7.0-fpm \
    php7.0-gd \
    php7.0-ldap \
    php7.0-mbstring \
    php7.0-mysql \
    php7.0-sqlite3 \
    php7.0-xml \
    php7.0-zip \
    php-imagick \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

ENV WWW_USER neos
ENV WWW_USER_ID 1000
ENV FLOW_CONTEXT Development

# Create webserver user and group
RUN adduser --system --shell /bin/bash --no-create-home --uid ${WWW_USER_ID} --group --disabled-password --disabled-login ${WWW_USER}

# Copy configuration files for php
COPY www.conf     /etc/php/7.0/fpm/pool.d/
COPY php-fpm.conf /etc/php/7.0/fpm/
COPY php.ini      /etc/php/7.0/fpm/
COPY php-cli.ini  /etc/php/7.0/cli/php.ini

RUN sed -i -e "s~###DEFAULT_WWW_USER###~${WWW_USER}~g" /etc/php/7.0/fpm/pool.d/www.conf

# Set entrypoint to fix volume mount permission
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

WORKDIR /var/www

# Expose port and by default start php-fpm
EXPOSE 9000
CMD ["php-fpm7.0"]
