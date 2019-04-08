#!/usr/bin/python3
"""
Enumerate/rename pictures in subfolders of ~/Images
"""

import re
import os

IMAGES_PATH = '/home/jubnzv/Pictures/'
EXCLUDING= ['Screenshots', '282828_500x500.png']

def get_next_index(path):
    index_is_free = lambda i,fl: True if i not in [f.split('.')[0] for f in fl] else False

    index = 0
    pat = re.compile(r'^\d{8}\.[png|jpg|jpeg|gif]$')
    ls = [f for f in os.listdir(path)]
    f = filter(lambda i: re.findall(pat, i), ls)

    while True:
        if index_is_free(index, f):
            yield str(int(index) + 1).zfill(8)
        index += 1

if __name__ == '__main__':
    images_path = os.path.realpath(IMAGES_PATH)
    for subdir, dirs, files in os.walk(images_path):
        dirs[:] = [d for d in dirs if d not in EXCLUDING]
        gen = get_next_index(subdir)
        for f in files:
            old_file_path = os.path.join(subdir, f)
            new_file_path = old_file_path.replace(f, next(gen) + '.' + f.split('.')[-1])
            print(old_file_path + " -> " + new_file_path)
            os.rename(old_file_path, new_file_path)
