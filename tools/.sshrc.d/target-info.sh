#!/bin/bash

if [[ -x "$(command -v tput)" ]]; then
    bold=$(tput bold)
    normal=$(tput sgr0)
else
    bold=""
    normal=""
fi

echo "${bold}Kernel:${normal} $(uname -r)"

if [[ -x "$(command -v uptime)" ]]; then
    echo "${bold}uptime:${normal} $(uptime -p)"
fi

if [[ -x "$(command -v w)" ]]; then
    echo "${bold}w:${normal}"
    w | tail -n+3
fi

if [[ -x "$(command -v tmux)" ]]; then
    sessions=$(tmux ls)
    if [[ $sessions == "" ]]; then
        echo "${bold}tmux sessions:${normal} no sessions"
    else
        echo "${bold}tmux sessions:${normal}"
        echo $sessions
    fi
else
    echo "${bold}tmux${normal}: not installed"
fi

if [[ -x "$(command -v netstat)" ]]; then
    netstat -tnl
else
    echo "${bold}netstat${normal}: not installed"
fi
