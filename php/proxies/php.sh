#!/usr/bin/env bash

# Script for triggering php in the relevant container so that we can run tests without having to wait for the container being booted and so on
# Stolen from: https://binary-data.github.io/2016/06/15/running-integration-tests-phpstorm-phpunit-docker/

/usr/local/bin/docker-compose exec -T php /usr/local/bin/php -dxdebug.remote_enable=1 -dxdebug.remote_autostart=1 "$@"

