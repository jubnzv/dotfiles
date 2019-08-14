#!/bin/bash
if [[ -x "$(command -v w)" ]]; then
    echo "Active users:"
    w
    echo ""
fi
if [[ -x "$(command -v uptime)" ]]; then
    echo "uptime:"
    uptime
    echo ""
fi
if [[ -x "$(command -v tmux)" ]]; then
    sessions=$(tmux ls)
    if [[ $sessions == "" ]]; then
        echo "Tmux sessions: no sessions"
    else
        echo "Tmux sessions:"
        echo $sessions
    fi
    echo ""
else
    echo "No tmux"
fi
