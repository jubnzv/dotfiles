#!/usr/bin/env bash
#
# Make taskwarrior tasks for "work" project waiting to the start of the next work week.
#
period='soww'
if [[ ! -z "$1" ]]; then
    period="$1"
fi

if [[ ! -x "$(command -v task)" ]]; then
    echo "task: command not found"
    exit 1
fi

ids=$(task rc.gc:off pro:work ilist 2>/dev/null | egrep '^[0-9]+$')
if [[ $ids == "" ]]; then
    echo "No work tasks found"
    exit 0
fi

num=$(($(echo $ids | tr -cd ' ' | wc -c)+1))
read -p "Re-schedule $num work tasks to next week (Y/n)? " -r
if [[ $REPLY =~ ^[Nn]$ ]]; then
    echo "Cancel"
    exit 0
fi

for i in $ids; do
    task $i m wait:"$period" 2>/dev/null
done
