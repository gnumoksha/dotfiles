#
# SSH and GPG utils
#

export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"
cmd_gpg_connect=$(gpg-connect-agent updatestartuptty /bye)
if [[ $? -ne 0 ]]; then
	echo "Error! $cmd_gpg_connect"
fi

#EOF
