#!/usr/bin/env bash
sessions=$(tmux list-sessions -F '#S' | grep '^[0-9]\+$' | sort -n)
new=1
for old in $sessions
do
  tmux rename -t $old $new
  ((new++))
done
