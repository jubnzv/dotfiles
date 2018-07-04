# Global variables {{{1
set     PATH        $HOME/.local/opt/fzf/bin/      $PATH
set     PATH        $HOME/.local/bin/              $PATH
set     PATH        $HOME/.local/scripts/          $PATH
set -x  GOPATH      $HOME/Dev/Go/
set -x  GOROOT      "/usr/lib/go-1.10"
set -x  GOTOOLDIR   "/usr/lib/go-1.10/pkg/tool/linux_amd64"
set     PATH        $GOPATH/bin/                   $PATH

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
alias cte='ctags -R -e --extra=+fq --exclude=.git -f TAGS'
alias ct='ctags -R --exclude=.git -f tags'

# git {{{1
alias git_cfg='git --git-dir=$HOME/Sources/dotfiles --work-tree=$HOME'
alias git_changelog="git --no-pager log --no-merges --pretty=format:' %x20%x20 - %s (%an)' (git tag | grep -v -- -rc | tail -n 1)..HEAD ."

# cscope routines {{{1
# Find all available functions
alias cs_f='cscope -R -L -2 ".*" | awk -F \' \' \'{print $2 "\t" $1}\' | sort | uniq'


# Fish git prompt {{{1
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch yellow

# Status Chars {{{1
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

# vim: foldmethod=marker sw=1
