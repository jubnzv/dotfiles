#!/usr/bin/env python3
import argparse
import datetime
import os
import json
import time
import sys


DATABASE_DIR=os.path.join(os.path.expanduser("~"), ".local", "share", "scripts")
DATABASE_FILE=str(os.path.splitext(os.path.basename(__file__))[0]) + ".json"
DATABASE_FPATH=os.path.join(DATABASE_DIR, DATABASE_FILE)
NOW=int(time.time())


def parse_args():
    parser = argparse.ArgumentParser(description='Script for delayed files deletion.')
    parser.add_argument('file', nargs='?',
                       help='file to remove')
    parser.add_argument('days', type=int, nargs='?',
                       help='number of days after which it will be deleted')
    parser.add_argument('-d', '--delete', dest='delete', action='store_true',
                       help='perform deletion')
    parser.add_argument('-c', '--cancel', dest='cancel', action='store_true',
                       help='cancel deletion for selected file')
    parser.add_argument('-p', '--print', dest='print', action='store_true',
                       help='print files from deletion list')
    return parser, parser.parse_args()


def print_files():
    if not os.path.exists(DATABASE_FPATH):
        print("Database %s does not exists!" % DATABASE_FPATH)
        return 127

    data = None
    with open(DATABASE_FPATH, 'r') as json_file:
        data = json.load(json_file)

    if len(data['files']) == 0:
        print("No files deletions wasn't planned.")
        return 0

    for f in data['files']:
        print("%s will be deleted after %d days" % (f['path'], (NOW-f['delete_time'])/(24*60*60)))
    return 0


def delete():
    if not os.path.exists(DATABASE_FPATH):
        print("Database %s does not exists!" % DATABASE_FPATH)
        return 127

    data = None
    with open(DATABASE_FPATH, 'r') as json_file:
        data = json.load(json_file)

    for f in data['files']:
        if not os.path.exists(f['path']):
            data['files'].remove(f)
            continue
        if f['delete_time'] < NOW:
            try:
                print('Remove %s' % f['path'])
                os.remove(f['path'])
            except FileNotFoundError:
                pass
            except PermissionError:
                print('%s: permission denied' % f['path'])
                pass
            data['files'].remove(f)

    with open(DATABASE_FPATH, 'w') as json_file:
        data = json.dump(data, json_file)

    return 0


def cancel(fpath):
    if not os.path.exists(DATABASE_FPATH):
        print("Database %s does not exists!" % DATABASE_FPATH)
        return 127

    data = None
    canceled_count = 0

    with open(DATABASE_FPATH, 'r') as json_file:
        data = json.load(json_file)

    for f in data['files']:
        if f['path'] == fpath:
            data['files'].remove(f)
            canceled_count += 1

    with open(DATABASE_FPATH, 'w') as json_file:
        data = json.dump(data, json_file)

    if canceled_count == 0:
        print('%s: not found in database' % fpath)
    else:
        print('%s: canceled %d delayed deletions' % (fpath, canceled_count))

    return 0


def init_db():
    data = {}
    data['files'] = []
    with open(DATABASE_FPATH, 'w') as json_file:
        json.dump(data, json_file)
    os.sync()


def add_file(fpath, days):

    abspath = os.path.abspath(fpath)

    if not os.path.exists(abspath):
        print("%s: not found" % abspath)
        return 127
    if days <= 0:
        print("Days number must be >= 0")
        return 22

    if not os.path.exists(DATABASE_FPATH):
        print("Initialize new database: %s" % DATABASE_FPATH)
        try:
            init_db()
        except Exception as e:
            print("Can't initialize database: %s" % e)
            return 127

    data = None
    with open(DATABASE_FPATH, 'r') as json_file:
        try:
            data = json.load(json_file)
        except json.decoder.JSONDecodeError:
            print('Database %s is broken!' % DATABASE_FPATH)
            return 1
    data['files'].append({
        'path': abspath,
        'delete_time': NOW + days*24*60*60
    })
    with open(DATABASE_FPATH, 'w') as json_file:
        json.dump(data, json_file)
    print("%s will be removed after %s" % (abspath, (datetime.date.today()+datetime.timedelta(days=days)).strftime("%Y-%m-%d")))
    return 0


if __name__ == '__main__':
    parser, args = parse_args()
    if not os.path.exists(DATABASE_DIR):
        os.makedirs(DATABASE_DIR)
    if args.print:
        sys.exit(print_files())
    if args.delete:
        sys.exit(delete())
    if args.cancel:
        if not args.file:
            print("File not specified!")
            print()
            parser.print_help()
        sys.exit(cancel(args.file))
    elif args.file and args.days:
        sys.exit(add_file(args.file, args.days))
    else:
        parser.print_help()
