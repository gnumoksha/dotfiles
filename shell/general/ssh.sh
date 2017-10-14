# http://superuser.com/questions/247564/is-there-a-way-for-one-ssh-config-file-to-include-another-one
# http://www.linuxsysadmintutorials.com/multiple-ssh-client-configuration-files/

function ssh_build_conf () {
	if ls ~/.ssh/*.config 1> /dev/null 2>&1; then
		rm -f ~/.ssh/config 2>/dev/null
		for arquivo_ssh in $(ls ~/.ssh/*.config); do
			echo "processing $arquivo_ssh"
			cat $arquivo_ssh >> ~/.ssh/config
		done
	fi

	echo "done."
}

function ssh_add_wrapper() {
	ssh-add ~/.ssh/id_rsa-2048
	ssh-add ~/.ssh/id_rsa-git
}

#EOF
