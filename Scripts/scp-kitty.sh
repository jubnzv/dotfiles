#!/usr/bin/env bash
set -e

if [ $# -lt 1 ] || [ $# -gt 2 ]; then
    echo "Usage: $0 <ssh user@host> [passwd]"
    exit 1
fi

if [ $# -eq 2 ]; then
    sshpass -p $2 scp -r ~/.terminfo ${1}:./
    sshpass -p $2 ssh ${1} 'tic ~/.terminfo/kitty.terminfo'
else
    scp -r ~/.terminfo ${1}:./
    ssh ${1} 'tic ~/.terminfo/kitty.terminfo'
fi
