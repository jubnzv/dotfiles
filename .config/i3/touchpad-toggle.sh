#!/usr/bin/env bash
if xinput list-props "SynPS/2 Synaptics TouchPad" | grep "Device Enabled (148).*1" ; then
    xinput disable "SynPS/2 Synaptics TouchPad"
    notify-send "touchpad status" "disabled" -i $(realpath ~/.icon/touchpad-disabled.png)
else
    xinput enable "SynPS/2 Synaptics TouchPad"
    notify-send "touchpad status" "enabled" -i $(realpath ~/.icon/touchpad.png)
fi
