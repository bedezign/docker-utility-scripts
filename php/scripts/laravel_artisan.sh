#/usr/bin/env sh

# Use "$@"  instead of $* to make sure arguments are passed on as individual and quoted / https://stackoverflow.com/a/17094284/50158

cat <<'EOD' > /usr/local/bin/artisandbg
#/usr/bin/env sh
if [ ! -z "$PROJECT_HOME" ]; then
   cd "$PROJECT_HOME"
fi
phpdbg artisan "$@"
EOD

cat << 'EOD' >/usr/local/bin/artisan
#/usr/bin/env sh
if [ ! -z "$PROJECT_HOME" ]; then
   cd "$PROJECT_HOME"
fi
php artisan "$@"
EOD

chmod +x /usr/local/bin/artisandbg /usr/local/bin/artisan
