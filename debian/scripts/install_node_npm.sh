#!/usr/bin/env sh

echo '*** Installing node.js and npm'

apt-get update
apt-get install -y curl gnupg2
curl -sL https://deb.nodesource.com/setup_9.x | bash -
apt-get update

apt-get install -y nodejs build-essential

# mozjpeg
apt-get install -y automake nasm
# pngquant
apt-get install -y libpng-dev


