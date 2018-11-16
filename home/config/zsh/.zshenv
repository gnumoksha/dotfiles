# $ZDOTDIR/.zshenv: user .zshenv file for zsh(1).
#
# This file is sourced on all invocations of the shell.
# If the -f flag is present or if the NO_RCS option is
# set within this file, all other initialization files
# are skipped.
#
# This file should contain commands to set the command
# search path, plus other important environment variables.
# This file should not contain commands that produce
# output or assume the shell is attached to a tty.
#
# Global Order: zshenv, zprofile, zshrc, zlogin

export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:=${HOME}/.config}
export ZDOTDIR=${ZDOTDIR:=${XDG_CONFIG_HOME}/zsh}

source "$XDG_CONFIG_HOME/shell/common/vars.sh"

ZPLUG_INSTALLED='/usr/local/opt/zplug/installed'
ZPLUG_HOME='/usr/local/opt/zplug/home'
ZPLUG_BIN='/usr/local/bin'
ZPLUG_USE_CACHE=true
ZPLUG_CACHE_DIR="$XDG_CACHE_HOME/zplug"

