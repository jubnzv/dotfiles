#!/usr/bin/env python3
#
# Advice correct libtool version info.
#
# Reference:
# https://www.gnu.org/software/libtool/manual/html_node/Updating-version-info.html
#
import sys
import re


def print_usage(argv0):
    print("%s <current version number>" % argv0)
    print("Example: %s 0:3:4" % argv0)


def main(version_numbers):
    current = int(version_numbers[0])
    revision = int(version_numbers[1])
    age = int(version_numbers[2])
    current_updated = False

    if input("The library source code has changed at all [y/N]: ") in ("y", "Y"):
        revision += 1
    if input("Any interfaces have been added [y/N]: ") in ("y", "Y"):
        age += 1
        current += 1
        current_updated = True
    if input("Any interfaces have been removed or changed [y/N]: ") in ("y", "Y"):
        age = 0
        if not current_updated:
            current += 1

    print("New version: %d:%d:%d" % (current, revision, age))


if __name__ == '__main__':
    if len(sys.argv) != 2:
        print_usage(sys.argv[0])
        exit(1)
    if sys.argv[1] in ('help', '--help', '-h'):
        print_usage(sys.argv[0])
        exit(0)

    match = re.match(r"([0-9]+):([0-9]+):([0-9]+)", sys.argv[1])
    version_numbers = match.groups()
    if len(version_numbers) != 3:
        print_usage(sys.argv[0])
        exit(0)
    sys.exit(main(version_numbers))
