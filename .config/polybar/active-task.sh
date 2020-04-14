#!/usr/bin/env bash
#
# Polybar widget that shows latest active taskwarrior task.
# Output can be hidden by SIGUSR1.
#
trap "toggle_lock" USR1

HIDDEN=0

toggle_lock() {
    if [[ -z "$HIDDEN" ]]; then
        HIDDEN=1
    else
        HIDDEN=0
    fi
}

get_active_task() {
    if [[ -z "$HIDDEN" ]]; then
        res=∅
    else
        res=`task minimal rc.gc=off +ACTIVE 2>/dev/null | sed '4q;d' | awk '{ $1=$2="" };1'`
        if [ -z "$res" ]; then
            res='No active task';
        fi
    fi
    echo "$res"
}

####
while true; do
    widget_string="$(get_active_task)"
    echo "$widget_string"
    sleep 30 &
    wait
done

