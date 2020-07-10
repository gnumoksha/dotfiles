#!/usr/bin/env bash
#
# Stuff related to
# GNU/Linux containers
#######################
# depends on: aliases_functions.sh

#
# Snapcraft
#
# Do not show snap directories (squashfs) and also
# do not show overlay/tmpfs/udev because I usually don't want it.
alias_append df '-x squashfs -x overlay -x tmpfs -x devtmpfs'
# remove devices 7 (i.e. loop. See code running `cat /proc/devices`)
alias_append lsblk '--exclude 7 --fs'


#
# Docker
#
alias dcompose='docker-compose'
alias dcompose_tail='docker-compose logs --tail=5 -f'
# I do not want to remove volumes automatically
alias docker-prune="docker container prune -f && docker image prune -a -f"
# show only hardware interfaces
alias ifconfig='ls /sys/class/net | egrep -v "^(lo[0-9]?|sit[0-9]|ce[0-9]?|docker[0-9]?|br[-a-z0-9]{13})$" | xargs --max-args=1 /sbin/ifconfig'

#alias docker-get-image-version="docker image inspect --format '{{ index .Config.Labels \"version\" }}'"

