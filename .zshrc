# {{{ Plugins initialization
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.config/zsh/zce.zsh/zce.zsh
source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.config/zsh/shrink-path.plugin.zsh
source ~/.config/zsh/zsh-autopair/autopair.plugin.zsh
source ~/.config/zsh/z/z.sh
# source /usr/share/autojump/autojump.sh
# }}}

# {{{ Environment variables
# PATH
export SCRIPTS_PATH=$HOME/.local/scripts
export PATH=$PATH:$HOME/.local/bin/:$SCRIPTS_PATH:$GOROOT/bin:$HOME/.cargo/bin

# Golang
export GOROOT=~/.local/opt/go
export GOPATH=$HOME/Dev/go/

# Credentials
export DOCKER_ID_USER="jubnzv1"

# Misc
export EDITOR="nvim"
export MANPAGER="nvim -c 'set ft=man nomod nolist' -c 'map q :q<CR>' -"
export TERMCMD="kitty"
export TERMINAL="kitty -e"
export USE_EDITOR=$EDITOR
export VISUAL=$EDITOR
export PYFLAKES_BUILTINS='_'
# }}}

# {{{ Prompt & colors
autoload -U colors && colors # Enable colorized prompt
export CLICOLORS=1
export LS_COLORS="di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32"

# Use same colors for autocompletion
zmodload -a colors
zmodload -a autocomplete
zmodload -a complist
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

autoload -Uz vcs_info        # Show git branch name
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats '  %b'
setopt prompt_subst

# Set another cursor color when running inside tmux
zle-line-init () {
if [[ -z "$TMUX" ]]; then
    echo -ne "\033]12;Grey\007"
fi
}
zle -N zle-line-init

PS1='%{$fg[yellow]%}$(shrink_path -f)%{$reset_color%}%{$fg[cyan]%}${vcs_info_msg_0_}%{$reset_color%} '
# }}}

# {{{ zsh options
# Turn off all beeps
unsetopt BEEP
setopt no_beep

# Perform cd if command is directory.
setopt auto_cd

# Make cd push the old directory onto the directory stack.
setopt auto_pushd

# Do not push multiple copies of the same directory onto the directory stack.
setopt pushd_ignore_dups

# Disable mail checking: use mail client instead
MAILCHECK=0

# {{{ History configuration
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=100000
# Write to the history file immediately, not when the shell exits.
setopt INC_APPEND_HISTORY
# Don't record an entry that was just recorded again.
setopt HIST_IGNORE_DUPS
# Remove superfluous blanks before recording entry.
setopt HIST_REDUCE_BLANKS
# Don't store lines beginning with a space
setopt HIST_IGNORE_SPACE
# }}}

# }}}

# {{{ Aliases

# {{{ Common
alias q='exit'
alias :q='exit'
alias pd='pushd'
alias pdd='popd'
alias pl='dirs -v'
alias pc='dirs -c'
alias svim='sudoedit'
alias s='sudo'
alias less='less -Q' # Turn off beeps
alias r='ranger'
alias zt='zathura'
alias mrg='mirage'
alias j='z'

# vim
alias :e='nvim'
alias v='nvim'
alias vi='nvim'
alias vim='nvim'
alias vc='nvim -u NONE'
alias vz='nvim ~/.zshrc; source ~/.zshrc'
alias vi3='nvim ~/.config/i3/config; i3-msg restart'
alias vv='nvim ~/.config/nvim/init.vim'
alias vt='nvim ~/.tmux.conf; if [[ -z "$TMUX" ]]; then tmux source-file ~/.tmux.conf; fi'
function vn() {
    nvim ~/Org/Notes/$*
}

# emacs
alias em='emacs -nw'
function emn() {
    emacs -nw ~/Org/Notes/
}

# ctags
alias cR='ctags -R'
alias cte='ctags -R -e --extra=+fq --exclude=.git -f TAGS'

# git / packaging
alias gatzf='tar cfvz $(basename ~+).tar.gz --exclude .git .'
alias gatz='git archive master --format=tar.gz > "$(basename ~+)".tar.gz'
alias gaz='git archive master --format=zip > "$(basename ~+)".zip'

# zsh
alias _up source ~/.zshrc

alias ipy='ipython3'
alias ipy2='ipython'
alias ipy3='ipython3'
# }}}

# {{{ Replacements and wrappers for *nix utils
# ls
alias ls='ls --color=auto'
if [ -x "$(command -v exa)" ]; then
    alias l='exa'
    alias ll='exa -l'
    alias l1='exa -1'
    alias lla='exa -l -a'
    alias lt='exa --sort=created -l --reverse'
    alias lta='exa --sort=created -l --reverse -a'
    alias lT='exa -T'
else
    alias l='ls'
    alias ll='ls -l'
    alias l1='ls -1'
    alias lla='ls -la'
    alias lt='ls -lt'
    alias lta='ls -lat'
    if [[ -x "$(command -v tree)" ]]; then
        alias lT='tree'
    else
        alias lT='ls -lR'
    fi
fi

# grep / ripgrep / silversearcher. Ag is my choice.
alias ag='ag --path-to-ignore ~/.ignore'
if [[ -x "$(command -v rg)" ]]; then
    alias rg='ag --path-to-ignore ~/.ignore'
    alias rgn='ag -n'
else
    alias rg='grep'
    alias rgn='grep -n'
fi

# buku: boomarks manager
if [[ -x "$(command -v buku)" ]]; then
    alias b='buku --suggest'
fi
# }}}

# {{{ taskwarrior
alias t="task"                                            # Default `task next` report
alias tb="t -redmine -gitlab"                              # Filter bugwarrior-imported tasks
alias tl="t minimal"                                       # Report: one line per task with short description
alias tc="t context"                                       # Select context
alias tcn="t c none"                                       # Unset context
alias tdw="t due.before:eow+1d"                            # Due this week (hard deadline)
alias tdd="t due:today"                                    # Due today (hard deadline)
alias tsw="t due.before:eow+1d or scheduled.before:eow+1d" # Due this week (hard and soft deadlines)
alias tsd="t due:today or scheduled:today"                 # Due today (hard and soft deadlines)

# {{{ M-t: Select id one of taskwarrior tasks with fzf
fzf_show_task() {
    task_id=$(t minimal 2> /dev/null                      \
    | sed -e '/^\s*$/d' -e '1,3d; $ d' -e '/^\ *[0-9]/!d' \
    | fzf --tac --no-sort                                 \
    | awk '{print $1}') &&
        t $task_id
}
zle -N fzf_show_task
bindkey '^[t' fzf_show_task
# }}}

if [[ "$(command -v task)" ]]; then
    cal() {
        task calendar
    }
else
    alias cal="cal -3"
fi
# }}}

# }}}

# {{{ Functions

# Try to establish ssh connection for every second
sssh() {
  while true; do command ssh "$@"; [ $? -ne 255 ] && break || sleep 1; done
}

# Automatically activate virtualenv on `cd`
# function cd {
#     if [[ -d ./venv ]] ; then
#         deactivate
#     fi
#
#     builtin cd "$@"
#
#     if [ -d "venv" ] ; then
#         source venv/bin/activate
#     fi
# }
# }}}

# {{{ Keybinds
bindkey -e                        # Enable emacs-mode
autoload -Uz compinit && compinit # Command completion
bindkey "^[;" zce                 # easymotion

bindkey '^[а'	emacs-forward-word
bindkey '^[и'	emacs-backward-word
bindkey '\ef'   emacs-forward-word
bindkey '\eb'   emacs-backward-word

# Delete words like a bash
backward-kill-dir () {
    local WORDCHARS=${WORDCHARS/\/}
	    zle backward-kill-word

}
zle -N backward-kill-dir
bindkey '^[^?' backward-kill-dir
# }}}

# {{{ Plugins

# {{{ fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# {{{ Gruvbox color scheme
# https://github.com/nicodebo/base16-fzf/blob/master/bash/base16-gruvbox-dark-soft.config
_gen_fzf_default_opts() {
local color00='#32302f'
local color01='#3c3836'
local color02='#504945'
local color03='#665c54'
local color04='#bdae93'
local color05='#d5c4a1'
local color06='#ebdbb2'
local color07='#fbf1c7'
local color08='#fb4934'
local color09='#fe8019'
local color0A='#fabd2f'
local color0B='#b8bb26'
local color0C='#8ec07c'
local color0D='#83a598'
local color0E='#d3869b'
local color0F='#d65d0e'

export FZF_DEFAULT_OPTS="
  --color=bg+:$color01,bg:$color00,spinner:$color0C,hl:$color0D
  --color=fg:$color04,header:$color0D,info:$color0A,pointer:$color0C
  --color=marker:$color0C,fg+:$color06,prompt:$color0A,hl+:$color0D
"
}

# Defaults already looks nice when kitty colors are loaded

# _gen_fzf_default_opts
# }}}

export FZF_DEFAULT_OPTS=${FZF_DEFAULT_OPTS}" --bind alt-k:up,alt-j:down,alt-p:previous-history,alt-n:next-history,alt-m:accept,alt-q:cancel"

if [[ "$(command -v fd)" ]]; then
    export FZF_DEFAULT_COMMAND='fd --type f --follow'
    export FZF_CTRL_T_COMMAND='fd --type file --follow'
fi

function vmans() {
    man -k . | fzf -n1,2 --preview "echo {} | cut -d' ' -f1 | sed 's# (#.#' | sed 's#)##' | xargs -I% man %" --bind "enter:execute: (echo {} | cut -d' ' -f1 | sed 's# (#.#' | sed 's#)##' | xargs -I% ${EDITOR:-vim} -R -c 'set ft=man nomod nolist' -c 'map q :q<CR>' -c \"Man %\")"
}

# Disable <TAB> completion
bindkey '^I' $fzf_default_completion
# }}}

# {{{ z
export _Z_EXCLUDE_DIRS=(
    $HOME/Work/Beremiz/Projects
)
# }}}

# }}}

# {{{ nnn configuration
export DISABLE_FILE_OPEN_ON_NAV=0
export NNN_BMS='d:~/Documents;D:~/Downloads/;u:~/Uni/;m:/mnt/;M:/media/jubnzv/;w:~/Work/;e:~/Dev/'
# }}}

# {{{ Git
alias git_cfg='git --git-dir=$HOME/Sources/dotfiles --work-tree=$HOME'
# }}}

# Auto start X
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then exec startx; fi

# vim:foldmethod=marker:foldenable:foldlevel=0:sw=4:tw=120
