#
# Define the most common
# environment variables
#########################

export DOTFILES=${DOTFILES:=${HOME}/.dotfiles}
export DOTFILES_SHELL_PLUGINS=${DOTFILES_SHELL_PLUGINS:=${DOTFILES}/cli/shell/plugins}
hash -d DOTFILES="$DOTFILES"
#shopt -s cdable_vars
#setopt cdablevars

#
# Terminal settings
#
# Disables Software Flow Control (XON/XOFF flow control)
# i.e. "Ctrl s" and "Ctrl q" will have no special behavior.
stty -ixon

#
# XDG
#
# https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:=${HOME}/.config} # user-specific configuration files
export XDG_CACHE_HOME=${XDG_CACHE_HOME:=${HOME}/.cache} # user-specific non-essential (cached) data
export XDG_DATA_HOME=${XDG_DATA_HOME:=${HOME}/.local/share} # user-specific data files
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
# Golang
#
# GOPATH environment variable specifies the location of your workspace.
export GOPATH="$XDG_DATA_HOME/golang/workspace"
# Set the GOBIN path to generate a binary file when go install is run.
export GOBIN="$GOPATH/bin"
# If go is not in /usr/local/go, specify where it is.
export GOROOT=/usr/lib/go-1.9
PATH="$PATH:$GOROOT/bin:$GOBIN"

#
# PHP
#
# Composer
PATH="$PATH:$HOME/.config/composer/vendor/bin"

#
# Python
#
PATH="$PATH:$HOME/.local/bin"

#
# Rust-lang
#
export CARGO_HOME="$XDG_CONFIG_HOME/cargo"
# TODO apt uses /usr/lib/cargo/bin
[ -d /usr/lib/cargo/bin ] && PATH="$PATH:/usr/lib/cargo/bin"

#
# PATH
#
# root stuff
PATH="$PATH:/usr/local/sbin:/usr/sbin:/sbin"
# finally export the path
export PATH


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
