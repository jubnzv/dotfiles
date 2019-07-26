#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# Convert snippet file for neosnippet into snippet files for yasnippet.
#
# Credentials: Akihiro Uchida, https://gist.github.com/uchida/1965345
#
# This is modified python3 version that supports convertion from
# multiple snippet files and have some additional features.
#
# TODO:
# + handle _.snip snippets.
#
# Usage: ./neosnippet-to-yas.py ~/.config/nvim/snippets/ -o ~/.emacs.d/snippets/ --overwrite
#
import argparse
import os.path
import textwrap

YASNIPPET_TEMPLATE = """# -*- mode: snippet -*-
# name: {name}
# key: {key}
# --
{definition}
"""

class SnippetParser(object):
    def __init__(self):
        self.items = []
        self.item = {}
        self.snippet = ''
        return

    def feed(self, snip_file):
        for line in snip_file:
            if line.startswith('snippet'):
                if 'name' in self.item:
                    self.add_snippet()
                self.item['name'] = "".join(line.lstrip('snippet').strip())
                self.item['key'] = "".join(line.lstrip('snippet').strip())
            elif line.startswith('alias'):
                self.item['key'] = "".join(line.lstrip('alias').strip())
                continue
            elif line.startswith(('#', 'abbr', 'prev_word', 'options')):
                continue
            else:
                contents = line
                for s in ['snippet', ' ' * 4]:
                    if line.startswith(s):
                        contents = line.lstrip(s)
                self.snippet += contents
        return

    def add_snippet(self):
        self.snippet = self.snippet.rstrip('\n')
        for paren in ('\\{', '\\}'):
            self.snippet = self.snippet.replace(paren, paren.strip("\\"))
        self.item['definition'] = textwrap.dedent(self.snippet)
        self.items.append(self.item)
        self.snippet = ''
        self.item = {}
        return

    def finish(self):
        if 'name' in self.item:
            self.add_snippet()
        self.snippet = ''
        self.item = {}
        return self.items

def check_dir(outdir):
    if not os.path.exists(outdir):
        msg = '{} does not exist.'.format(outdir)
        raise argparse.ArgumentTypeError(msg)
    elif not os.path.isdir(outdir):
        msg = '{} is not a directory.'.format(outdir)
        raise argparse.ArgumentTypeError(msg)
    return outdir

if __name__ == '__main__':
    description = 'convert snippet file for neosnippet into snippet files for yasnippet'
    arg_parser = argparse.ArgumentParser(description=description)
    arg_parser.add_argument('indir', type=check_dir,
                            help='a neosnippet snippets directory')
    arg_parser.add_argument('--overwrite', action='store_true',
                            help='overwrite yasnippet files')
    arg_parser.add_argument('-o', '--outdir', required=True, type=check_dir,
                            help='output directory for yasnippet')
    args = arg_parser.parse_args()
    # Parse neosnippet files
    snip_parser = SnippetParser()
    for infile in os.listdir(args.indir):
        if not infile.endswith('.snip'):
            continue
        with open(os.path.join(args.indir, infile), 'r') as f:
            snip_parser.feed(f)
            items = snip_parser.finish()
            f.close()
        # Write yasnippet snippet files
        for item in items:
            outdir = infile[:-5] + '-mode'
            outdir = os.path.join(args.outdir, outdir)
            if not os.path.exists(outdir):
                os.makedirs(outdir)
            fpath = os.path.join(outdir, item['name'])
            if os.path.exists(fpath) and not args.overwrite:
                overwrite_warn = "file {} already exists. overwrite? "
                res = input(overwrite_warn.format(fpath))
                if res.lower() not in ('y', 'yes'):
                    continue
            print(fpath)
            with open(fpath, 'w') as f:
                f.write(YASNIPPET_TEMPLATE.format(**item))
