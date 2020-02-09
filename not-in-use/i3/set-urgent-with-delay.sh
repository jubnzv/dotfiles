#!/usr/bin/env bash
#
# Set focused window urgent after user-defined delay.
# Use-case: quick remainders.
#
set -euo pipefail

if [[ ! -x "$(command -v xdotool)" ]]; then
    echo "xdotool: command not found"
    exit 1
fi
if [[ ! -x "$(command -v wmctrl)" ]]; then
    echo "wmctrl: command not found"
    exit 1
fi
if [[ ! -x "$(command -v zenity)" ]]; then
    echo "zenity: command not found"
    exit 1
fi

window=`xdotool getwindowfocus getwindowname`

timeout=`zenity --scale --title="$0: Delay (min)" \
           --text="Set the delay time in minutes" \
           --min-value=1 --max-value=60 --value=5 \
           --step=1`

sleep $timeout*60

wmctrl -r $window -b add,demands_attention

# vim: set ft=sh:
