#!/bin/bash
#
# gitlog prints an abbreviated list of current patches against the master
# version. It prints them from oldest to newest and shows the author and
# description, with H for HEAD, ^ for HEAD^, 2 for HEAD~2, and so forth
#
# Based on https://opensource.com/article/20/1/bash-scripts-git
#
branch=$1

if test "x$branch" = x; then
    branch=`git branch -a | grep "*" | cut -d ' ' -f2`
fi

patches=0
tracking=`git rev-parse --abbrev-ref --symbolic-full-name @{u}`

LIST=`git log --reverse --abbrev-commit --pretty=oneline $tracking..$branch | cut -d ' ' -f1 |paste -s -d ' '`
for i in $LIST; do patches=$(echo $patches + 1 | bc);done

if [[ $branch =~ .*for-next.* ]]
then
    start=HEAD
#    start=origin/for-next
else
    start=origin/master
fi

tracking=`git rev-parse --abbrev-ref --symbolic-full-name @{u}`

echo "-----------------------[" $branch "]-----------------------"
patches=$(echo $patches - 1 | bc);
for i in $LIST; do
    if [ $patches -eq 1 ]; then
        cnt=" ^"
    elif [ $patches -eq 0 ]; then
        cnt=" H"
    else
        if [ $patches -lt 10 ]; then
            cnt=" $patches"
        else
            cnt="$patches"
        fi
    fi
    git show --abbrev-commit -s --pretty=format:"$cnt %h %<|(32)%an %s %n" $i
    patches=$(echo $patches - 1 | bc)
done
