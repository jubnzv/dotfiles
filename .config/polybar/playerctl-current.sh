#!/bin/bash
if  [ "$(playerctl status)" = "Playing" ]; then
    title=`exec playerctl metadata xesam:title`
    artist=`exec playerctl metadata xesam:artist`
    ( echo " $artist - $title " ) &

elif    [ "$(playerctl status)" = "Paused" ]; then
    title=`exec playerctl metadata xesam:title`
    artist=`exec playerctl metadata xesam:artist`
    ( echo " (PAUSED) $artist - $title " ) &
else
    echo " no music "
fi
