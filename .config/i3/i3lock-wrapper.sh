#!/usr/bin/env bash
#set -eo pipefail

# Temp file that exists when notifications are disabled.
# See: ./toggle-notifications
TMP_FILE=/tmp/"$(whoami)-dunst-notifications-disabled"

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
        dunstctl set-paused false
    fi
}

disable_notifications() {
    if [[ "$N_DISABLED" -eq 0 ]]; then
        touch $TMP_FILE
        dunstctl set-paused true
    fi
}

# Is sound already muted?
muted=0
if [[ $(pacmd list-sinks | grep mute) == *yes* ]]; then
    muted=1
fi

xset dpms force off &
disable_notifications
pactl set-sink-mute 0 true
i3lock -n --color=282828 -f -e

# After unlock
~/.config/i3/setup-keys.sh
enable_sound $muted
enable_notifications
