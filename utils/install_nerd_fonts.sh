#!/bin/bash

install_path=~/.local/share/fonts/nerd-fonts/knack

echo "Installing nerd fonts"

mkdir -p "$install_path"

echo "Installing Knack (Hack) font"

wget -c -q https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Regular/complete/Knack%20Regular%20Nerd%20Font%20Complete.ttf -O $install_path/"Knack Regular Nerd Font Complete.ttf"

wget -c -q https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Regular/complete/Knack%20Regular%20Nerd%20Font%20Complete%20Mono.ttf -O $install_path/"Knack Regular Nerd Font Complete Mono.ttf"

fc-cache
mkfontscale $install_path
mkfontdir $install_path

echo "Done. Restart the programs."

