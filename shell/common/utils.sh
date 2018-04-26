# Which shell do user is running?
if [ -n "$ZSH_VERSION" ]; then
	my_shell_type='zsh'
elif [ -n "$BASH_VERSION" ]; then
	my_shell_type='zsh'
else
	my_shell_type='unknow'
fi

if [[ $my_shell_type == 'unknow' ]]; then
	echo "Only bash and zsh are supported. Something may go wrong."
	exit 1
fi

# my_aliases will get all defined aliases
# #FIXME my_aliases[ls] does not work
if [[ $my_shell_type == 'zsh' ]]; then
	my_aliases=("${aliases[@]}")
else
	my_aliases=("${BASH_ALIASES[@]}")
fi

#EOF
