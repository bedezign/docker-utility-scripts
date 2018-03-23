#/usr/bin/env sh

echo '*** Resizing pseudo terminal window'
# For some annoying reason iTerm and RoyalTSX (which uses iTerm) always start the pseudo terminal used for docker exec commands as a 80x25 screen.
# This script should be ran on the localhost before triggering docker 
# https://apple.stackexchange.com/questions/33736/can-a-terminal-window-be-resized-with-a-terminal-command
# Restore
printf '\e[1t'
# Zoom (this resizes the pseudo terminal window to full tab size)
printf '\e[9;1t'
