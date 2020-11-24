#!/usr/bin/env bash

create_symlinks() {
    for f in "$1"/* "$1"/.[^.]*; do
        if echo "$f" | egrep '.*\/?((\.){1,2}|.git|assets|README.md|install.sh|tags)$' >/dev/null; then
            continue
        fi
        if [[ -f $f ]]; then
            ln -sfn `realpath "$f"` "$HOME/$f"
        fi
        if [[ -d $f ]]; then
            mkdir -p "$HOME"/"$f"
            create_symlinks "$f"
        fi
    done
}

create_symlinks .
