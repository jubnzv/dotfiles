#!/usr/bin/env bash
IFS="/" read -r deadline_num scheduled_num is_active <<< $(nvim --headless -c 'lua print(tasks_status() .. "\n")' -c 'qa!' 2>&1)
is_active="${is_active:0:1}"
color="#585858"
if [[ $is_active == [1-9] ]]; then
    color="#689d6a"
fi
deadline=""
if [[ $deadline_num != '0' ]]; then
    deadline="%{F#b16286}$deadline_num%{F-}"
fi
scheduled=""
if [[ $scheduled_num != '0' ]]; then
    scheduled="%{F#585858}$scheduled_num%{F-}"
fi
sep=""
if [ -n "$deadline" ] && [ -n "$scheduled" ]; then
    sep="%{F#585858}/%{F-}"
fi
echo "%{u$color}%{+u}%{F$color}%{F-} $deadline$sep$scheduled%{u-}"
