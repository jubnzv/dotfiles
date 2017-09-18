#!/bin/bash
#setxkbmap -layout "us,ru" -option "grp:alt_shift_toggle"
#setxkbmap -layout "us,ru" -option "grp:alts_toggle"
setxkbmap -option ctrl:nocaps
xset b off
/usr/bin/xmodmap -e "keysym Print = Super_L"
#/usr/bin/xmodmap -e "keysym Menu = Super_L"
#/usr/bin/xmodmap -e "keysym XF86Search = Caps_Lock"
#/usr/bin/xmodmap -e "keysym Menu = Escape"
