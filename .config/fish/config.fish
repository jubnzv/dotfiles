# {{{ Paths to various toolchains and SDK's
set -gx EMSDK       ~/.local/opt/emsdk
set -gx e2k_PATH    /opt/mcst/lcc-1.21.18.e2k-v3.3.14/
set -gx e2k_CC      "$e2k_PATH"/bin.toolchain/e2k-linux-gcc
set -gx e2k_PREFIX  "$e2k_PATH"/fs/usr/
set -gx GOROOT      "/usr/local/go"
set -gx GOPATH      $HOME/Dev/Go/

set PATH    $HOME/.local/opt/fzf/bin/   $PATH
set PATH    $HOME/.local/bin/           $PATH
set PATH    $HOME/.local/scripts/       $PATH
set PATH    /usr/local/go/bin/          $PATH
set PATH    $GOPATH/bin/                $PATH
set PATH    ~/.cargo/bin/               $PATH
# set PATH    $EMSDK                      $PATH
# set PATH    $EMSDK/clang/e1.38.11_64bit $PATH
# set PATH    $EMSDK/node/8.9.1_64bit/bin $PATH
# set PATH    $EMSDK/emscripten/1.38.11   $PATH
# }}}

# Ripgrep config location
set -gx RIPGREP_CONFIG_PATH     $HOME/.ripgreprc

# Editor settings
set -gx EDITOR  nvim
set -gx VISUAL  nvim

# Terminal settings (consumed by ranger)
set -gx TERMCMD     "urxvt"
set -gx TERMINAL    "urxvt -e"

# Color theme
theme_gruvbox dark medium

# Colorized gcc output
set -gx GCC_COLORS 1

# Delay time related to Vi switching to normal mode
set fish_escape_delay_ms 100

# Show line numbers in `less`
# set -gx LESS '-RS#3NM~g'

# {{{ Aliases and abbrevations
alias q='exit'
alias pd='pushd'
alias pdd='popd'
alias pl='dirs -v'
alias pc='dirs -c'
alias svim='sudoedit'
abbr 's=sudo'
alias s='sudo'  # To keep history compability

# vim
alias v='nvim'
alias vi='nvim'
alias vim='nvim'
alias vn='nvim -u NONE'

# ctags
alias cR='ctags -R'
alias cte='ctags -R -e --extra=+fq --exclude=.git -f TAGS'
alias ct='ctags -R --exclude=.git -f tags'

# X apps
alias zt='zathura'
alias mrg='mirage'

# {{{2 Replacement for common unix utils
# ls
alias ls='ls --color=auto'
if which exa > /dev/null
    alias l='exa'
    alias ll='exa -l'
    alias l1='exa -1'
    alias lla='exa -l -a'
    alias lt='exa --sort=created -l --reverse'
    alias lta='exa --sort=created -l --reverse -a'
else
    alias l='ls'
    alias ll='ls -l'
    alias l1='ls -1'
    alias lla='ls -la'
    alias lt='ls -lt'
    alias lta='ls -lat'
end

# grep
abbr 'ag=rg'
abbr 'agn=rgn'
abbr 'grep=rg'
if which rg > /dev/null
    alias ag='rg'
    alias rgn='rg --max-depth=1'
else if which ag > /dev/null
    alias rg='ag --path-to-ignore ~/.agignore'
    alias rgn='ag -n'
else
    alias rg='grep'
    alias rgn='grep -n'
end

# find
if not which fd > /dev/null
    abbr 'fd=find'
end

# cat -> bat
if which bat > /dev/null
    abbr 'ct=bat'
else
    abbr 'ct=cat'
end

# buku: boomarks manager
if which buku > /dev/null
    alias b='buku --suggest'
    abbr 'bw=b -w'
    abbr 'bp=b -p'
    abbr 'ba=b -a'
end

# ping
if which prettyping > /dev/null
    abbr 'ping=prettyping'
end
# }}}2

# {{{2 taskwarrior
alias t="task"
alias tl="task minimal"
alias tdw="task due.before:eow+1d"
alias tdd="task due:today"
alias tsw="task due.before:eow+1d or scheduled.before:eow+1d"
alias tsd="task due:today or scheduled:today"
alias tc="task context"
abbr 'tp=t proj:'
abbr 'ta=t a'
abbr 'tcn=t c none'

function __fzf_select_task -d 'select id one of taskwarrior tasks with fzf'
    set -l res (task minimal 2> /dev/null | sed -e '/^\s*$/d' -e '1,3d; $ d' -e '/^\ *[0-9]/!d' | fzf)
    echo $res | awk '{print $1}'
end

alias tf="task (__fzf_select_task)"
alias tfe="task edit (__fzf_select_task)"
alias tfd="task done (__fzf_select_task)"
alias tfD="task delete (__fzf_select_task)"

if which task > /dev/null
    alias cal="task calendar"
else
    alias cal="cal -3"
end
# 2}}}

# cscope
# Find all available functions
alias cs_f='cscope -R -L -2 ".*" | awk -F \' \' \'{print $2 "\t" $1}\' | sort | uniq'

# git
abbr 'git_cfg=git --git-dir=$HOME/Sources/dotfiles --work-tree=$HOME'

# Datetime
abbr '_dtd=(date +%Y-%m-%d)'
abbr '_dtt=(date +%Y-%m-%d-%H:%M:%S)'

# fish shell configuration
abbr '_up=source ~/.config/fish/config.fish'
abbr '_et=echo $TERM'

# Custom scripts
abbr 'gi_up=update-gitignore'

# }}}

# {{{ git prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch yellow
set __fish_git_prompt_char_dirtystate '⚡'
set __fish_git_prompt_char_stagedstate ''
set __fish_git_prompt_char_stashstate ''
set __fish_git_prompt_char_upstream_ahead '↑'
set __fish_git_prompt_char_upstream_behind '↓'
# }}}

# Disable greeting
set fish_greeting

function fish_prompt
    set last_status $status
    set_color $fish_color_cwd
    printf '%s' (prompt_pwd)
    set_color normal
    printf '%s ' (__fish_git_prompt)
    set_color normal
end

# {{{ Start X at login
if status --is-login
    if test -z "$DISPLAY" -a $XDG_VTNR = 1
        exec startx
    end
end
# }}}

# {{{ FZF settings
# https://github.com/nicodebo/base16-fzf/blob/master/fish/base16-gruvbox-dark-medium.fish
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

set -x FZF_DEFAULT_OPTS "--color=bg+:$color01,bg:$color00,spinner:$color0C,hl:$color0D,fg:$color04,header:$color0D,info:$color0A,pointer:$color0C,marker:$color0C,fg+:$color06,prompt:$color0A,hl+:$color0D --bind alt-k:up,alt-j:down,alt-p:previous-history,alt-n:next-history,alt-m:accept,alt-q:cancel"
if which fd > /dev/null
    set -x FZF_DEFAULT_COMMAND 'fd --type f --follow'
    set -x FZF_CTRL_T_COMMAND 'fd --type file --follow'
end
# }}}

# vim:foldmethod=marker:foldenable:foldlevel=0:sw=4:tw=100
