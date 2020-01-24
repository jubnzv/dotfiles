#!/usr/bin/env bash
set -eo pipefail

# Temp file which exists when notifications are disabled.
# See: ./toggle-notifications
TMP_FILE=/tmp/dunst-notifications-disabled

enable_sound() {
    if [[ "$1" -eq 0 ]]; then
        pactl set-sink-mute 0 toggle
    fi
}

enable_notifications() {
    if [[ "$1" -eq 0 ]]; then
        notify-send "DUNST_COMMAND_RESUME"
    fi
}

disable_notifications() {
    if [[ "$1" -eq 0 ]]; then
        notify-send "DUNST_COMMAND_PAUSE"
    fi
}

# Is sound already muted?
muted=0
if [[ $(pacmd list-sinks | grep mute) == *yes* ]]; then
    muted=1
fi

# Are notifications already disabled?
notifications_disabled=0
if [[ -f $TMP_FILE ]] ; then
    notifications_disabled=1
fi

# Do lock.
xset dpms force off &

disable_notifications $notifications_disabled
amixer -c 0 -q set Master mute
systemctl --user stop arbtt.service
i3lock -n --color=282828 -f
enable_sound $muted
enable_notifications $notifications_disabled
systemctl --user start arbtt.service
