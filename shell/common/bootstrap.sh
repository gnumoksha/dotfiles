if [ -n "$BASH_SOURCE" ]; then
	current_dir=$(dirname $BASH_SOURCE)
else
	current_dir=$(dirname $0)
fi

#source $current_dir/utils.sh
source $current_dir/path.sh
source $current_dir/vars.sh
source $current_dir/aliases.sh
source $current_dir/aws.sh
source $current_dir/colors.sh
source $current_dir/misc.sh
source $current_dir/ssh.sh

#EOF
