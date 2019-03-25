#
# SSH and GPG utils
#

# https://www.gnupg.org/documentation/manuals/gnupg/

export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"

result=$((gpg-connect-agent updatestartuptty /bye) 2>&1)
if [[ $? -ne 0 ]]; then
	echo "Error starting GnuPG agent! Details: ${result}"
fi
unset result

alias gpg-agent-kill='gpgconf --kill gpg-agent'

#https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/gpg-agent/gpg-agent.plugin.zsh

#EOF
