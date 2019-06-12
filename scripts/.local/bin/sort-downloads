#!/bin/bash

for f in "/home/jubnzv/Downloads"/*; do
    if [ -f "$f" ]; then
        if [ "${f: -4}" == ".mp3" ]; then
            bn=$(basename "$f")
            echo "${f} -> ~/Audio/$bn"
            mv "${f}" "/home/jubnzv/Audio/$bn"
        fi
    fi
done
