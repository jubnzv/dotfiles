#!/usr/bin/env python3
# Rename files which have unportable symbols in names.
import os
import sys

DOC_PATH = os.path.expanduser("~/Documents")
RENAME_PAIRS = {
    ':': '_',
    '?': ' ',
    '`': '_',
    "'": '_',
    "|": '_',
    ",": '_',
}
DOC_EXTS = ("doc", "pdf", "djvu")
EXCLUDING_EXTS = (".html")
EXCLUDING_DIRS = ("websites", "html", "images")

def do_rename(name: str, subdir: str):
    name_new = name
    for k,v in RENAME_PAIRS.items():
        if k in name:
            name_new = name_new.replace(k, v)
    if name.startswith('.') and len(name) > 1 and (any([e in name for e in DOC_EXTS])):
        name_new = name[1:]
    if name_new == name:
        return

    print(os.path.join(subdir, name) + " -> " + os.path.join(subdir, name_new))
    os.rename(os.path.join(subdir, name), os.path.join(subdir, name_new))

def rename():
    if not os.path.isdir(DOC_PATH):
        print('%s: not found' % DOC_PATH)
        return 127
    for subdir, dirs, files in os.walk(DOC_PATH):
        for d in filter(lambda n: not any([e in os.path.join(subdir, n) for e in EXCLUDING_DIRS]), dirs):
            do_rename(d, subdir)
        for f in filter(lambda n: not any([e in os.path.join(subdir, n) for e in EXCLUDING_DIRS]), files):
            if any([f.endswith(e) for e in EXCLUDING_EXTS]):
                continue
            do_rename(f, subdir)

if __name__ == '__main__':
    sys.exit(rename())


