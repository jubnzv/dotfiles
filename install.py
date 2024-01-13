#!/usr/bin/env python3
#
# Creates symlinks for dotfiles located in this directory to their original
# locations in $HOME.
#

import os


IGNORED_DIRS = [".git", "assets"]
IGNORED_FILES = ["README.md", "install.py", "tags"]


def is_same_symlink(src, dst):
    return os.path.islink(dst) and os.readlink(dst) == src


def main():
    script_dir = os.path.dirname(os.path.abspath(__file__))
    for root, dirs, files in os.walk(script_dir):
        dirs[:] = [d for d in dirs if d not in IGNORED_DIRS]
        for name in files + dirs:
            if name in IGNORED_FILES:
                continue
            src_path = os.path.join(root, name)
            relative_path = os.path.relpath(src_path, script_dir)
            dst_path = os.path.join(os.environ['HOME'], relative_path)
            if os.path.exists(dst_path):
                if os.path.isdir(dst_path):
                    print(f"Directory exists, skipping: {dst_path}")
                    continue
                if is_same_symlink(src_path, dst_path):
                    print(f"Symlink already exists and is correct: {dst_path}")
                    continue
                print(f"Removed: {dst_path}")
                os.remove(dst_path)
            os.symlink(src_path, dst_path)
            print(f"Symlink created: {dst_path} -> {src_path}")

    return os.EX_OK


if __name__ == '__main__':
    exit(main())
