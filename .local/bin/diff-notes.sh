#!/usr/bin/env bash
#
# Script that commit daily changes in notes database and sends diff on local mail.
#
NOTES_PATH='/home/jubnzv/Org/Notes/'

if [ ! -d $NOTES_PATH ]; then
    echo "$NOTES_PATH is inaccessible"
    exit 127
fi

cd "$NOTES_PATH"
git add -A
git commit -m "Update $(date +%Y-%m-%d)"

address="${USER}"@"$(hostname)"

# diff_text=$(git diff @^)
# echo -e "Content-Type: text/plain; charset=\"utf-8\";\nSubject: Notes diff $(date +%Y-%m-%d)\n\n${diff_text}" | /usr/sbin/sendmail "$address"

diff_html=$(git diff @^ | ~/.local/bin/diff2html.py)
echo -e "Content-Type: text/html; charset=\"utf-8\";\nSubject: Notes diff $(date +%Y-%m-%d)\n\n${diff_html}" | /usr/sbin/sendmail "$address"

