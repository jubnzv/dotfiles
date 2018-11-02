########
dotfiles
########

.. class:: no-web

  .. image:: https://raw.githubusercontent.com/jubnzv/dotfiles/master/screenshot.png
      :alt: Screenshot
      :scale: 50%
      :align: center

.. contents::

Hardware
========

* ThinkPad X230 (i5-3230M / 16 GiB DDR3-1600 RAM / WDC WDS500G2B0A 500 GB SSD)
  with `classic keyboard <http://www.thinkwiki.org/wiki/Install_Classic_Keyboard_on_xx30_Series_ThinkPads>`_.

* ThinkPad X200 (Core 2 Duo P8600 / 2 GiB DDR3-1066 RAM / 160 GB SSD); `libreboot <https://libreboot.org/docs/hardware/x200.html>`_ installed.

General
=======

* Distro: Debian 10

* Text editor: :code:`neovim`

* File manager: :code:`ranger`

* Web-browser: :code:`chromium` with `CVim <https://github.com/1995eaton/chromium-vim>`_ plugin

* Mail / RSS client: :code:`thunderbird`

* JetBrains IDE's with :code:`ideavim` and :code:`AceJump` plugins

+------------------------------------------+---------------------+
|                               File types |         Application |
+------------------------------------------+---------------------+
|               :code:`.pdf` :code:`.djvu` |     :code:`zathura` |
+------------------------------------------+---------------------+
| :code:`.fb2` :code:`.epub` :code:`.mobi` |    :code:`FBReader` |
+------------------------------------------+---------------------+
|                              :code:`.mm` |       :code:`XMind` |
+------------------------------------------+---------------------+
|                                    audio |        :code:`cmus` |
+------------------------------------------+---------------------+
|                                    video |         :code:`mpv` |
+------------------------------------------+---------------------+
|                                   images |      :code:`mirage` |
+------------------------------------------+---------------------+
|                                   office | :code:`libreoffice` |
+------------------------------------------+---------------------+

Desktop environment
===================

+ :code:`i3` window manager

  * Status: `i3-status-rust <https://github.com/greshake/i3status-rust>`_
  * Application launcher: :code:`rofi`
  * Notification daemon: :code:`dunst`
  * Keymap indicator: :code:`fbxkb`
  * Automount daemon and tray icon: :code:`udiskie`

+ Fonts

  * WM: :code:`Proto Sans` and :code:`Font Awesome`
  * GUI applications: :code:`IBM Plex Sans Text`
  * Terminal: :code:`Fantasque Sans Mono` with `NerdFont <https://github.com/ryanoasis/nerd-fonts>`_ patch

+ GTK theme: :code:`numix`
+ Cursors and icons: :code:`Breeze`
+ Colors: :code:`gruvbox dark` where it possible

CLI tools
=========

* Shell: :code:`fish`
* Terminal multiplexer: :code:`tmux`
* Terminal emulator: :code:`rxvt-unicode-256color`
* `fzf <https://github.com/junegunn/fzf>`_
* `sshrc <https://github.com/Russell91/sshrc>`_ script
* `buku <https://github.com/jarun/Buku>`_ bookmark manager
* Replacements and wrappers for default utilities

+-------------------+--------------------------------------------------------------+
|           Default |                                                  Alternative |
+-------------------+--------------------------------------------------------------+
|        :code:`ls` |                        `exa <https://github.com/ogham/exa>`_ |
+-------------------+--------------------------------------------------------------+
|      :code:`find` |                        `fd <https://github.com/sharkdp/fd>`_ |
+-------------------+--------------------------------------------------------------+
|       :code:`cat` |                      `bat <https://github.com/sharkdp/bat>`_ |
+-------------------+--------------------------------------------------------------+
|      :code:`grep` |          `ripgrep <https://github.com/BurntSushi/ripgrep/>`_ |
+-------------------+--------------------------------------------------------------+
|      :code:`ping` |     `prettyping <https://github.com/denilsonsa/prettyping>`_ |
+-------------------+--------------------------------------------------------------+
|  :code:`git diff` | `diff-so-fancy <https://github.com/so-fancy/diff-so-fancy>`_ |
+-------------------+--------------------------------------------------------------+

Organizer & PIM
===============

* :code:`taskwarrior` workflow

  * Notifications for tasks tagged as :code:`notify` with libnotify calls
  * `Integration <https://github.com/jubnzv/dotfiles/blob/master/.config/i3/config>`_ with i3 for quick access to most used functions
  * `Daemon <https://github.com/jubnzv/go-taskwarrior/tree/master/examples/agenda-report>`_ that sends customized task reports inside local mailbox
  * Awesome `bugwarrior <https://github.com/ralphbean/bugwarrior>`_ script to
    fetch and structurize assigned issues from number of services
  * Convenient aliases in `fish <https://github.com/jubnzv/dotfiles/tree/master/.config/fish>`_ and :code:`.taskrc`

* `riv.vim <https://github.com/gu-fan/riv.vim>`_ for notekeeping

