# dotfiles

![Screenshot](https://raw.githubusercontent.com/jubnzv/dotfiles/master/screenshot.png)

## Hardware

* ThinkPad X200 (Core 2 Duo P8600 / 2 GiB DDR3-1066 RAM / 160 GB SSD); [libreboot](https://libreboot.org/docs/hardware/x200.html) installed.

* ThinkPad X230 (i5-3230M / 16 GiB DDR3-1600 RAM / WDC WDS500G2B0A 500 GB SSD) with [classic keyboard](http://www.thinkwiki.org/wiki/Install_Classic_Keyboard_on_xx30_Series_ThinkPads).

## General tools

| Purpose              | Tool        |
|----------------------|-------------|
| Text editor          | neovim      |
| File manager         | nnn         |
| Web-browser          | firefox     |
| Mail / RSS client    | thunderbird |
| Document viewer      | zathura     |
| Diagramming          | draw.io     |
| Mindmapping          | XMind       |
| Music playback       | cmus        |
| Video playback       | mpv         |
| Image viewer         | mirage      |
| Shell                | zsh         |
| Terminal multiplexer | tmux        |
| Terminal emulator    | kitty       |

## Desktop environment

+ `i3` window manager

  * Status: `i3-status-rust`
  * Application launcher: `rofi`
  * Notification daemon: `dunst`
  * Keymap indicator: `fbxkb`
  * Automount daemon and tray icon: `udiskie`
  * Screen locker: `i3lock`

+ Fonts

  * Terminal: `Iosevka Term` with [NerdFont](https://github.com/ryanoasis/nerd-fonts) patch
  * X applications: `IBM Plex Sans Text`
  * i3wm: `Proto Sans` and `Font Awesome`

+ GTK theme: `numix`
+ Cursors and icons: `Breeze`
+ Colors: `gruvbox dark` where it possible

## Organizer & PIM

* `taskwarrior` workflow:

  * Send libnotify notifications for tasks tagged with `+notify` tag;
  * [Integration](https://github.com/jubnzv/dotfiles/blob/master/.config/i3/config) with i3 for quick access to most used functions;
  * [Daemon](https://github.com/jubnzv/go-taskwarrior/tree/master/examples/agenda-report) that sends customized task reports inside local mailbox every morning;
  * [bugwarrior](https://github.com/ralphbean/bugwarrior) script to fetch and save locally issues from external bugtrackers;
  * Convenient aliases in [zsh](https://github.com/jubnzv/dotfiles/tree/master/.zshrc) and `.taskrc`.

