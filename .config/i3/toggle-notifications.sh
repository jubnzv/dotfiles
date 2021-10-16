#!/bin/bash
set -euo pipefail

TMP_FILE=/tmp/dunst-notifications-disabled

if [ -f $TMP_FILE ] ; then
    dunstctl set-paused false
    notify-send "Notifications: on" -t 600 -i player-volume
    rm -f $TMP_FILE
else
    touch $TMP_FILE
    notify-send "Notifications: off" -t 600 -i player-volume-muted
    sleep 0.7
    dunstctl set-paused true
fi
