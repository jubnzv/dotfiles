#!/usr/bin/env python3
# Dotfiles installation script.
#
# Requirements: Debian 10 with Internet connection
# Installation process includes some interactive actions.
#
# Usage examples:
#  git clone https://github.com/jubnzv/dotfiles dotfiles
#  cd dotfiles && ./install.py --install-all
#
import argparse
import codecs
import os
import subprocess
import urllib

from typing import List


class C:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKGREEN = '\033[92m'
    WARN = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'

    MSG_OK = f"{OKGREEN}[OK  ]{ENDC}"
    MSG_FAIL = f"{FAIL}[FAIL]{ENDC}"


class Configuration:

    HOME = '/home/jubnzv'
    SCRIPT_PATH = os.path.dirname(os.path.abspath(__file__)) + '/'

    # Required packages from Debian repositories
    APT_PACKAGES = {
        'etckeeper', 'fasd', 'expect', 'lxappearance',
    }

    # Python packages that should be installed through pip --user
    PIP_PACKAGES = {
        'pdbpp', 'pre-commit', 'yolk', 'cmake_format'
    }

    # Rust packages that should be installed through cargo
    CARGO_PACKAGES = {
        'bat'
    }

    # Packages that should be installed in ~/.local/bin
    BIN_PACKAGES = {
        'borg'
    }

    # Scripts and utilities that should be cloned without build
    GIT_CLONE_PACKAGES = (
        {
            'name': 'zsh-completions',
            'url': 'https://github.com/jubnzv/zsh-completions',
            'branch': 'cppcheck-compdef',
            'dst': '~/.zsh/'
        },
        {
            'name': 'bat-gruvbox-theme',
            'url': 'https://github.com/Briles/gruvbox',
            'branch': 'master',
            'dst': '~/.config/bat/themes/',
        },
    )

    # List of dotfiles from this repo that would be installed
    DOTFILES = {
        '.Xdefaults':                                   '~/',
        '.asoundrc':                                    '~/',
        '.gitconfig':                                   '~/',
        '.ignore':                                      '~/',
        '.gitconfig.work':                              '~/',
        '.inputrc':                                     '~/',
        '.ctags':                                       '~/',
        '.icon/taskwarrior.png':                        '~/.icon/',
        '.icon/touchpad.png':                           '~/.icon/',
        '.icon/touchpad-disabled.png':                  '~/.icon/',
        '.latex/template-cyrillic.tex':                 '~/.latex/',
        '.latexmkrc':                                   '~/',
        '.xinitrc':                                     '~/',
        '.arbtt/categorize.cfg':                        '~/.arbtt/',
        '.config/bat/config':                           '~/.config/bat/',
        '.config/qt5ct/colors/oomox-gruvbox-dark.conf': '~/.config/qt5ct/colors/',
        '.config/dunst/dunstrc':                        '~/.config/dunst/',
        '.config/rofi/config':                          '~/.config/rofi/',
        '.config/rofi/gruvbox-jubnzv.rasi':             '~/.config/rofi/',
        '.config/zathura/zathurarc':                    '~/.config/zathura/',
        '.config/kitty/kitty.conf':                     '~/.config/kitty/',
        '.config/kitty/diff.conf':                      '~/.config/kitty/',
        '.taskrc':                                      '~/',
        '.config/taskwarrior/gruvbox-dark-256.theme':   '~/.config/taskwarrior/',
        '.tmux/session-finder/session-finder.bash':     '~/.tmux/session-finder/',
        '.tmux.conf':                                   '~/',
        '.gdbinit':                                     '~/',
        '.sshrc':                                       '~/',
        '.sshrc.d/target-info.sh':                      '~/.sshrc.d/',
        '.config/ranger/rc.conf':                       '~/.config/ranger/',
        '.config/ranger/rifle.conf':                    '~/.config/ranger/',
        '.config/ranger/commands.py':                   '~/.config/ranger/',

        # zsh
        '.zshrc':                                       '~/',
        '.zsh/dircolors':                               '~/.zsh/dircolors',

        # neovim
        '.config/nvim/init.vim':                  '~/.config/nvim/',
        '.config/nvim/clang-rename.py':           '~/.config/nvim/',
        '.config/nvim/settings.json':             '~/.config/nvim/',
        '.config/nvim/plugin/gitlink.vim':        '~/.config/nvim/plugin/',
        '.config/nvim/plugin/pasteimage.vim':     '~/.config/nvim/plugin/',
        '.config/nvim/after/ftplugin/c.vim':      '~/.config/nvim/after/ftplugin/',
        '.config/nvim/after/ftplugin/help.vim':   '~/.config/nvim/after/ftplugin/',

        '.config/nvim/UltiSnips/all.snippets':    '~/.config/nvim/UltiSnips/',
        '.config/nvim/UltiSnips/c.snippets':      '~/.config/nvim/UltiSnips/',
        '.config/nvim/UltiSnips/cpp.snippets':    '~/.config/nvim/UltiSnips/',
        '.config/nvim/UltiSnips/ocaml.snippets':  '~/.config/nvim/UltiSnips/',
        '.config/nvim/UltiSnips/python.snippets': '~/.config/nvim/UltiSnips/',
        '.config/nvim/UltiSnips/sh.snippets':     '~/.config/nvim/UltiSnips/',

        # i3wm
        '.config/i3/config':                  '~/.config/i3/',
        '.config/i3/i3lock-wrapper.sh':       '~/.config/i3/',
        '.config/i3/lock.sh':                 '~/.config/i3/',
        '.config/i3/raise-anki.py':           '~/.config/i3/',
        '.config/i3/rofi-notes.sh':           '~/.config/i3/',
        '.config/i3/setup-keys.sh':           '~/.config/i3/',
        '.config/i3/toggle-notifications.sh': '~/.config/i3/',
        '.config/i3/touchpad-toggle.sh':      '~/.config/i3/',
        '.config/i3/unset-urgent.sh':         '~/.config/i3/',

        # Polybar
        '.config/polybar/config':                   '~/.config/polybar/',
        '.config/polybar/launch.sh':                '~/.config/polybar/',
        '.config/polybar/notifications-status.sh':  '~/.config/polybar/',
        '.config/polybar/vpn-openvpn-isrunning.sh': '~/.config/polybar/',

        # Python
        '.pythonrc':                                  '~/',
        '.pdbrc':                                     '~/',
        '.pdbrc.py':                                  '~/',
        '.config/pip/pip.conf':                       '~/.config/pip',
        '.ipython/profile_default/ipython_config.py': '~/.ipython/profile_default/',

        # systemd
        '.config/systemd/user/arbtt.service':                                '~/.config/systemd/user/',
        '.config/systemd/user/bugwarrior-pull.service':                      '~/.config/systemd/user/',
        '.config/systemd/user/bugwarrior-pull.timer':                        '~/.config/systemd/user/',
        '.config/systemd/user/diff-notes.service':                           '~/.config/systemd/user/',
        '.config/systemd/user/diff-notes.timer':                             '~/.config/systemd/user/',
        '.config/systemd/user/diff-anki.service':                            '~/.config/systemd/user/',
        '.config/systemd/user/diff-anki.timer':                              '~/.config/systemd/user/',
        '.config/systemd/user/rsi_keylogger.service':                        '~/.config/systemd/user/',
        '.config/systemd/user/ssl-check.service':                            '~/.config/systemd/user/',
        '.config/systemd/user/ssl-check.timer':                              '~/.config/systemd/user/',
        '.config/systemd/user/taskwarrior-active-task-notification.service': '~/.config/systemd/user/',
        '.config/systemd/user/taskwarrior-active-task-notification.timer':   '~/.config/systemd/user/',
        '.config/systemd/user/taskwarrior-end-day.service':                  '~/.config/systemd/user/',
        '.config/systemd/user/taskwarrior-end-day.timer':                    '~/.config/systemd/user/',
        '.config/systemd/user/taskwarrior-has-tasks-notification.service':   '~/.config/systemd/user/',
        '.config/systemd/user/taskwarrior-has-tasks-notification.timer':     '~/.config/systemd/user/',
        '.config/systemd/user/taskwarrior-reporter-monthly.service':         '~/.config/systemd/user/',
        '.config/systemd/user/taskwarrior-reporter-monthly.timer':           '~/.config/systemd/user/',
        '.config/systemd/user/taskwarrior-reporter-weekly.service':          '~/.config/systemd/user/',
        '.config/systemd/user/taskwarrior-reporter-weekly.timer':            '~/.config/systemd/user/',

        # Scripts in $PATH
        '.local/bin/advice-libtool-version.py':      '~/.local/bin/',
        '.local/bin/agf':                            '~/.local/bin/',
        '.local/bin/ansible-clean':                  '~/.local/bin/',
        '.local/bin/backup-dir':                     '~/.local/bin/',
        '.local/bin/borg-remilia.sh':                '~/.local/bin/',
        '.local/bin/cmake-build':                    '~/.local/bin/',
        '.local/bin/cmake-clean':                    '~/.local/bin/',
        '.local/bin/cpdiff':                         '~/.local/bin/',
        '.local/bin/diff2html.py':                   '~/.local/bin/',
        '.local/bin/diff-notes.sh':                  '~/.local/bin/',
        '.local/bin/diff-anki.py':                   '~/.local/bin/',
        '.local/bin/envset.py':                      '~/.local/bin/',
        '.local/bin/fs-cleanup-documents.py':        '~/.local/bin/',
        '.local/bin/fs-cleanup-sources.sh':          '~/.local/bin/',
        '.local/bin/fs-fix-notes-index.sh':          '~/.local/bin/',
        '.local/bin/fs-sort-downloads.sh':           '~/.local/bin/',
        '.local/bin/fs-sort-pictures.py':            '~/.local/bin/',
        '.local/bin/fzf-tmux-session':               '~/.local/bin/',
        '.local/bin/gitignore-update':               '~/.local/bin/',
        '.local/bin/gitlog.sh':                      '~/.local/bin/',
        '.local/bin/kern-install-modules':           '~/.local/bin/',
        '.local/bin/languagetool-cli':               '~/.local/bin/',
        '.local/bin/lsd':                            '~/.local/bin/',
        '.local/bin/md2pdf':                         '~/.local/bin/',
        '.local/bin/poor-man-profiler':              '~/.local/bin/',
        '.local/bin/ps_mem.py':                      '~/.local/bin/',
        '.local/bin/ptop':                           '~/.local/bin/',
        '.local/bin/replace-symlinks':               '~/.local/bin/',
        '.local/bin/rm!':                            '~/.local/bin/',
        '.local/bin/scp-kitty':                      '~/.local/bin/',
        '.local/bin/scp-speed-test':                 '~/.local/bin/',
        '.local/bin/sshd-find-duplicate':            '~/.local/bin/',
        '.local/bin/ssh-speed-test.sh':              '~/.local/bin/',
        '.local/bin/ssl-checker':                    '~/.local/bin/',
        '.local/bin/sync-ebook.sh':                  '~/.local/bin/',
        '.local/bin/syscall-num':                    '~/.local/bin/',
        '.local/bin/task-resched-work.sh':           '~/.local/bin/',
        '.local/bin/unpack-all':                     '~/.local/bin/',
        '.local/bin/vimfzf':                         '~/.local/bin/',
        '.local/bin/wait_ssh':                       '~/.local/bin/',
        '.local/bin/taskwarrior-end-day':            '~/.local/bin/',
        '.local/bin/taskwarrior-notify-active-task': '~/.local/bin/',
        '.local/bin/taskwarrior-notify-has-tasks':   '~/.local/bin/',
        # Not public
        '.local/bin/chk1':                           '~/.local/bin/',

        #  '.surfing_keys.js': '~/',
    }

    def dotfiles(self):
        for src, dst in self.DOTFILES.items():
            fn = os.path.basename(src)
            s = (self.SCRIPT_PATH+src)
            d = os.path.normpath(os.path.expanduser(dst)+'/'+fn)
            yield s, d

    def git_clone_packages(self):
        for p in self.GIT_CLONE_PACKAGES:
            p['dst'] = os.path.normpath(os.path.expanduser(p['dst']))
            yield p

    def check_health_exn(self):
        for s, d in self.dotfiles():
            if not os.path.isfile(s):
                raise FileNotFoundError(s)
            if os.path.islink(d) and not os.path.exists(d):
                raise FileNotFoundError(f"{d}: found broken symlink!")


class Installer:

    # Configuration entry
    cfg = None

    def __init__(self, verbose=False):
        self.verbose = verbose
        self.cfg = Configuration()
        self.cfg.check_health_exn()

    def install_all(self):
        self.set_git_clone()
        self.set_symlinks()

    def set_git_clone(self):
        print("Cloning git repositories...")
        for p in self.cfg.git_clone_packages():
            self._run_cmd(['mkdir', '-p', p['dst']])
            dst_dir = os.path.normpath(os.path.expanduser(
                f"{p['dst']}/{p['url'].split('/')[-1]}"))
            if os.path.exists(dst_dir):
                git_dir = os.path.join(dst_dir, '.git')
                git_cmd = [
                    'git', f'--git-dir={git_dir}', f"--work-tree={p['dst']}"]
                if os.path.exists(git_dir):
                    branch = self._run_cmd(
                        git_cmd + ['rev-parse', '--abbrev-ref', 'HEAD']).splitlines()[0]
                    if branch != p['branch']:
                        print(f"{p['name']}: reset to origin/{p['branch']} ...")
                        if not self._run_cmd(
                                git_cmd + ['reset', '--hard', 'origin/' + p['branch']]):
                            print(
                                f"{C.MSG_FAIL} {p['name']}: failed to reset to origin/{p['branch']}!")
                            return False
                    print(f"{C.MSG_OK} {p['name']}")
                    continue
                else:
                    print(f"{C.MSG_FAIL} {git_dir}: not found! Purging...")
                    self._run_cmd(['rm', '-rf', dst_dir])
            print(f"{p['url']} → {dst_dir} ...")
            self._run_cmd(['git', 'clone', '--single-branch',
                           '--branch', p['branch'], p['url'], dst_dir])

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
    parser.add_argument("-A", "--install-all",
                        help="Perform complete installation",
                        action="store_true")
    parser.add_argument("-s", "--set-symlinks",
                        help="Setup symlinks",
                        action="store_true")
    return parser.parse_args()


if __name__ == '__main__':
    args = get_args()

    i = Installer(args.verbose)
    if args.install_all:
        i.install_all()
    if args.set_symlinks:
        i.set_symlinks()
