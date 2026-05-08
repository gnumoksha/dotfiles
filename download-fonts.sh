#!/usr/bin/env bash

DESTINATION_PATH=${XDG_DATA_HOME:=${HOME}/.local/share}/fonts

URLS=(
	'https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Meslo.zip'
	'https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Hack.zip'
	'https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/DejaVuSansMono.zip'
	'https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/DroidSansMono.zip'
	'https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/FiraCode.zip'
	'https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/FiraMono.zip'
	'https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Inconsolata.zip'
	'https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Ubuntu.zip'
	'https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/UbuntuMono.zip'
	'https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/SourceCodePro.zip'
	'https://github.com/adobe-fonts/source-code-pro/releases/download/variable-fonts/SourceCodeVariable-Italic.otf'
	'https://github.com/adobe-fonts/source-code-pro/releases/download/variable-fonts/SourceCodeVariable-Italic.ttf'
	'https://github.com/adobe-fonts/source-code-pro/releases/download/variable-fonts/SourceCodeVariable-Roman.otf'
	'https://github.com/adobe-fonts/source-code-pro/releases/download/variable-fonts/SourceCodeVariable-Roman.ttf'
	'https://github.com/powerline/fonts/raw/master/DroidSansMonoSlashed/Droid%20Sans%20Mono%20Slashed%20for%20Powerline.ttf'
)

if [[ ! -d "$DESTINATION_PATH" ]]; then
	mkdir "$DESTINATION_PATH"
fi

pushd "$DESTINATION_PATH" || exit

for url in "${URLS[@]}"; do
	filename=$(basename "${url}")
	extension="${filename##*.}"

	echo "Downloading $filename from $url"
	wget -q "$url" -O "$DESTINATION_PATH/$filename"
	if [[ "$extension" == "zip" ]]; then
		unzip -o "$DESTINATION_PATH/$filename" -d "$DESTINATION_PATH"
		rm "$DESTINATION_PATH/$filename"
	fi
	echo
done
rm -f "$DESTINATION_PATH"/LICEN*
rm -f "$DESTINATION_PATH"/*.txt
rm -f "$DESTINATION_PATH"/*.md

popd || exit

echo
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/JetBrains/JetBrainsMono/master/install_manual.sh)"
echo

# @see https://wiki.archlinux.org/index.php/Fonts#Manual_installation
fc-cache -f -v
#mkfontscale "${DESTINATION_PATH}"
#mkfontdir "${DESTINATION_PATH}"
