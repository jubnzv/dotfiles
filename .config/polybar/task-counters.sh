#!/usr/bin/env bash
#
# Polybar widget with counters of done/scheduled/due taskwarrior tasks for
# today.
#

get_counters() {
    tasks=""

    # Count tasks
    t_done_num="$(task rc.gc=off end:today +COMPLETED -DELETED count 2> /dev/null)"
    t_sched_num="$(task rc.gc=off sched.before:today+1d -COMPLETED -DELETED -DUETODAY +PENDING count 2> /dev/null)"
    t_due_num="$(task rc.gc=off due.before:today+1d -COMPLETED -DELETED +PENDING count 2> /dev/null)"

    # Format output string
    tasks="%{F#b8bb26}$t_done_num%{F-}"
    if [ "$t_sched_num" -ne "0" ]; then
        tasks=${tasks}" %{F#d79921}$t_sched_num%{F-}"
    fi
    if [ "$t_due_num" -ne "0" ]; then
        tasks=${tasks}" %{F#cc241d}$t_due_num%{F-}"
    fi

    echo $tasks
}

####
widget_string="$(get_counters)"
echo "$widget_string"
