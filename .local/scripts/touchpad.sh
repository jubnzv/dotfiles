#!/bin/sh

# Old synaptics script:
#
# if synclient -l | grep "TouchpadOff .*=.*0" ; then
#     synclient TouchpadOff=1 ;
#     notify-send " touchpad status" "disabled"
# else
#     synclient TouchpadOff=0 ;
#     notify-send " touchpad status" "enabled"
# fi

# libinput
#
 if xinput list-props 11 | grep "Device Enabled (138).*1" ; then
	 xinput set-prop 11 138 0 ;
	 notify-send " touchpad status" "disabled"
 else
	 xinput set-prop 11 138 1 ;
	 notify-send " touchpad status" "enabled"
fi
