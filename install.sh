#!/usr/bin/env bash

export STOW="$(which stow) --verbose=0"
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:=${HOME}/.config}

scripts=(
'cli/install-home.sh'
'cli/install-etc.sh'
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

mkdir -p "$XDG_CACHE_HOME"/vim/{undo,swap,backup} 2>/dev/null
mkdir -p "$XDG_CACHE_HOME"/nvim/{undo,swap,backup} 2>/dev/null

echo "Finished."

