#!/usr/bin/env sh

#
# Helper Script that creates an aliased ip on the lo0 interface.
# Used when "docker.for.mac.localhost" didn't exist yet to configure Xdebug.
# No longer required but keeping it out of nostalgia
#

IP=172.99.0.100
NAME=com.bedezign.docker_alias_ip

LO=$(ifconfig lo0 | awk '{print $2}' | grep ${IP})

#if [ "$LO" != "$IP" ]; then
#     sudo /sbin/ifconfig lo0 $IP alias
    sudo tee "/Library/LaunchDaemons/${NAME}.plist" >/dev/null <<EOD
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>${NAME}</string>
    <key>ProgramArguments</key>
    <array>
        <string>ifconfig</string>
        <string>lo0</string>
        <string>alias</string>
        <string>${IP}</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
</dict>
</plist>
EOD

#fi