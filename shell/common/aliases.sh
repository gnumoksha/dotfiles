
# Coloring everything!
# directory '_name' must come over before 'name'
# https://stackoverflow.com/a/18451819
alias ls='LANG=C.UTF-8 ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ip='ip --color'

# me from future: be careful and stay safe :)
alias rm='rm --interactive'
alias cp="cp --interactive"
alias mv="mv --interactive"

# Nice format :)
alias dmesg="dmesg --color --ctime --decode"
alias dmesg_useful="dmesg --level=notice,warn,err,crit,alert,emerg"
alias dmesg_critical="dmesg --level=crit,alert,emerg"

# Git in english
# https://githowto.com/aliases
#alias git='LANG=en_US.UTF-8 git'

alias dd="dd status=progress"

alias dck='docker'
alias dcompose='docker-compose'
# I do not want to remove volumes automatically
alias docker-clean="docker container prune -f && docker image prune -a -f"

alias g="git"

# show only hardware interfaces
alias ifconfig='ls /sys/class/net | egrep -v "^(lo[0-9]?|sit[0-9]|ce[0-9]?|docker[0-9]?|br[-a-z0-9]{13})$" | xargs --max-args=1 /sbin/ifconfig'

alias follow='multitail -p l '
alias follow2="less -S +F"
alias follow_monolog='multitail -p l -cS squid '

alias greperrors="grep -i 'warning\|error\|alert\|critical'"


#EOF
