#!/bin/bash

urls=(
    'https://raw.githubusercontent.com/dracula/gedit/master/dracula.xml'
)

styles_dir="$HOME/.local/share/gedit/styles/"
WGET=$(which wget)

mkdir -p "$styles_dir"
cd "$styles_dir"

for url in ${urls[@]}; do
    echo "Downloading $url."

    $WGET "$url"
done

