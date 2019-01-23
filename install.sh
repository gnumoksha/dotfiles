#!/usr/bin/env bash

export STOW="$(which stow) --verbose=0"
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:=${HOME}/.config}

scripts=(
'cli/install-home.sh'
'gui/install-home.sh'
)

for script in "${scripts[@]}"; do
	./"$script"
	ret=$?
	
	if [[ $ret -ne 0 ]]; then
		exit $ret
	fi
done

unset STOW
echo "Finished."

