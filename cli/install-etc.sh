#!/usr/bin/env bash
# This script is responsible to install all cli-related stuff into /etc
set -euo pipefail
export IFS=$'\n\t'

if [[ $(id -u) != 0 ]]; then
	echo "Note: execute as root in order to install stuff under /etc"
	return 0
fi

apt_files() {
	echo "Installing /etc/apt files"
	APT_ITEMS=(preferences.d sources.list sources.list.d)
	for item in "${APT_ITEMS[@]}"; do
		sudo rm "/etc/apt/$item"
		sudo ln -s "$INSTALLATION_DIR/cli/etc/apt/$item" "/etc/apt/$item"
	done
}

echo "Do you want to install apt files?"
select apt_files in "Yes" "No"; do
	if [[ $apt_files == 'Yes' ]]; then
		apt_files
	fi
	break
done

