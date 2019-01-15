#
# Shell Environment
####################

export DOTFILES="$HOME/.dotfiles"

#
# Terminal settings
#
# Disables Software Flow Control (XON/XOFF flow control)
# i.e. "Ctrl s" and "Ctrl q" will have no special behavior.
stty -ixon

#
# XDG
#
# https://specifications.freedesktop.org/basedir-spec/basedir-spec-0.6.html
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:=${HOME}/.config}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:=${HOME}/.cache}
export XDG_DATA_HOME=${XDG_DATA_HOME:=${HOME}/.local/share}
export VIMINIT=":source $XDG_CONFIG_HOME/vim/vimrc"

#
# System-related variables
#
# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi
#export PAGER=most
# https://github.com/rkitover/vimpager
#export PAGER=/opt/apps/vimpager/vimpager
#alias less=$PAGER
#alias zless=$PAGER
export PAGER=less
export LESS='-g -i -M -R -S -w -z-4'

#
# Related to programming languages
#
# For Golang
# GOPATH environment variable specifies the location of your workspace.
export GOPATH="$XDG_DATA_HOME/golang/ws"
# Set the GOBIN path to generate a binary file when go install is run.
export GOBIN="$GOPATH/bin"
# If go is not in /usr/local/go, specify where it is.
export GOROOT=/usr/lib/go-1.9
# For rust-lang
export CARGO_HOME="$XDG_CONFIG_HOME/cargo"
# TODO apt uses /usr/lib/cargo/bin

#
# PATH
#
# PHP composer
PATH="$PATH:$HOME/.config/composer/vendor/bin"
# Python
PATH="$PATH:$HOME/.local/bin"
# Golang
PATH="$PATH:$GOROOT/bin:$GOBIN"
[ -d /usr/lib/cargo/bin ] && PATH="$PATH:/usr/lib/cargo/bin"
export PATH
# root stuff
PATH="$PATH:/usr/local/sbin:/usr/sbin:/sbin"

#
# Aliases
#
# Coloring everything!
# ls: directory '_name' must come over before 'name'
# https://stackoverflow.com/a/18451819
alias ls='LANG=C.UTF-8 ls --color=auto'
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

#
# For Tilix.
#
if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
  if [ ! -e /etc/profile.d/vte.sh ]; then
    echo "You need to symlink vte.sh. Type sudo password:"
    sudo ln -s /etc/profile.d/vte-2.91.sh /etc/profile.d/vte.sh
  fi
  source /etc/profile.d/vte.sh
fi

#EOF
