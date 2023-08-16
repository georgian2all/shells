#!/bin/bash
# Removes old revisions of snaps
# CLOSE ALL SNAPS BEFORE RUNNING THIS
# https://www.linuxuprising.com/2019/04/how-to-remove-old-snap-versions-to-free.html
set -eu

LANG=en_US.UTF-8 snap list --all | awk '/disabled/{print $1, $3}' |
    while read snapname revision; do
        snap remove "$snapname" --revision="$revision"
    done

echo "Cleanup all old logs"

find /var/log -type f -name "*.gz" -exec rm -f {} \;

echo "Empty journalctl"


journalctl --vacuum-time=10d

apt autoclean
apt autoremove

docker system prune --volumes
