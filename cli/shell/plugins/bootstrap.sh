if [ -n "$BASH_SOURCE" ]; then
	current_dir=$(dirname $BASH_SOURCE)
else
	current_dir=$(dirname $0)
fi

source $current_dir/settings.sh
source $current_dir/aliases_functions.sh
source $current_dir/colors.sh
source $current_dir/ssh_gpg.sh
source $current_dir/containers.sh
source $current_dir/fzf.sh
source $current_dir/jupyter.sh

#EOF
