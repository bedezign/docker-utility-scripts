# /usr/bin/env sh

echo '*** Installing PHP PDO / MySQL extensions'
docker-php-ext-install mysqli pdo pdo_mysql
