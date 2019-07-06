![](https://raw.githubusercontent.com/jubnzv/dotfiles/master/screenshot.png)

Desktop environment
-------------------

### Software

-   **i3** - tiling window manager
    -   **[i3status-rust](https://github.com/greshake/i3status-rust/commits/master)** -
        very resourcefriendly and feature-rich replacement for i3status
    -   **i3lock** - screen locker
    -   **rofi** - a window switcher, application launcher and dmenu
        replacement
    -   **dunst** - lightweight and customizable notification daemon
    -   **fbxkb** - keymap tray icon
    -   **udiskie** - automount daemon and tray icon

### GUI options

-   Fonts
    -   **Iosevka Term** with
        [NerdFont](https://github.com/ryanoasis/nerd-fonts) patch in
        terminal
    -   **IBM Plex Sans Text** in GUI applications
    -   **Proto Sans** and **Font Awesome** in window manager
-   **numix** GTK theme
-   **Breeze** icons and cursors
-   **gruvbox dark medium** colorscheme everywhere

Tools
-----

### CLI

-   **neovim** - text editor.
-   **zsh** - shell
    -   [zce.zsh](https://github.com/hchbaw/zce.zsh) -
        EasyMotion/ace-jump-mode
    -   [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) -
        fish-like autosuggestions for zsh
    -   [shrink-path-plugin](https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/shrink-path/shrink-path.plugin.zsh) -
        shrink directory paths, e.g. /home/me/foo/bar/quux -\>
        \~/f/b/quux
    -   [zsh-autopair](https://github.com/hlissner/zsh-autopair) -
        auto-close and delete matching delimiters in zsh
    -   [z.zsh](https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins/z) -
        jump-around plugin
-   **tmux** - terminal multiplexer
    -   [tmux-resurrect](https://github.com/tmux-plugins/tmux-resurrect) -
        persists tmux environment across system restarts
-   **ranger** - a VIM-inspired filemanager for the console
-   **wicd-curses** - curses-based network controller
-   **taskwarrior** - open-source, cross platform time and task
    management tool
-   [bugwarrior](https://github.com/ralphbean/bugwarrior) - Python
    script to pull github, bitbucket, and trac issues into taskwarrior
-   **cmus** - small, fast and powerful console music player
-   **nmap** - network security scanner and mapper for exploration and
    security auditing
-   **universal-ctags** - maintained ctags implementation
-   **coreutils** - GNU core utilities for basic file, shell and text
    manipulation
-   **findutils** - GNU basic directory searching utilities that
    provides find, locate and xargs
-   **fzf** - general-purpose fuzzy finder that can be used among other
    Unix tools
-   **htop** - interactive text-based system monitor, process viewer and
    process manager
-   **docker** - (CLI) tool that to interact with the docker service
-   **git** - version control system for tracking changes in files and
    coordinating the work
-   **ag** - faster grep replacement
-   **bat** - a cat clone with additional features like git integration
    and syntax highlighting
-   **python**
    -   **ipython** - a powerful interactive Python shell

### GUI

-   **kitty** - cross-platform, fast, feature full, GPU based terminal
    emulator
-   **firefox** - web-browser
    -   [Surfingkeys](https://github.com/brookhong/Surfingkeys) -
        extension that provides keyboard-based navigation and control of
        the web in the spirit of the VIM editor
    -   [AdNauseam](https://github.com/dhowe/AdNauseam) - lightweight
        adblocker
-   **thunderbird** - feature-rich (bloated) mail and RSS client
-   **zathura** - document viewer with VIM-like keybindings
-   **mpv** - minimalistic fork of mplayer2 and MPlayer
-   **mirage** - simple GTK+ image viewer
-   **keepassxc** - cross-platform community-driven port of the Windows
    application "Keepass Password Safe"
-   **mattermost-desktop** - electron-based client for mattermost -
    self-hosted slack alternative
-   **Telegram** - telegram desktop client
-   **libreoffice** - free office suite.
-   **GIMP** - a cross-platform image editor
-   **lxappearance** - small GTK+ theme switcher from LXDE
-   **arandr** - a simple visual front end for XRandR
-   **anki** - [spaced
    repetition](https://www.gwern.net/Spaced-repetition) software

### Organizer

-   **taskwarrior** workflow
    -   libnotify and email notifications for tagged tasks implemented
        with systemd services. Some examples could be found
        [here](https://github.com/jubnzv/go-taskwarrior/tree/master/examples/agenda-report).
    -   Script to list tasks in current context with `rofi`. For
        terminal I have fzf alternative in my [zsh
        config](https://github.com/jubnzv/dotfiles/blob/master/.zshrc).
    -   Daemon that sends customized reports inside my mailbox
    -   [bugwarrior](https://github.com/ralphbean/bugwarrior) to fetch
        and save locally issues from external bugtrackers: redmine,
        gitlab, github
    -   Convenient aliases in zsh and `.taskrc`
