# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# Please, note that if this script fails to execute then GDM will not
# load the session.

# https://www.debian.org/doc/manuals/debian-reference/ch07.en.html#_starting_the_x_window_system
# https://en.wikipedia.org/wiki/Unix_shell#Configuration_files

# Falling back just in case systemd variables were not read.
if [[ -z "${XDG_CONFIG_HOME:-}" || -z "${DOTFILES:-}" ]]; then
  XDG_CONFIG_HOME="${HOME}/.config"

  # if the file exists, load and export all variables within it.
  if [[ -e ${XDG_CONFIG_HOME}/environment.d/envvars.conf ]]; then
    set -a
    . ${XDG_CONFIG_HOME}/environment.d/envvars.conf
    set +a
  fi
fi

# Create a shortcut to my dotfiles.
hash -d DOTFILES="${DOTFILES}"

# EDITOR contains the command to run the lightweight program used for editing
#   files.
# VISUAL contains command to run the full-fledged editor that is used for more
#   demanding tasks, such as editing email (e.g., vi, vim, emacs etc).
# BROWSER contains the path to the web browser.
if [ -n "${DISPLAY:-}" ]; then
  export EDITOR=vim
  export VISUAL=gvim
  #export BROWSER=firefox
else
  export EDITOR=vim
  export VISUAL=vim
  #export BROWSER=links
fi

# Add root stuff into the PATH
PATH="$PATH:/usr/local/sbin:/usr/sbin:/sbin"

#
# Golang
#
# GOPATH environment variable specifies the location of your workspace.
export GOPATH="${XDG_DATA_HOME}/golang/workspace"
# Set the GOBIN path to generate a binary file when go install is run.
export GOBIN="$GOPATH/bin"
# If go is not in /usr/local/go, specify where it is.
export GOROOT=/usr/lib/go-1.9
PATH="$PATH:$GOROOT/bin:$GOBIN"

#
# PHP
#
export COMPOSER_HOME="$XDG_CONFIG_HOME/composer" # this is the default.
export COMPOSER_CACHE_DIR="${XDG_CACHE_HOME}/composer" # this is the default.
PATH="$PATH:$COMPOSER_HOME/vendor/bin"

#
# Python
#
PATH="$PATH:${HOME}/.local/bin"

#
# Rust-lang
#
# https://doc.rust-lang.org/cargo/reference/environment-variables.html
export CARGO_HOME="${XDG_DATA_HOME}/cargo" # contains cache e config
PATH="$PATH:$CARGO_HOME/bin"
[ -d /usr/lib/cargo/bin ] && PATH="$PATH:/usr/lib/cargo/bin" # used by apt

# finally export the path
export PATH

# if running bash
if [ -n "$BASH_VERSION" ]; then
	# include .bashrc if it exists
	if [ -f "${HOME}/.bashrc" ]; then
		. "$HOME/.bashrc"
	fi
fi

# Create a named temporary directory for my personal use.
[[ ! -d /tmp/t ]] && mkdir /tmp/t

if [[ $(id -u) == 0 ]]; then
  # From Debian's /root/.profile
  if [ "$BASH" ]; then
    if [ -f ~/.bashrc ]; then
      . ~/.bashrc
    fi
  fi
  mesg n || true
fi

#This is used in order to later check if this file was loaded.
export USER_PROFILE_LOADED="yes"

#EOF
