#!/usr/bin/env bash
# Terminal settings

# Disables Software Flow Control (XON/XOFF flow control)
# i.e. "Ctrl s" and "Ctrl q" will have no special behavior.
# shellcheck disable=SC2094
if [ -n "$ZSH_VERSION" ]; then
	[[ $- == *i* ]] && stty -ixon <"$TTY" >"$TTY"
else
	[[ $- == *i* ]] && stty -ixon
fi
