#!/bin/bash
# Perform additional configuration for ThinkPad x230 keyboard.

# General
xset b off
setxkbmap -layout "us,ru" -option "grp:alt_shift_toggle"
#setxkbmap -layout "us,ru" -option "grp:alts_toggle"

if xinput list | grep "ErgoDox" ; then
    exit
fi

setxkbmap -option ctrl:nocaps
/usr/bin/xmodmap -e "keysym Print = Super_L"

# x230 + classic keyboard
/usr/bin/xmodmap -e "keycode 110=Delete" # Delete
/usr/bin/xmodmap -e "keycode 118="       # PgDn
/usr/bin/xmodmap -e "keycode 119="       # PgUp
