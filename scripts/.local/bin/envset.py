#!/usr/bin/env python3
#
# Script to spawn new shells with modified environment variables.
#
import io
import os.path
import click
import subprocess
import yaml

from typing import Dict

SHARE_PATH = os.path.expanduser("~/.local/share/envset")
DEFAULT_NAME = "_current.yaml"

def set_env(env: Dict):
    for k, v in env.items():
        os.environ[str(k)] = str(v)

def get_env(fpath) -> Dict:
    env = dict()
    with open(fpath, 'r') as f:
        env = yaml.safe_load(f)
    return env

def restore_default():
    def_path = f'{SHARE_PATH}/{DEFAULT_NAME}'
    if not os.path.exists(def_path):
        return
    env = get_env(def_path)
    os.unlink(def_path)

@click.command('set', short_help='Set environment variables.')
@click.argument('filename')
@click.pass_context
def cli_set(ctx, filename):
    if not filename.endswith('.yaml'):
        filename += '.yaml'
    path = f'{SHARE_PATH}/{filename}'
    if not os.path.exists(path):
        if ctx.obj['verbose']:
            click.echo(f'{filename} doesn\'t exists!', err=True)
            return

    # Restore old env if it exists.
    def_path = f'{SHARE_PATH}/{DEFAULT_NAME}'
    restore_default()

    new_env = get_env(path)

    # Save existsing env
    env_default = {k: "" for k in new_env.keys()}
    with io.open(def_path, 'w', encoding='utf8') as fdef:
        yaml.dump(env_default, fdef, default_flow_style=False, allow_unicode=True)

    # Set new env
    set_env(new_env)
    if ctx.obj['verbose']:
        for k, v in new_env.items():
            click.echo(f'{k}={v}')

    # Fork a new shell with modified env
    shell = os.getenv("SHELL")
    if not shell:
        shell = "bash"
    os.system(shell)

@click.command('edit', short_help='Edit environment configuration file.')
@click.argument('filename')
@click.pass_context
def cli_edit(ctx, filename):
    if not filename:
        return
    default_content = "# Write environment variables in following format:\n# EDITOR: nvim\n\n"
    editor = os.getenv("EDITOR")
    if not editor:
        editor = "vim"
    if not filename.endswith('.yaml'):
        filename += '.yaml'
    path = f'{SHARE_PATH}/{filename}'
    print(ctx.obj['verbose'])
    if not os.path.exists(path):
        with open(path, 'w') as f:
            f.write(default_content)
        subprocess.call([editor, '+3', path])
        with open(path, 'r') as f:
            if f.read() == default_content:
                os.unlink(path)
    else:
        subprocess.call([editor, path])

@click.group(invoke_without_command=True, chain=True)
@click.option('-v', '--verbose', is_flag=True, help='Enables verbose mode.')
@click.option('--help', '-h', is_flag=True, default=None, help="Show this message then exit.")
@click.pass_context
def cli(ctx, verbose, help):
    ctx.ensure_object(dict)
    ctx.obj['verbose'] = verbose
    if ctx.invoked_subcommand is None:
        click.echo(ctx.get_help())
        ctx.exit()
cli.add_command(cli_set)
cli.add_command(cli_edit)

if __name__ == "__main__":
    if not os.path.exists(SHARE_PATH):
        os.makedirs(SHARE_PATH)
    cli()
