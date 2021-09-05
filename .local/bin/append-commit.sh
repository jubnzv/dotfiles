#!/usr/bin/env bash
set -eou pipefail
if [ "$#" -ne 1 ]; then
    echo "Usage: $(basename $0) <hours>"
    exit 1
fi
secs=$(( $1 * 3600 ))
op='+'
if [[ "$secs" < 0 ]]; then
    op='-'
    secs=$(( $secs * (-1) ))
fi
d_unix="$(git log -1 --format=%ct)"
d_unix=$(( $d_unix $op $secs ))
git commit --amend --date="$d_unix" --no-edit
