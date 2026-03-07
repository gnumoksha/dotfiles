#!/usr/bin/env bash
# Terminal settings
# shellcheck disable=SC1091

#
# Disables Software Flow Control (XON/XOFF flow control)
# i.e. "Ctrl s" and "Ctrl q" will have no special behavior.
[[ $- == *i* ]] && stty -ixon <$TTY >$TTY
