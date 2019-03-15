if [[ -z "$XDG_CONFIG_HOME" ]]; then
	>&2 echo "XDG_CONFIG_HOME is not defined! Plugins will not be loaded!"
	exit 1
fi

if [ -n "$BASH_SOURCE" ]; then
	current_dir=$(dirname $BASH_SOURCE)
else
	current_dir=$(dirname $0)
fi

source $current_dir/settings.sh
source $current_dir/aliases_functions.sh
source $current_dir/colors.sh
source $current_dir/containers.sh
source $current_dir/fzf.sh

# dot not to this for the root user
if [[ $(id -u) != 0 ]]; then
	source $current_dir/ssh_gpg.sh
	source $current_dir/jupyter.sh
fi

#EOF
