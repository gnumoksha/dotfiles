#!/usr/bin/env bash
#
# Stuff related to
# GNU/Linux containers
#######################
# depends on: aliases_functions.sh

export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
export MINIKUBE_HOME="$XDG_DATA_HOME"/minikube
# https://github.com/kubernetes/kubernetes/issues/56402
export KUBECONFIG="$XDG_CONFIG_HOME"/kubernetes/config

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
alias dcompose-tail='docker compose logs --tail=5 -f'
# show only hardware interfaces
alias ifconfig='ls /sys/class/net | egrep -v "^(lo[0-9]?|sit[0-9]|ce[0-9]?|docker[0-9]?|br[-a-z0-9]{13})$" | xargs --max-args=1 /sbin/ifconfig'
alias docker-ps='docker ps --format "table {{.ID}}\t{{.Image}}\t{{.Status}}\t{{.Names}}"'

#alias docker-get-image-version="docker image inspect --format '{{ index .Config.Labels \"version\" }}'"
