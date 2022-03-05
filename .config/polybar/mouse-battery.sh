#!/usr/bin/env bash
p="$(upower -i /org/freedesktop/UPower/devices/mouse_hidpp_battery_0 | grep percentage | awk '{print $2}' | cut -d '%' -f 1)"
if [[ "$(( $p ))" -ne 0 && "$(( $p ))" -lt 33 ]]; then
    echo $p
fi
