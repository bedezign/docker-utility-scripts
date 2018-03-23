# /usr/bin/env sh

echo '*** Installing MongoDB extension'

# MongoC
apt-get install pkg-config libssl-dev libsasl2-dev
# BSON
apt-get install git gcc automake autoconf libtool

pecl install mongodb

export INI_DIR=`php -r 'ob_start(); phpinfo(INFO_GENERAL); array_map(function($value) { if (strpos($value, "additional .ini files =>")!==false) echo end(explode(" => ", $value)); }, explode(PHP_EOL, ob_get_clean()));'`
echo extension=mongodb.so > $INI_DIR/mongodb.ini
