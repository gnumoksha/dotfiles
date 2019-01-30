#
# Stuff related to
# GNU/Linux containers
#######################
# depends on: aliases_functions.sh

#
# Snapcraft
#
# Do not show snap directories
alias_append df '-x squashfs'

#
# Docker
#
alias dck='docker'
alias dcompose='docker-compose'
# I do not want to remove volumes automatically
alias docker-clean="docker container prune -f && docker image prune -a -f"
# show only hardware interfaces
alias ifconfig='ls /sys/class/net | egrep -v "^(lo[0-9]?|sit[0-9]|ce[0-9]?|docker[0-9]?|br[-a-z0-9]{13})$" | xargs --max-args=1 /sbin/ifconfig'

