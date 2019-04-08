#!/usr/bin/env bash

if [ $# -ne 1 ]; then
    echo "Usage: $0 <host>"
    exit 1
fi

rsync -av ~/.terminfo ${1}:
