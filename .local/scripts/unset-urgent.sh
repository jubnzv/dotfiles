#!/bin/bash
# Removes urgent status from all workpaces
for win in $(wmctrl -l | awk -F' ' '{print $1}'); do
    wmctrl -i -r $win -b remove,demands_attention;
done
