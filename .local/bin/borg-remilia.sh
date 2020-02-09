#!/usr/bin/env bash
export BORG_BIN=/home/jubnzv/.local/bin/borg-linux64
export BORG_REPO=/media/jubnzv/10F9B9AE49B661FF/_backup/$(hostname)
export BORG_UNKNOWN_UNENCRYPTED_REPO_ACCESS_IS_OK=yes

info() { printf "\n%s %s\n\n" "$( date )" "$*" >&2; }
trap 'echo $( date ) Backup interrupted >&2; exit 2' INT TERM

info "Starting backup"

${BORG_BIN} create                  \
    --warning                       \
    --show-rc                       \
    --compression lz4               \
    --exclude-caches                \
    ::'{hostname}-{now}'            \
    /home/jubnzv/Work       \
    /home/jubnzv/Uni        \
    /home/jubnzv/Org        \
    /home/jubnzv/Dev        \
    /home/jubnzv/Documents  \
    /home/jubnzv/Pictures   \
    /home/jubnzv/dotfiles   \
    /home/jubnzv/Ops        \
    /home/jubnzv/VMs/Share/ \
    /home/jubnzv/VPN/       \
    /home/jubnzv/.config/   \
    /home/jubnzv/.gnupg/    \
    /home/jubnzv/.ssh/

backup_exit=$?

info "Pruning repository"

${BORG_BIN} prune                   \
    --list                          \
    --prefix '{hostname}-'          \
    --show-rc                       \
    --keep-daily    7               \
    --keep-weekly   4               \
    --keep-monthly  6               \

prune_exit=$?

global_exit=$(( backup_exit > prune_exit ? backup_exit : prune_exit ))

if [ ${global_exit} -eq 1 ];
then
    info "Backup and/or Prune finished with a warning"
fi

if [ ${global_exit} -gt 1 ];
then
    info "Backup and/or Prune finished with an error"
fi

exit ${global_exit}

