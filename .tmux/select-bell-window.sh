#!/usr/bin/env bash
w=$(tmux list-windows -F '#{window_index} #{window_bell_flag}' | awk '$2==1{print $1; exit}')
[ -n "$w" ] && tmux select-window -t "$w"
