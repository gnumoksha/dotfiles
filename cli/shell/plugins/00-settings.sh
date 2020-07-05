#!/usr/bin/env bash
# Terminal settings
# shellcheck disable=SC1091

#
# Disables Software Flow Control (XON/XOFF flow control)
# i.e. "Ctrl s" and "Ctrl q" will have no special behavior.
[[ $- == *i*  ]] && stty -ixon

#
# For Tilix.
#
if [ "$TILIX_ID" ] && [ "$VTE_VERSION" ]; then
  if [ ! -e /etc/profile.d/vte.sh ]; then
    echo "You need to symlink vte.sh. Type sudo password:"
    sudo ln -s /etc/profile.d/vte-2.91.sh /etc/profile.d/vte.sh
  fi
  source /etc/profile.d/vte.sh
fi

# Remove terminal borders
#if [ "$TERM" = "xterm-256color" ]; then
  #xprop \
    #-id $(xdotool getactivewindow) \
    #-f _MOTIF_WM_HINTS 32c \
    #-set _MOTIF_WM_HINTS "0x2, 0x0, 0x0, 0x0, 0x0"
#fi

# setup the command-not-found package
if [[ -x /usr/lib/command-not-found ]] ; then
  export COMMAND_NOT_FOUND_INSTALL_PROMPT=1

  if [[ -n "$ZSH_VERSION" ]]; then
    # The following code was adapted from /etc/zsh_command_not_found
    # present on Debian:
    if (( ! ${+functions[command_not_found_handler]} )) ; then
      function command_not_found_handler {
        [[ -x /usr/lib/command-not-found ]] || return 1
        /usr/lib/command-not-found -- ${1+"$1"} && :
      }
    fi
  fi
fi

