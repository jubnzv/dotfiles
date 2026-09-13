# {{{ Plugins
if [[ ! -f ~/.zplug/init.zsh ]]; then
	git clone https://github.com/b4b4r07/zplug ~/.zplug
fi

if [[ -f ~/.zplug/init.zsh ]] ; then
    source ~/.zplug/init.zsh

    # Autosuggestions
    zplug "tarruda/zsh-autosuggestions", use:"zsh-autosuggestions.zsh"

    # Syntax highlighting
    zplug "zdharma/fast-syntax-highlighting", defer:3

    # Color parens and highlight matching paren
    export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

    # A plugin to shrink directory paths for brevity and pretty-printing
    zplug "plugins/shrink-path", from:oh-my-zsh

    # Automatically sends out a notification when a long running task has completed
	zplug "MichaelAquilina/zsh-auto-notify", defer:2

    # Install plugins if not all are installed
    if ! zplug check; then
        zplug install
    fi

    # Source plugins and add commands to $PATH
    zplug load
fi
# }}}

fpath=( ~/.zfunc ~/.zsh/zsh-completions/src/ "${fpath[@]}" )
[[ -x "$(command -v rustup)" ]] && rustup completions zsh cargo > ~/.zfunc/_cargo 2>/dev/null

if [[ -x "$(command -v zoxide)" ]]; then
    eval "$(zoxide init zsh)"
fi

# {{{ Global variables
# Golang workspace location. References:
# https://golang.org/doc/code.html#Workspaces
# https://golang.org/doc/code.html#GOPATH
export GOPATH=$HOME/Dev/go/

# Path to golang installation. Should be set only if multiple versions of Go are using simultaneously.
# See: https://golang.org/doc/install#extra_versions
unset GOROOT

# Path to LLVM build directory
export LLVM=$HOME/Dev/llvm-project/build/bin

export DOTNET_CLI_TELEMETRY_OPTOUT=1
# export DOTNET_ROOT=$HOME/.dotnet

export VCPKG_DISABLE_METRICS=1
export VCPKG_ROOT=/home/jubnzv/Sources/vcpkg

export CLASSPATH=/usr/local/lib/tla2tools.jar:$CLASSPATH

# PATH
export PATH=$PATH:$HOME/.local/bin/
export PATH=$PATH:$HOME/.cargo/bin
export PATH=$PATH:$HOME/.luarocks/bin
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:/usr/local/bin
export PATH=$PATH:$GOPATH/bin/
export PATH=$PATH:$LLVM/
# export PATH=$PATH:$HOME/.dotnet

if [ -f /etc/arch-release ]; then
    export LC_ALL=C
fi

# Default username for https://hub.docker.com
export DOCKER_ID_USER="jubnzv1"

# Shortcuts for common tools
export CPPCHECK=$HOME/Dev/cppcheck/
export FLAMEGRAPH=$HOME/Dev/tools/FlameGraph

# Git hook used to check conventional commits.
export SAILR_CONFIG=$HOME/.sailr/sailr.json

# Debian tools
export QUILT_PATCHES=debian/patches

export JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:bin/java::")
# Make Java UI not so ugly.
# export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true
# -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel
# -Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'

# Configure Qt theme with qt5ct
# export QT_QPA_PLATFORM='wayland;xcb'
export QT_QPA_PLATFORMTHEME='qt5ct'

export EDITOR="nvim"
export DEBEMAIL="jubnzv@gmail.com"
export ALTERNATE_EDITOR="nvim-qt"
export MANPAGER="less"
export TERMCMD="alacritty"
export TERMINAL="alacritty -e"
export USE_EDITOR=$EDITOR
export VISUAL=$EDITOR
export PYFLAKES_BUILTINS='_' # Don't treat i18n '_' as error
export PYTHONSTARTUP=~/.pythonrc

# https://www.lotharschulz.info/2018/10/21/transparent-editing-of-gpg-encrypted-files-with-vim/
export GPG_TTY=`tty`

# OCaml environment
if [[ -x "$(command -v opam)" ]]; then
  eval "$(opam config env)"
fi
# }}}

# {{{ Prompt & colors
autoload -U colors && colors # Enable colorized prompt
export CLICOLORS=1

# Setup LS_COLORS https://github.com/trapd00r/LS_COLORS
if [ -f $HOME/.zsh/dircolors ]; then
  eval $( dircolors -b $HOME/.zsh/dircolors )
else
  export LS_COLORS="di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;3 2"
fi

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

# {{{ History configuration
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=100000
export SAVEHIST=1000000
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
alias q='exit'
alias :q='exit'
alias :qa='exit'
alias pd='pushd'
alias pdd='popd'
alias s='sudo'
alias less='less -Q' # Turn off beeps
alias rp='realpath'
alias grep='grep --color=auto'
zt() { zathura $1 2>&1 >/dev/null & }
alias j='z'
jj() { z "$@"; [[ $TMUX ]] && tmux rename-window "#{b:pane_current_path}" }
alias tree='tree -C'
alias r='ranger'
alias getip='dig +short myip.opendns.com @resolver1.opendns.com'
alias gdb='gdb -q'
alias v='nvim'
alias vim='nvim'
alias ls='ls --color=auto'
alias diffdir='diff -ENwbur'

mkcd() {
    [[ $# -gt 1 ]] && return 1
    mkdir -p "$1" && cd "$1" || return 1
    [[ $TMUX ]] && tmux rename-window "#{b:pane_current_path}"
}

# git
alias g='git'
alias gc='f() { url="${1%/}"; url="${url%.git}"; org=$(basename $(dirname "$url")); repo=$(basename "$url"); git clone --filter=blob:none "https://github.com/$org/$repo.git" "${org}__${repo}"; }; f'
gcd() {
    [[ $# -ne 1 ]] && return 1
    url=`echo $1 | grep -P 'https?://[a-zA-Z.-]+/[a-zA-Z-]+/[a-zA-Z-]+' -o`
    [[ "${url}" == "" ]] && return 1
    git clone "$url" && cd "${url##*/}" || return 1
    [[ $TMUX ]] && tmux rename-window "#{b:pane_current_path}"
}

# Perform operation using fzf. Examples:
#   find /usr/include -name "test.h" F nvim
#   find /usr/lib -name "test.so.*" F readelf -h
if [[ -z "$TMUX" ]]; then
    alias -g F="| fzf --multi --cycle | tr '\n' '\0' | xargs --no-run-if-empty -0 sh -c '\$0 \"\$@\" </dev/tty' "
else
    alias -g F="| fzf-tmux --multi --tac | tr '\n' '\0' | xargs --no-run-if-empty -0 sh -c '\$0 \"\$@\" </dev/tty' "
fi

# Python
alias vs='source venv/bin/activate'
alias py3='python3'
alias venv='virtualenv venv --system-site-packages --python=/usr/bin/python3'

# Sequence that disables cursor blinking
alias stopblink="printf '\033[?12l'"
# }}}

# {{{ Functions

# Modprobe modules used by VirtualBox
modprobe_vb() {
    sudo modprobe vboxguest
    sudo modprobe vboxnetadp
    sudo modprobe vboxnetflt
}

mount_iso() {
    sudo mkdir -pv /mnt/iso/
    sudo mount -o loop $1 /mnt/iso/ 2>/dev/null
}

# Try to establish ssh connection for every second
sssh() {
  while true; do command ssh "$@"; [ $? -ne 255 ] && break || sleep 1; done
}
# }}}

# {{{ Keybindings
bindkey -e                        # Enable emacs-mode

autoload -Uz compinit && compinit # Command completion

bindkey '^[а'	emacs-forward-word
bindkey '^[и'	emacs-backward-word
bindkey '\ef'   emacs-forward-word
bindkey '\eb'   emacs-backward-word

# Ctrl+backspace to delete the previous word to slash
#
# References:
# + https://unix.stackexchange.com/questions/313806/zsh-make-altbackspace-stop-at-non-alphanumeric-characters
# + https://unix.stackexchange.com/questions/258656/how-can-i-delete-to-a-slash-or-a-word-in-zsh
backward-kill-dir () {
    local WORDCHARS=${WORDCHARS/\/}
    zle backward-kill-word
}
zle -N backward-kill-dir
bindkey '^H' backward-kill-dir

# Select file with fzf and open it in vim (saves the actual command to history).
vimfzf-widget() {
    local files
    files=$(fzf --cycle --multi < /dev/tty)
    [[ -z "$files" ]] && { zle reset-prompt; return; }
    local cmd="${EDITOR:-nvim} ${(f)files}"
    print -s "$cmd"
    BUFFER="$cmd"
    zle accept-line
}
zle -N vimfzf-widget
bindkey "\ep" vimfzf-widget
bindkey -s "\ev"  "^Qv .^J"                 # Open editor in current directory
bindkey -s '\C-x\C-d' '$(date +%Y-%m-%d)'
# }}}

# {{{ fzf
[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh

# {{{ Gruvbox color scheme (dynamic light/dark)
_gen_fzf_default_opts() {
  local mode=$(cat ~/.config/theme-mode 2>/dev/null || echo "dark")

  if [[ "$mode" == "light" ]]; then
    # Gruvbox Light
    local color_bg='#fbf1c7'
    local color_bg_plus='#ebdbb2'
    local color_fg='#3c3836'
    local color_fg_plus='#282828'
    local color_hl='#076678'      # blue
    local color_info='#b57614'    # yellow
    local color_prompt='#b57614'
    local color_pointer='#427b58' # cyan
    local color_marker='#427b58'
    local color_spinner='#427b58'
  else
    # Gruvbox Dark
    local color_bg='#32302f'
    local color_bg_plus='#3c3836'
    local color_fg='#bdae93'
    local color_fg_plus='#ebdbb2'
    local color_hl='#83a598'      # blue
    local color_info='#fabd2f'    # yellow
    local color_prompt='#fabd2f'
    local color_pointer='#8ec07c' # cyan
    local color_marker='#8ec07c'
    local color_spinner='#8ec07c'
  fi

  export FZF_DEFAULT_OPTS="
    --color=bg+:$color_bg_plus,bg:$color_bg,spinner:$color_spinner,hl:$color_hl
    --color=fg:$color_fg,header:$color_hl,info:$color_info,pointer:$color_pointer
    --color=marker:$color_marker,fg+:$color_fg_plus,prompt:$color_prompt,hl+:$color_hl
  "
}

_gen_fzf_default_opts
# }}}

export FZF_DEFAULT_OPTS=${FZF_DEFAULT_OPTS}" --bind alt-k:up,alt-j:down,alt-p:previous-history,alt-n:next-history,alt-m:accept,alt-q:cancel,esc:cancel"

if [[ "$(command -v fd)" ]]; then
    export FZF_DEFAULT_COMMAND='fd --type f --follow'
    export FZF_CTRL_T_COMMAND='fd --type file --follow'
fi

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
# }}}

# {{{ auto-notify plugin configuration
export AUTO_NOTIFY_THRESHOLD=600
export AUTO_NOTIFY_TITLE="%command: done with %exit_code"
export AUTO_NOTIFY_BODY="Elapsed time: %elapsed seconds"
export AUTO_NOTIFY_WHITELIST=("apt-get" "docker" "rsync" "scp" "cp" "mv" "rm" "git"
                              "cmake" "ocamlbuild" "make" "ninja" "dune"
                              "cabal"
                              "borg-linux64" "aria2" "frama-c"
                              "chk1" "cppcheck" "perf" "mprof" "svn" "opam" "sync-ebook.sh")
export AUTO_NOTIFY_IGNORE=("docker exec" "docker-compose")
export AUTO_NOTIFY_EXPIRE_TIME=2000
# }}}

# {{{ Show current directory in the X window title
function set-title-precmd() {
  printf "\e]2;%s\a" "${PWD/#$HOME/~} - zsh"
}
function set-title-preexec() {
  printf "\e]2;%s\a" "$1 - zsh"
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd set-title-precmd
add-zsh-hook preexec set-title-preexec
# }}}

# {{{ Utilities
# Shell commands usage statistics
function zsh_stats() {
	fc -l 1 | \
		awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | \
		grep -v "./" | column -c3 -s " " -t | sort -nr | nl | head -n20
}
# }}}

# Auto start X
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty2 ]]; then exec startx; fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

. "$HOME/.local/bin/env"

# vim:foldmethod=marker:foldenable:foldlevel=0:sw=4:tw=120
