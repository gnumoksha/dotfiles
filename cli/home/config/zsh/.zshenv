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

# In case ~/.profile was not read yet.
# This can happen in ssh sessions.
if [[ "$USER_PROFILE_LOADED" != "yes" ]]; then
    source ~/.profile
fi

export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"

