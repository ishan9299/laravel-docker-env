FROM alpine:3.23.3

# it also includes packages for neovim
RUN apk update && \
apk add --no-cache \
ninja \
gcc \
build-base \
cmake \
coreutils \
curl \
gettext-tiny-dev \
linux-headers \
ca-certificates \
ripgrep \
xz \
git \
php85 \
php85-openssl \
php85-phar \
php85-iconv \
php85-mbstring \
php85-tokenizer \
php85-session \
php85-ctype \
php85-curl \
php85-xml \
php85-dom \
php85-xmlwriter \
php85-fileinfo \
php85-simplexml \
php85-pdo \
php85-pdo_mysql \
php85-pdo_pgsql \
php85-pdo_sqlite \
php85-bcmath \
php85-pcntl \
npm

# link php85 to php otherwise composer will not work.
RUN ln -s /usr/bin/php85 /usr/bin/php

# install composer
RUN EXPECTED_CHECKSUM="$(php -r 'copy("https://composer.github.io/installer.sig", "php://stdout");')" && \
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
ACTUAL_CHECKSUM="$(php -r "echo hash_file('sha384', 'composer-setup.php');")" && \
if [ "$EXPECTED_CHECKSUM" != "$ACTUAL_CHECKSUM" ]; then \
>&2 echo 'ERROR: Invalid installer checksum'; \
rm composer-setup.php; \
exit 1; \
fi && \
php composer-setup.php --quiet && \
RESULT=$? && \
rm composer-setup.php && \
mv composer.phar /usr/local/bin/composer

WORKDIR /var/www/

ENV COMPOSER_HOME=/usr/local/composer
ENV PATH="${PATH}:${COMPOSER_HOME}/vendor/bin"

EXPOSE 8000

RUN composer global require laravel/installer
