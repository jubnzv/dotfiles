# {{{ Plugins
if [[ ! -f ~/.zplug/init.zsh ]]; then
	git clone https://github.com/b4b4r07/zplug ~/.zplug
fi

if [[ -f ~/.zplug/init.zsh ]] ; then
    source ~/.zplug/init.zsh

    # Easymotion alternative for zsh
    #source ~/.config/zsh/zce.zsh/zce.zsh
    zplug 'hchbaw/zce.zsh'

    # Autosuggestions
    zplug "tarruda/zsh-autosuggestions", use:"zsh-autosuggestions.zsh"

    # Syntax highlighting
    zplug "zdharma/fast-syntax-highlighting", defer:3
    # Color parens and highlight matching paren
    export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

    # A plugin to shrink directory paths for brevity and pretty-printing
    zplug "plugins/shrink-path", from:oh-my-zsh

    # Auto-close and delete matching delimiters
	zplug "hlissner/zsh-autopair", defer:2

    # Install plugins if not all are installed
    if ! zplug check; then
        zplug install
    fi

    # source plugins and add commands to $PATH
    zplug load
fi
# }}}

fpath=( ~/.zfunc "${fpath[@]}" )

# fasd setup
# have a (any), s (show), z (cd), etc.
if [[ -x "$(command -v fasd)" ]]; then
    eval "$(fasd --init posix-alias zsh-hook zsh-ccomp zsh-ccomp-install)"
fi

# {{{ Options
# Golang workspace location. References:
# https://golang.org/doc/code.html#Workspaces
# https://golang.org/doc/code.html#GOPATH
export GOPATH=$HOME/Dev/go/

# Path to golang installation. Should be set only if multiple versions of Go are using simultaneously.
# See: https://golang.org/doc/install#extra_versions
unset GOROOT

# PATH
export PATH=$PATH:$HOME/.local/bin/:$HOME/.cargo/bin:/usr/local/go/bin:$GOPATH/bin/

# Default username for https://hub.docker.com
export DOCKER_ID_USER="jubnzv1"

# Contains latest cppcheck version with some personal customizations.
export CPPCHECK_HOME=$HOME/Dev/cppcheck/cppcheck-clean/

# Make Java UI not so ugly.
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'

export EDITOR="nvim"
export ALTERNATE_EDITOR="nvim"
export MANPAGER="nvim -c 'set ft=man nomod nolist' -c 'map q :q<CR>' -"
export TERMCMD="kitty"
export TERMINAL="kitty -e"
export USE_EDITOR=$EDITOR
export VISUAL=$EDITOR
export PYFLAKES_BUILTINS='_' # Don't treat i18n '_' as error
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

zstyle ':zce:*' fg 'fg=124,bold'
zstyle ':zce:*' bg 'fg=7'

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
# Spell check commands and offer correction (pdw > pwd)
setopt correct

# Turn off all beeps
unsetopt BEEP
setopt no_beep

# http://zsh.sourceforge.net/Intro/intro_6.html
DIRSTACKSIZE=8

# Perform cd if command is directory.
setopt auto_cd

# Make cd push the old directory onto the directory stack.
setopt auto_pushd

# Do not push multiple copies of the same directory onto the directory stack.
setopt pushd_ignore_dups

# No pushd messages
setopt pushd_silent

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
alias history='history -i'
# }}}

# }}}

# {{{ Aliases
# Common
alias q='exit'
alias :bd='exit'
alias :q='exit'
alias pd='pushd'
alias pdd='popd'
alias pl='dirs -v'
alias pc='dirs -c'
alias svim='sudoedit'
alias s='sudo'
alias less='less -Q' # Turn off beeps
alias rp='realpath'
alias mkb='mkdir -p ./build; cd build'
alias ag='ag --path-to-ignore ~/.ignore'
alias minicom_usb0='sudo minicom -D /dev/ttyUSB0 -C /tmp/minicom.log'
alias r='ranger'
alias zt='zathura'
alias mrg='mirage'
alias j='z'
alias du1="du --max-depth=1"
alias du2="du --max-depth=2"
alias tree='tree -C'

# vim
alias :e='nvim'
alias v='nvim'
alias v.='nvim .'
alias vi='nvim'
alias vim='nvim'
alias vO='nvim -O' # Open in vertical splits
alias vo='nvim -o' # Open in horizontal splits
alias vc='nvim -u NONE'

# tmux
alias tm='tmux'
alias tmkill='tmux kill-session -t'
alias tma='tmux attach -t'

# copy working directory to clipboard
alias cpwd='pwd | tr -d "\n" | xsel -ib'

# mkdir + cd
mkcd() {
    [[ $# -gt 1 ]] && return 1
    mkdir -p "$1" && cd "$1" || return 1
}

# Edit configs
alias vz='nvim ~/.zshrc; source ~/.zshrc'
alias vi3='nvim ~/.config/i3/config; i3-msg restart'
alias vi3s='nvim ~/.config/i3/i3status-rust.toml; i3-msg restart'
alias vv='nvim ~/.config/nvim/init.vim'
alias vr='nvim ~/.config/ranger/rc.conf'
alias vt='nvim ~/.tmux.conf; if [[ -z "$TMUX" ]]; then tmux source-file ~/.tmux.conf; fi'
alias vsh='nvim ~/dotfiles/scripts/'

# Notekeeping in markdown with vim
alias vns='nvim ~/Org/scratch.md'
vnn() {
    nvim ~/Org/Notes/$1
}
vnf() {
    nvim $(find ~/Org/Notes/ -type f | fzf)
}

# rsync
alias rs='rsync -ah --progress'

# {{{ git
alias g='git'

alias gh='git help'

alias gb='git branch'
alias gbd='git branch --delete'
alias gbdd='git branch --delete --force'

alias gatzf='tar cfvz $(basename ~+).tar.gz --exclude .git .'
alias gatz='git archive master --format=tar.gz > "$(basename ~+)".tar.gz'
alias gaz='git archive master --format=zip > "$(basename ~+)".zip'

alias gdl="git diff --unified=0 | grep -Po '(?<=^\+)(?!\+\+).*'"

alias gf='git fetch --prune'
alias gfa='git fetch --prune --all'

alias gsm='git submodule'
alias gsma='git submodule add'
alias gsmi='git submodule init'
alias gsmu='git submodule update'
alias gsmui='git submodule update --init --recursive'
alias gsmy='git submodule sync'
#  }}}

# {{{ apt
alias ap='apt-get'
alias apu='apt-get update'
alias aps='apt-cache search'
# }}}

# zsh
alias _up source ~/.zshrc

# Global aliases
alias -g KE="2>&1"
alias -g NE="2>/dev/null"
alias -g NUL=">/dev/null 2>&1"
alias -g G='|& ag -i'
alias -g L="|& less"
alias -g V="| nvim -"
# Perform operation using fzf. Examples:
#   find /usr/include -name "test.h" F nvim
#   find /usr/lib -name "test.so.*" F readelf -h
if [[ -z "$TMUX" ]]; then
    alias -g F="| fzf --multi --cycle | tr '\n' '\0' | xargs --no-run-if-empty -0 sh -c '\$0 \"\$@\" </dev/tty' "
else
    alias -g F="| fzf-tmux --tac | tr '\n' '\0' | xargs --no-run-if-empty -0 sh -c '\$0 \"\$@\" </dev/tty' "
fi

# python
alias vs='source venv/bin/activate'
alias py2='python2'
alias py3='python3'
alias ipy='ipython3'
alias ipy2='ipython'
alias ipy3='ipython3'
alias venv2='virtualenv venv --system-site-packages --python=/usr/bin/python2'
alias venv3='virtualenv venv --system-site-packages --python=/usr/bin/python3'

# ctags
alias cR='ctags -R'
alias cte='ctags -R -e --extra=+fq --exclude=.git -f TAGS'
alias ctags='/usr/bin/ctags-universal'

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

# diffs
alias diffdir='diff -ENwbur'
alias cpd='cpdiff'

# {{{ taskwarrior
if [[ -x "$(command -v task)" ]]; then
    alias t="task"                 # Default `task next` report
    alias tt="t recent"            # Recently added tasks
    alias tb="t -redmine -gitlab"  # Filter bugwarrior-imported tasks
    alias tc="t context"           # Select context
    alias tcn="t c none"           # Unset context
    alias tactive="date; t active"
    alias tstart="date; t start"
    alias tstopall="t rc.gc=off +ACTIVE _ids | xargs task rc.gc=off rc.confirmation=no stop"
    alias tdoned='t end:today status:completed all'
    alias tdonew='t end.after:today-7d status:completed all'
    alias tdonem='t end.after:today-30d status:completed all'
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
fi


if [[ -x "$(command -v task)" ]]; then
    cal() {
        task calendar
    }
else
    alias cal="cal -3"
fi
# }}}

# {{{ systemd
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

alias jc='journalctl'
alias ju='journalctl -u'
# }}}

alias exrm="exim4 -bp| grep frozen| awk '{print $3}' | xargs exim4 -Mrm"

# Sequence that disables cursor blinking
alias stopblink="printf '\033[?12l'"
# }}}

# {{{ Functions

# Modprobe modules used by VirtualBox
modbrobe_vb() {
    sudo modprobe vboxguest
    sudo modprobe vboxnetadp
    sudo modprobe vboxnetflt
}

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

# {{{ Keybindings
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

bindkey -s "\ei"  "^Qvimfzf .^J"            # Select file with fzf and open it in vim.
bindkey -s "\e\\"  "^Qfzf-tmux-session^J"   # Select tmux session using fzf and attach it.
# }}}

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

export FZF_DEFAULT_OPTS=${FZF_DEFAULT_OPTS}" --bind alt-k:up,alt-j:down,alt-p:previous-history,alt-n:next-history,alt-m:accept,alt-q:cancel,esc:cancel"

if [[ "$(command -v fd)" ]]; then
    export FZF_DEFAULT_COMMAND='fd --type f --follow'
    export FZF_CTRL_T_COMMAND='fd --type file --follow'
fi

function vmans() {
    man -k . | fzf -n1,2 --preview "echo {} | cut -d' ' -f1 | sed 's# (#.#' | sed 's#)##' | xargs -I% man %" --bind "enter:execute: (echo {} | cut -d' ' -f1 | sed 's# (#.#' | sed 's#)##' | xargs -I% ${EDITOR:-vim} -R -c 'set ft=man nomod nolist' -c 'map q :q<CR>' -c \"Man %\")"
}

# Search ctags.
# Creds: https://github.com/vbauerster/dotfiles/blob/master/.functions.zsh
function fzf-ctags() {
  local line
  [ -e tags ] &&
  line=$(
    awk 'BEGIN { FS="\t" } !/^!/ {print toupper($4)"\t"$1"\t"$2"\t"$3}' tags |
    cut -c1-$COLUMNS | fzf --nth=2 --tiebreak=begin
  ) && $EDITOR $(cut -f3 <<< "$line") -c "set nocst" \
                                      -c "silent tag $(cut -f2 <<< "$line")"
}
zle -N fzf-ctags
bindkey "^[t" fzf-ctags

# Disable <TAB> completion
bindkey '^I' $fzf_default_completion

function fzf-fasd-dir() {
	# otherwise will end up as a cdable var
	local dir
	dir="$(fasd -ds | fzf --tac | awk '{print $2}')" && \
	cd "$dir"
}
zle -N fzf-fasd-dir
bindkey "^[c" fzf-fasd-dir
# }}}

# {{{ Autocompletion
compdef sshrc=ssh
compdef scp-speed-test=scp
compdef g=git
# }}}

# {{{ Utilities
# Shell commands usage statistics
function zsh_stats() {
	fc -l 1 | \
		awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | \
		grep -v "./" | column -c3 -s " " -t | sort -nr | nl | head -n20
}
# }}}

# Load private settings
if [ -f ~/Work/env.sh ]; then
    source ~/Work/env.sh
fi

# Auto start X
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then exec startx; fi

# ~/.local/bin/cleanup-history ~/.history
# fc -R # reload history
# trap "~/.local/bin/cleanup-history ~/.history" EXIT

# vim:foldmethod=marker:foldenable:foldlevel=0:sw=4:tw=120
