#/usr/bin/env sh

#
# Install the LUA extension, including correct setup of the system dependencies
#

echo '*** Installing PHP Lua functionality'
apt-get update
apt-get install -y lua5.3-dev
cd /usr/include
ln -s lua5.3/ lua
cd /usr/lib
ln -s /usr/lib/x86_64-linux-gnu/liblua5.3.so liblua.so
pecl install lua

export INI_DIR=`php -r 'ob_start(); phpinfo(INFO_GENERAL); array_map(function($value) { if (strpos($value, "additional .ini files =>")!==false) echo end(explode(" => ", $value)); }, explode(PHP_EOL, ob_get_clean()));'`
echo extension=lua.so > $INI_DIR/lua.ini
