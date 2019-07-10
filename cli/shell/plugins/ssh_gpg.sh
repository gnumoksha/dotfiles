#!/usr/bin/env bash
#|
#| Start gpg-agent
#|
# Although all GnuPG components try to start the gpg-agent as needed,
# this is not possible for the ssh support because ssh does not know about it.
# shellcheck disable=SC2181

# It is important to set the environment variable GPG_TTY in your login shell.
GPG_TTY=$(tty)
export GPG_TTY
# If you enabled the ssh agent support, you also need to tell ssh about it.
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
	SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
	export SSH_AUTH_SOCK
fi

# Note: in case the gpg-agent receives a signature request,
# the user might need to be prompted for a passphrase,
# which is necessary for decrypting the stored key.
# Since the  ssh-agent  protocol does  not  contain a mechanism for
# telling the agent on which display/terminal it is running, gpg-agent's
# ssh-support will use the TTY or X display where gpg-agent has been started.
# To switch this display to the current one, the following command may be used:
# gpg-connect-agent updatestartuptty /bye
result=$( (gpg-connect-agent --verbose updatestartuptty /bye) 2>&1)
if [[ $? -ne 0 ]]; then
	echo "Error starting GnuPG agent! Details: ${result}"
fi
unset result

alias gpg-agent-kill='gpgconf --kill gpg-agent'

#|
#| References
#|
# man gpg-agent
# https://www.gnupg.org/documentation/manuals/gnupg/
# https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/gpg-agent/gpg-agent.plugin.zsh

