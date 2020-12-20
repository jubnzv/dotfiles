#!/usr/bin/env bash
set -eo pipefail

# Temp file that exists when notifications are disabled.
# See: ./toggle-notifications
TMP_FILE=/tmp/dunst-notifications-disabled

# Does notifications already disabled?
N_DISABLED=0
if [[ -f $TMP_FILE ]] ; then
    N_DISABLED=1
fi

enable_sound() {
    if [[ "$1" -eq 0 ]]; then
        pactl set-sink-mute 0 toggle
    fi
}

enable_notifications() {
    if [[ "$N_DISABLED" -eq 0 ]]; then
        rm $TMP_FILE
        notify-send "DUNST_COMMAND_RESUME"
    fi
}

disable_notifications() {
    if [[ "$N_DISABLED" -eq 0 ]]; then
        touch $TMP_FILE
        notify-send "DUNST_COMMAND_PAUSE"
    fi
}

# Is sound already muted?
muted=0
if [[ $(pacmd list-sinks | grep mute) == *yes* ]]; then
    muted=1
fi

# Do lock.
xset dpms force off &

disable_notifications
amixer -c 0 -q set Master mute
[[ `systemctl --all --type service | grep -q "arbtt"` ]] && systemctl --user stop arbtt.service
i3lock -n --color=282828 -f
enable_sound $muted
enable_notifications
[[ `systemctl --all --type service | grep -q "arbtt"` ]] && systemctl --user start arbtt.service
