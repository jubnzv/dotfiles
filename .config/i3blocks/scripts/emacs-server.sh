#!/bin/bash
# Emacs server status indicator

serverdir="${TMPDIR:-/tmp}/emacs${UID}"
for file in ${serverdir}/*; do
  if [[ -S ${file} ]]; then
    servers+=("${file##*/}")
  fi
done

# echo "${servers[@]}"

if [[ $servers ]]; then
    color="#859900"
    status="<b>λ</b>"
else
    color="#dc322f"
    status="<b>λ</b>"
fi

echo $status
echo $status
echo $color
