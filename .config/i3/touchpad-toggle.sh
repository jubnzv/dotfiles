#!/usr/bin/env bash
if xinput list-props "SynPS/2 Synaptics TouchPad" | grep "Device Enabled.*1" ; then
    xinput disable "SynPS/2 Synaptics TouchPad"
    notify-send "touchpad status" "disabled"
else
    xinput enable "SynPS/2 Synaptics TouchPad"
    notify-send "touchpad status" "enabled"
fi
