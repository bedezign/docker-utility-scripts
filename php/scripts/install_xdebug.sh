#/usr/bin/env sh

# https://enrise.com/2018/02/debugging-php-with-xdebug/
# via LaunchDaemon: https://gist.github.com/ralphschindler/535dc5916ccbd06f53c1b0ee5a868c93

echo '*** Installing XDebug and "phpdbg" alias'

# Note that this script does not enable the xdebug extension by default for the CLI
# If you want to use it you can use phpdbg instead.
# For FPM, the extension is added

pecl channel-update pecl.php.net
pecl install xdebug

cat <<'EOD' > /usr/local/bin/phpdbg
#/usr/bin/env sh
# Use "$@" to make sure arguments are passed on as individual and quoted / https://stackoverflow.com/a/17094284/50158
/usr/local/bin/php -dxdebug.remote_enable=1 -dxdebug.remote_autostart=1 "$@"
EOD

chmod +x /usr/local/bin/phpdbg

echo 'php_admin_flag[xdebug.remote_enable] = On;' >> /usr/local/etc/php-fpm.d/www.conf