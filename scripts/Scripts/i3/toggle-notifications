#!/bin/bash
set -euo pipefail

TMP_FILE=/tmp/dunst-notifications-disabled

if [ -f $TMP_FILE ] ; then
    notify-send "DUNST_COMMAND_RESUME"
    notify-send "Notifications: on" -t 600 -i player-volume
    rm -f $TMP_FILE
else
    touch $TMP_FILE
    notify-send "Notifications: off" -t 600 -i player-volume-muted
    sleep 0.7
    notify-send "DUNST_COMMAND_PAUSE"
fi
