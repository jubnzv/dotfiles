#!/usr/bin/env bash
# Get linux syscall number by it name

if [ $# -eq 0 ]; then
    echo "Usage: $0 <syscall name>"
    return 1
fi

re='^[0-9]+$'
res=`echo -n "#include <sys/syscall.h>\nSYS_$1" | gcc -E - | awk NF | awk -F\# '$1!="" { print $1 ;} '`
if [[ $res =~ $re ]]; then
    echo $res
    return 0
else
    >&2 echo "$1: Not found"
    return 1
fi
