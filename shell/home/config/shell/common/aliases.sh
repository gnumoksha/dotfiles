#
# Define shell aliases
#######################

alias la='ls -la'

# Coloring everything!
# ls: directory '_name' must come over before 'name'
# https://stackoverflow.com/a/18451819
#alias ls='LANG=C.UTF-8 ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ip='ip --color'
# Be careful and stay safe :)
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
alias g="git"
alias follow='multitail -p l '
alias follow2="less -S +F"
alias follow_monolog='multitail -p l -cS squid '
alias greperrors="grep -i 'warning\|error\|alert\|critical'"
# see https://github.com/wfxr/forgit#custom-options
alias git-add="ga"
alias git-log="glo"
alias git-diff="gd"
alias git-checkout="gcf"
alias git-clean="gclan"
alias git-ignore="git"

