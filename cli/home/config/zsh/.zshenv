# $HOME/.zshenv: user .zshenv file for zsh(1).
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

# Minimal required variables.
export XDG_DATA_HOME=${XDG_DATA_HOME:=${HOME}/.local/share}
export DOTFILES=${DOTFILES:=${XDG_DATA_HOME}/dotfiles}
source "$DOTFILES/cli/shell/plugins/env.sh"

export ZDOTDIR=${ZDOTDIR:=${XDG_CONFIG_HOME}/zsh}

