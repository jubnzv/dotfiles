#!/bin/bash
# Backup directory

if [ $# -ne 1 ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

directory=$1

if [[ ! -d "$directory" ]]; then
    exit 0
fi

mv "$directory" "${directory%%/}"_backup_$(date +'%H:%M:%S')
