#!/usr/bin/env python3
# Dotfiles installation script.
#
# Requirements: Debian 10 with Internet connection
# Installation process includes some interactive actions.
#
# Usage:
#  git clone https://github.com/jubnzv/dotfiles dotfiles
#  cd dotfiles && ./install.py -s
#
import argparse
import codecs
import os
import subprocess

from typing import List


class Configuration:

    HOME = '/home/jubnzv'
    SCRIPT_PATH = os.path.dirname(os.path.abspath(__file__)) + '/'

    # Required packages from Debian repositories
    APT_PACKAGES = {
        'etckeeper', 'fasd', 'expect', 'lxappearance',
    }

    # Python packages that should be installed through pip --user
    PIP_PACKAGES = {
        'pdbpp', 'pre-commit', 'yolk'
    }

    # Rust packages that should be installed through cargo
    CARGO_PACKAGES = {
        'bat'
    }

    # Packages that should be installed in ~/.local/bin
    BIN_PACKAGES = {
        'borg'
    }

    # List of dotfiles from this repo that would be installed
    DOTFILES = {
        '.Xdefaults': '~/',
        '.asoundrc': '~/',
        '.gitconfig': '~/',
        '.inputrc': '~/',
        '.ctags': '~/',
        '.icon/taskwarrior.png': '~/.icon/',
        '.icon/touchpad.png': '~/.icon/',
        '.icon/touchpad-disabled.png': '~/.icon/',
        '.latex/template-cyrillic.tex': '~/.latex/',
        '.latexmkrc': '~/',
        '.xinitrc': '~/',
        '.arbtt/categorize.cfg': '~/.arbtt/',
        '.config/bat/config': '~/.config/bat/',
        '.config/qt5ct/colors/oomox-gruvbox-dark.conf': '~/.config/qt5ct/colors/',
        '.config/dunst/dunstrc': '~/.config/dunst/',
        '.config/rofi/config': '~/.config/rofi/',
        '.config/rofi/gruvbox-jubnzv.rasi': '~/.config/rofi/',
        '.config/zathura/zathurarc': '~/.config/zathura/',
        '.config/kitty/kitty.conf': '~/.config/kitty/',
        '.taskrc': '~/',
        '.config/taskwarrior/gruvbox-dark-256.theme': '~/.config/taskwarrior/',
        '.tmux/session-finder/session-finder.bash': '~/.tmux/session-finder/',
        '.tmux.conf': '~/',
        '.gdbinit': '~/',
        '.sshrc': '~/',
        '.sshrc.d/target-info.sh': '~/.sshrc.d/',
        '.zshrc': '~/',
        '.zsh/dircolors': '~/.zsh/dircolors',

        # neovim
        '.config/nvim/init.vim': '~/.config/nvim/',
        '.config/nvim/settings.json': '~/.config/nvim/',
        '.config/nvim/plugin/gitlink.vim': '~/.config/nvim/plugin/',
        '.config/nvim/plugin/pasteimage.vim': '~/.config/nvim/plugin/',
        '.config/nvim/after/ftplugin/c.vim': '~/.config/nvim/after/ftplugin/',
        '.config/nvim/after/ftplugin/help.vim': '~/.config/nvim/after/ftplugin/',
        '.config/nvim/snippets/neosnippet/cmake.snip': '~/.config/nvim/snippets/neosnippet/',
        '.config/nvim/snippets/neosnippet/cpp.snip': '~/.config/nvim/snippets/neosnippet/',
        '.config/nvim/snippets/neosnippet/c.snip': '~/.config/nvim/snippets/neosnippet/',
        '.config/nvim/snippets/neosnippet/dockerfile.snip': '~/.config/nvim/snippets/neosnippet/',
        '.config/nvim/snippets/neosnippet/markdown.snip': '~/.config/nvim/snippets/neosnippet/',
        '.config/nvim/snippets/neosnippet/plantuml.snip': '~/.config/nvim/snippets/neosnippet/',
        '.config/nvim/snippets/neosnippet/python.snip': '~/.config/nvim/snippets/neosnippet/',
        '.config/nvim/snippets/neosnippet/rust.snip': '~/.config/nvim/snippets/neosnippet/',
        '.config/nvim/snippets/neosnippet/sh.snip': '~/.config/nvim/snippets/neosnippet/',
        '.config/nvim/snippets/neosnippet/_.snip': '~/.config/nvim/snippets/neosnippet/',
        '.config/nvim/snippets/neosnippet/tex.snip': '~/.config/nvim/snippets/neosnippet/',
        '.config/nvim/snippets/ultisnips/c.snippets': '~/.config/nvim/snippets/ultisnips/',
        '.config/nvim/snippets/ultisnips/sh.snippets': '~/.config/nvim/snippets/ultisnips/',

        # i3wm
        '.config/i3/config': '~/.config/i3/',
        '.config/i3/i3lock-wrapper.sh': '~/.config/i3/',
        '.config/i3/lock.sh': '~/.config/i3/',
        '.config/i3/raise-anki.py': '~/.config/i3/',
        '.config/i3/rofi-notes.sh': '~/.config/i3/',
        '.config/i3/setup-keys.sh': '~/.config/i3/',
        '.config/i3/toggle-notifications.sh': '~/.config/i3/',
        '.config/i3/touchpad-toggle.sh': '~/.config/i3/',
        '.config/i3/unset-urgent.sh': '~/.config/i3/',

        # Polybar
        '.config/polybar/config': '~/.config/polybar/',
        '.config/polybar/launch.sh': '~/.config/polybar/',
        '.config/polybar/notifications-status.sh': '~/.config/polybar/',
        '.config/polybar/vpn-openvpn-isrunning.sh': '~/.config/polybar/',

        # Python
        '.pythonrc': '~/',
        '.pdbrc': '~/',
        '.pdbrc.py': '~/',
        '.config/pip/pip.conf': '~/.config/pip',
        '.ipython/profile_default/ipython_config.py': '~/.ipython/profile_default/',

        # systemd
        '.config/systemd/user/arbtt.service': '~/.config/systemd/user/',
        '.config/systemd/user/bugwarrior-pull.service': '~/.config/systemd/user/',
        '.config/systemd/user/bugwarrior-pull.timer': '~/.config/systemd/user/',
        '.config/systemd/user/diff-notes.service': '~/.config/systemd/user/',
        '.config/systemd/user/diff-notes.timer': '~/.config/systemd/user/',
        '.config/systemd/user/rsi_keylogger.service': '~/.config/systemd/user/',
        '.config/systemd/user/ssl-check.service': '~/.config/systemd/user/',
        '.config/systemd/user/ssl-check.timer': '~/.config/systemd/user/',
        '.config/systemd/user/taskwarrior-active-task-notification.service': '~/.config/systemd/user/',
        '.config/systemd/user/taskwarrior-active-task-notification.timer': '~/.config/systemd/user/',
        '.config/systemd/user/taskwarrior-end-day.service': '~/.config/systemd/user/',
        '.config/systemd/user/taskwarrior-end-day.timer': '~/.config/systemd/user/',
        '.config/systemd/user/taskwarrior-has-tasks-notification.service': '~/.config/systemd/user/',
        '.config/systemd/user/taskwarrior-has-tasks-notification.timer': '~/.config/systemd/user/',
        '.config/systemd/user/taskwarrior-reporter-monthly.service': '~/.config/systemd/user/',
        '.config/systemd/user/taskwarrior-reporter-monthly.timer': '~/.config/systemd/user/',
        '.config/systemd/user/taskwarrior-reporter-weekly.service': '~/.config/systemd/user/',
        '.config/systemd/user/taskwarrior-reporter-weekly.timer': '~/.config/systemd/user/',

        # Scripts in $PATH
        '.local/bin/advice-libtool-version.py': '~/.local/bin/',
        '.local/bin/agf': '~/.local/bin/',
        '.local/bin/ansible-clean': '~/.local/bin/',
        '.local/bin/backup-dir': '~/.local/bin/',
        '.local/bin/borg-remilia.sh': '~/.local/bin/',
        '.local/bin/cmake-build': '~/.local/bin/',
        '.local/bin/cmake-clean': '~/.local/bin/',
        '.local/bin/cpdiff': '~/.local/bin/',
        '.local/bin/diff2html.py': '~/.local/bin/',
        '.local/bin/diff-notes.sh': '~/.local/bin/',
        '.local/bin/envset.py': '~/.local/bin/',
        '.local/bin/fs-cleanup-documents.py': '~/.local/bin/',
        '.local/bin/fs-cleanup-sources.sh': '~/.local/bin/',
        '.local/bin/fs-fix-notes-index.sh': '~/.local/bin/',
        '.local/bin/fs-sort-downloads.sh': '~/.local/bin/',
        '.local/bin/fs-sort-pictures.py': '~/.local/bin/',
        '.local/bin/fzf-tmux-session': '~/.local/bin/',
        '.local/bin/gitignore-update': '~/.local/bin/',
        '.local/bin/gitlog.sh': '~/.local/bin/',
        '.local/bin/kern-install-modules': '~/.local/bin/',
        '.local/bin/languagetool-cli': '~/.local/bin/',
        '.local/bin/lsd': '~/.local/bin/',
        '.local/bin/md2pdf': '~/.local/bin/',
        '.local/bin/poor-man-profiler': '~/.local/bin/',
        '.local/bin/ps_mem.py': '~/.local/bin/',
        '.local/bin/ptop': '~/.local/bin/',
        '.local/bin/replace-symlinks': '~/.local/bin/',
        '.local/bin/rm!': '~/.local/bin/',
        '.local/bin/scp-kitty': '~/.local/bin/',
        '.local/bin/scp-speed-test': '~/.local/bin/',
        '.local/bin/sshd-find-duplicate': '~/.local/bin/',
        '.local/bin/ssh-speed-test.sh': '~/.local/bin/',
        '.local/bin/ssl-checker': '~/.local/bin/',
        '.local/bin/sync-ebook.sh': '~/.local/bin/',
        '.local/bin/syscall-num': '~/.local/bin/',
        '.local/bin/task-resched-work.sh': '~/.local/bin/',
        '.local/bin/unpack-all': '~/.local/bin/',
        '.local/bin/vimfzf': '~/.local/bin/',
        '.local/bin/wait_ssh': '~/.local/bin/',
        '.local/bin/taskwarrior-end-day': '~/.local/bin/',
        '.local/bin/taskwarrior-notify-active-task': '~/.local/bin/',
        '.local/bin/taskwarrior-notify-has-tasks': '~/.local/bin/',
        # Not public
        '.local/bin/chk1': '~/.local/bin/',

        #  '.surfing_keys.js': '~/',
    }

    def dotfiles(self):
        for src, dst in self.DOTFILES.items():
            fn = os.path.basename(src)
            s = (self.SCRIPT_PATH+src)
            d = os.path.normpath(os.path.expanduser(dst)+'/'+fn)
            yield s, d

    def check_health_exn(self):
        for s, _ in self.dotfiles():
            if not os.path.isfile(s):
                raise FileNotFoundError(s)


class Installer:

    # Configuration entry
    cfg = None

    def __init__(self, verbose=False):
        self.verbose = verbose
        self.cfg = Configuration()
        self.cfg.check_health_exn()

    def set_symlinks(self):
        print("Setup symlinks...")
        for src, dst in self.cfg.dotfiles():
            self._set_link(src, dst)

    def _set_link(self, src: str, dst: str):
        dst_dir = os.path.dirname(dst)
        self._run_cmd(['mkdir', '-p', dst_dir])
        self._run_cmd(['ln', '-s', '-f', src, dst], p=self.verbose)

    def _run_cmd(self, cmd: List[str], encoding='utf-8', p=False):
        if not cmd:
            return None
        if p:
            print(f'+ {" ".join(cmd)}')
        p = subprocess.Popen(cmd,
                             stdout=subprocess.PIPE,
                             stderr=subprocess.PIPE)
        out, err = p.communicate()
        if (p.returncode != 0) or (err != b""):
            if encoding:
                err = codecs.decode(err, encoding, errors="ignore")
            return None
        if encoding:
            out = codecs.decode(out, encoding, errors="ignore")
        out = out.rstrip()
        out += '\n'
        return out


def get_args():
    parser = argparse.ArgumentParser()
    parser.add_argument("-v", "--verbose",
                        help="Enable additional output in stdout",
                        action="store_true", default=False)
    parser.add_argument("-s", "--set-symlinks",
                        help="Setup symlinks",
                        action="store_true")
    return parser.parse_args()


if __name__ == '__main__':
    args = get_args()

    i = Installer(args.verbose)
    if args.set_symlinks:
        i.set_symlinks()
