#!/bin/bash

if [[ "$(whoami)" != "root" ]]; then
	echo "Execute this script as root."
	exit 1
fi

grep 'PUBKEY:' sources.list.d/* | while read -r line; do
	key=$(echo $line | sed 's/.*PUBKEY: \([a-zA-Z0-9]*\).*/\1/')
	
	if [[ -z "$key" ]]; then
		echo "Key not found in \"$line\""
		continue
	fi

	echo "Adding $key..."
	apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys $key
	echo ""
	echo ""
done

exit 0
