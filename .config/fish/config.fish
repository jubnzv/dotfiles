# Global variables {{{1
set     PATH    $HOME/.local/opt/fzf/bin/   $PATH
set     PATH    $HOME/.local/bin/           $PATH
set     PATH    $HOME/.local/scripts/       $PATH

set -gx EMSDK   ~/.local/opt/emsdk
set     PATH    $EMSDK                      $PATH
set     PATH    $EMSDK/clang/e1.38.11_64bit $PATH
set     PATH    $EMSDK/node/8.9.1_64bit/bin $PATH
set     PATH    $EMSDK/emscripten/1.38.11   $PATH

# set -x  GOROOT      "/usr/lib/go-1.10"
# set -x  GOTOOLDIR   "/usr/lib/go-1.10/pkg/tool/linux_amd64"
set -x  GOROOT      "/usr/local/go"
set     PATH        /usr/local/go/bin/             $PATH
set -x  GOPATH      $HOME/Dev/Go/
set     PATH        $GOPATH/bin/                   $PATH

set     e2k_PATH    /opt/mcst/lcc-1.21.22.e2k-v4.3.14/
set     e2k_CC      "$e2k_PATH"/bin.toolchain/e2k-linux-gcc
set     e2k_PREFIX  "$e2k_PATH"/fs/usr/

set EDITOR  nvim
set VISUAL  nvim

# Appearance {{{1
theme_gruvbox dark medium

# Command options {{{1
set LESS '-RS#3NM~g'

# Aliases {{{1
alias vim='nvim'
alias vi='nvim'
#alias grep='ag'
alias agp='ag --pager="less -r"'
alias agn='ag -n'
alias agr='ag -r'
alias ls='ls --color=auto'
alias q='exit'
alias pd='pushd'
alias pdd='popd'
alias pl='dirs -v'
alias pc='dirs -c'
alias s='sudo'
alias svim='sudoedit'
alias zt='zathura'
alias mrg='mirage'
alias cR='ctags -R'
alias cte='ctags -R -e --extra=+fq --exclude=.git -f TAGS'
alias ct='ctags -R --exclude=.git -f tags'

# cscope {{{1
# Find all available functions
alias cs_f='cscope -R -L -2 ".*" | awk -F \' \' \'{print $2 "\t" $1}\' | sort | uniq'

# git {{{1
alias git_cfg='git --git-dir=$HOME/Sources/dotfiles --work-tree=$HOME'
alias git_changelog="git --no-pager log --no-merges --pretty=format:' %x20%x20 - %s (%an)' (git tag | grep -v -- -rc | tail -n 1)..HEAD ."

# git prompt {{{1
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch yellow
set __fish_git_prompt_char_dirtystate '⚡'
set __fish_git_prompt_char_stagedstate '→'
set __fish_git_prompt_char_stashstate '↩'
set __fish_git_prompt_char_upstream_ahead '↑'
set __fish_git_prompt_char_upstream_behind '↓'

# Prompt {{{1
function fish_prompt
    set last_status $status
    set_color $fish_color_cwd
    printf '%s' (prompt_pwd)
    set_color normal
    printf '%s ' (__fish_git_prompt)
    set_color normal
end

# Start X at login {{{1
if status --is-login
    if test -z "$DISPLAY" -a $XDG_VTNR = 1
        exec startx
    end
end

set fish_escape_delay_ms 500

# {{{1 FZF settings
# Color scheme by https://github.com/nicodebo/base16-fzf
set -l color00 '#282828'
set -l color01 '#3c3836'
set -l color02 '#504945'
set -l color03 '#665c54'
set -l color04 '#bdae93'
set -l color05 '#d5c4a1'
set -l color06 '#ebdbb2'
set -l color07 '#fbf1c7'
set -l color08 '#fb4934'
set -l color09 '#fe8019'
set -l color0A '#fabd2f'
set -l color0B '#b8bb26'
set -l color0C '#8ec07c'
set -l color0D '#83a598'
set -l color0E '#d3869b'
set -l color0F '#d65d0e'

set -U FZF_DEFAULT_OPTS "
  --color=bg+:$color01,bg:$color00,spinner:$color0C,hl:$color0D
  --color=fg:$color04,header:$color0D,info:$color0A,pointer:$color0C
  --color=marker:$color0C,fg+:$color06,prompt:$color0A,hl+:$color0D
"

set -U FZF_DEFAULT_OPTS ' --bind alt-k:up,alt-j:down,alt-p:previous-history,alt-n:next-history,alt-m:accept,alt-c:cancel'

set -U FZF_DEFAULT_COMMAND 'fd --type f'
# 1}}}

# vim: foldmethod=marker
