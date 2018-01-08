#!/usr/bin/zsh
#
# Runs vim session with codi python notebook
# Usage: codi [filetype] [filename]
#

local syntax="${1:-python}"
vim -c \
"let g:startify_disable_at_vimenter = 1 |\
set bt=nofile ls=0 noru nonu nornu |\
hi ColorColumn ctermbg=NONE |\
hi VertSplit ctermbg=NONE |\
hi NonText ctermfg=0 |\
Codi $syntax" "$@"
