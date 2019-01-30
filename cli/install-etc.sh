#!/usr/bin/env bash
# This script is responsible to install
# all cli-related stuff into /etc

if [[ -z "$STOW" ]]; then
	echo "You need to set STOW variable"
	exit 1
fi

if [ ! -z "$BASH_SOURCE" ]; then FILE="${BASH_SOURCE[0]}"; else FILE="$0"; fi
CURRENT_DIR=$(exec 2>/dev/null;cd -- $(dirname "$FILE"); unset PWD; /usr/bin/pwd || /bin/pwd || pwd)

apt_files() {
	APT_ITEMS=(preferences.d sources.list sources.list.d)
	for item in "${APT_ITEMS[@]}"; do
		sudo rm "/etc/apt/$item"
		sudo ln -s "$CURRENT_DIR/etc/apt/$item" "/etc/apt/$item"
	done
}

echo "Do you want to install apt files?"
select apt_files in "Yes" "No"; do
	if [[ $apt_files == 'Yes' ]]; then
		apt_files
	fi
	echo
	break
done
echo

