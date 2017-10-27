#!/bin/sh
if [ `xrandr | grep -c ' connected '` -eq 2 ]; then # dual-monitor
    if [ `xrandr | grep VGA1 | grep -c ' connected '` -eq 1 ]; then
        xrandr --output LVDS1 --auto --primary --output VGA1 --right-of LVDS1 --auto
    fi
elif [ `xrandr | grep -c ' connected '` -eq 3 ]; then # three monitors using docking station
    xrandr --output VGA1 --left-of LVDS1 --auto
    xrandr --output HDMI3 --right-of LVDS1 --auto
else
    xrandr --output LVDS1 --auto --primary --output VGA1 --off --output HDMI3 --off
fi
