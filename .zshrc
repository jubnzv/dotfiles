# {{{ Plugins initialization
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.config/zsh/zce.zsh/zce.zsh
source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.config/zsh/shrink-path.plugin.zsh
source ~/.config/zsh/zsh-autopair/autopair.plugin.zsh
source ~/.config/zsh/z/z.sh
# }}}

fpath=( ~/.zfunc "${fpath[@]}" )

# {{{ Environment variables
# PATH
export SCRIPTS_PATH=$HOME/.local/bin/scripts/
export PATH=$PATH:$HOME/.local/bin/:$SCRIPTS_PATH:$HOME/.cargo/bin:/usr/local/go/bin
export GOPATH=$HOME/Dev/go/
unset GOROOT

# Credentials
export DOCKER_ID_USER="jubnzv1"

# Make java UI not so ugly
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'

alias nvim=/usr/local/bin/nvim
export EDITOR="nvim"
export ALTERNATE_EDITOR="nvim"
export MANPAGER="nvim -c 'set ft=man nomod nolist' -c 'map q :q<CR>' -"
export TERMCMD="kitty"
export TERMINAL="kitty -e"
export USE_EDITOR=$EDITOR
export VISUAL=$EDITOR
export PYFLAKES_BUILTINS='_'
export PYTHONSTARTUP=~/.pythonrc
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

function precmd() {
    vcs_info
}

# Set another cursor color when running inside tmux
# zle-line-init () {
# if [[ -z "$TMUX" ]]; then
#     echo -ne "\033]12;Grey\007"
# fi
# }
# zle -N zle-line-init

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
export MAILCHECK=0

# Disable flow control
stty -ixon

# {{{ Help command
# Cred.: https://wiki.archlinux.org/index.php/Zsh_(%D0%A0%D1%83%D1%81%D1%81%D0%BA%D0%B8%D0%B9)#%D0%9A%D0%BE%D0%BC%D0%B0%D0%BD%D0%B4%D0%B0_Help
# autoload -U run-help
# autoload run-help-git
# autoload run-help-svn
# autoload run-help-svk
# unalias run-help
# alias help=run-help
# }}}

# {{{ History configuration
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=100000
setopt incappendhistory
setopt sharehistory
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
alias g='git'
alias tm='tmux'
alias :e='nvim'
alias v='nvim'
alias vi='nvim'
alias vim='nvim'
alias vc='nvim -u NONE'
alias vs='vimfzf'
# }}}

# {{{ Edit configs
alias vz='nvim ~/.zshrc; source ~/.zshrc'
alias vi3='nvim ~/.config/i3/config; i3-msg restart'
alias vi3s='nvim ~/.config/i3/i3status-rust.toml; i3-msg restart'
alias vv='nvim ~/.config/nvim/init.vim'
alias vr='nvim ~/.config/ranger/rc.conf'
alias vt='nvim ~/.tmux.conf; if [[ -z "$TMUX" ]]; then tmux source-file ~/.tmux.conf; fi'
# }}}

# {{{ git
alias gatzf='tar cfvz $(basename ~+).tar.gz --exclude .git .'
alias gatz='git archive master --format=tar.gz > "$(basename ~+)".tar.gz'
alias gaz='git archive master --format=zip > "$(basename ~+)".zip'
alias git_cfg='git --git-dir=$HOME/Sources/dotfiles --work-tree=$HOME'
# }}}

# {{{ Notekeeping in markdown with vim
alias vns='nvim ~/Org/scratch.md'
vnn() {
    nvim ~/Org/Notes/$1
}
vnf() {
    nvim $(find ~/Org/Notes/ -type f | fzf)
}
# }}}

# {{{ Web archiving
# See: https://github.com/pirate/ArchiveBox/wiki/Configuration
alias arch='env OUTPUT_DIR=/home/jubnzv/Org/WebArchive/ FETCH_PDF=False FETCH_MEDIA=False ~/.local/bin/archive'
# }}}

# {{{ arbtt
# alias arbtt-today="arbtt-stats --filter='$date>='`date +"%Y-%m-%d"`"
# }}}

# zsh
alias _up source ~/.zshrc

# {{{ python
alias vs='source venv/bin/activate'
alias ipy='ipython3'
alias ipy2='ipython'
alias ipy3='ipython3'
alias venv2='virtualenv venv --system-site-packages --python=/usr/bin/python2'
alias venv3='virtualenv venv --system-site-packages --python=/usr/bin/python3'
# }}}

# {{{ ctags
alias cR='ctags -R'
alias cte='ctags -R -e --extra=+fq --exclude=.git -f TAGS'
alias ctags='/usr/bin/ctags-universal'
# }}}

# {{{ Replacements and wrappers for *nix utils

# grep / ripgrep / silversearcher. Ag is my choice.
alias ag='ag --path-to-ignore ~/.ignore'

# {{{ ls
alias ls='ls --color=auto'
alias ll='ls -oh'
alias lla='ls -oha'
alias lt='ls -ouht'
alias lta='ls -lthua'
alias lZ='ls -Zh'
if [[ -x "$(command -v tree)" ]]; then
    alias lT='tree'
else
    alias lT='ls -lhR'
fi
# }}}

# {{{ diff
alias diffdir='diff -ENwbur'
# }}}
# }}}

# {{{ taskwarrior
alias t="task"                              # Default `task next` report
alias tb="t -redmine -gitlab"               # Filter bugwarrior-imported tasks
alias tc="t context"                        # Select context
alias tcn="t c none"                        # Unset context
alias tbu="pkill --signal USR2 taskboard"   # Update all taskboard tasks
alias bwp="bugwarrior-pull"

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

# {{{ systemctl
alias sc='systemctl --user'
alias scR='systemctl --user daemon-reload'
alias scls='systemctl --user list-unit-files'
alias sclt='systemctl --user list-timers'
sce() {
    systemctl --user enable ${1}.timer ${1}.service
}
scd() {
    systemctl --user disable ${1}.timer ${1}.service
}
scn() {
    $EDITOR ~/.config/systemd/user/${1}.{service,timer}
}
# }}}

# {{{ exim
alias exrm="exim4 -bp| grep frozen| awk '{print $3}' | xargs exim4 -Mrm"
# }}}

# }}} !Aliases

# {{{ Functions

# {{{ Find snippets
touch_each_dir() {
    # Create file in each directory
    find . -maxdepth 1 -type d -exec touch {}/$1 \;
}
# }}}

# Try to establish ssh connection for every second
sssh() {
  while true; do command ssh "$@"; [ $? -ne 255 ] && break || sleep 1; done
}

# {{{ Dirty way to kill cquery instances
pkill_cq() {
    local pid
    if [ "$UID" != "0" ]; then
        pid=$(ps -f -u $UID | ps aux | grep cquery | grep -v grep | sed 1d | fzf -m | awk '{print $2}')
    else
        pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
    fi

    if [ "x$pid" != "x" ]
    then
        echo $pid | xargs kill -${1:-9}
    fi
}
# }}}
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

# {{{ zce
zstyle ':zce:*' fg 'fg=124,bold'
zstyle ':zce:*' bg 'fg=7'
# }}}

# }}}

# {{{ Completion
compdef sshrc=ssh
compdef git_cfg=git
compdef t=task
# }}}

# {{{ tmux
# Use FZF to switch Tmux sessions
# For now I use following script instead: https://github.com/siadat/session-finder
# fzf_tmux_session() {
#     local -r fmt='#{session_id}:|#S|(#{session_attached} attached)'
#     { tmux display-message -p -F "$fmt" && tmux list-sessions -F "$fmt"; } \
#         | awk '!seen[$1]++' \
#         | column -t -s'|' \
#         | fzf -q '$' --reverse --prompt 'switch session: ' -1 \
#         | cut -d':' -f1 \
#         | xargs tmux switch-client -t
# }

# tmuxp configuration
if [[ -n $(which tmuxp) ]]; then
    eval "$(_TMUXP_COMPLETE=source_zsh tmuxp)"
    tmpz() { find ~/.tmuxp/* -type f | fzf | xargs tmuxp load -y }
fi
# }}}

# {{{ Misc.
# Get syscall number by name
syscall_num() {
    if [ $# -eq 0 ]; then
        echo "Usage: syscall_num <syscall name>"
        return 1
    fi

    local re='^[0-9]+$'
    res=`echo -n "#include <sys/syscall.h>\nSYS_$1" | gcc -E - | awk NF | awk -F\# '$1!="" { print $1 ;} '`
    if [[ $res =~ $re ]]; then
        echo $res
        return 0
    else
        >&2 echo "$1: Not found"
        return 1
    fi
}
# }}}

# Load private settings
source ~/Work/env.sh

# Auto start X
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then exec startx; fi

# ~/.local/bin/cleanup-history ~/.history
# fc -R # reload history
# trap "~/.local/bin/cleanup-history ~/.history" EXIT

# vim:foldmethod=marker:foldenable:foldlevel=0:sw=4:tw=120
