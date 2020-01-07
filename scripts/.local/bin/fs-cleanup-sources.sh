#!/bin/bash
set -euo pipefail

if [ ! -d $HOME/Sources ]; then
    echo "$HOME/Sources is inaccessible"
    exit 127
fi

if [[ ! -x "$(command -v tmsu)" ]]; then
    echo "tmsu: command not found"
    exit 1
fi

pushd $HOME/Sources >/dev/null

# Remove `apt-get source` artefacts
rm -f *.dsc *.asc      \
      *.orig*.gz       \
      *.orig*.bz2      \
      *.orig*.xz       \
      *.debian.*gz     \
      *.debian.*bz2    \
      *.debian.*xz

# Find packages downloaded with `apt-get source` that has been tagged as
# `packages`. I don't want to keep them anymore because they could not be
# updated with `git pull`.
for d in `tmsu files packages`; do
    if [[ -d $d ]]; then
        if [[ ! -d $d/.git/ ]]; then
            rm -r $d
        fi
    fi
done

popd >/dev/null
