# dotfiles
![Build Status](https://github.com/gnumoksha/dotfiles/actions/workflows/tests.yml/badge.svg)
[![Continuous integration status](https://github.com/gnumoksha/dotfiles/workflows/Tests/badge.svg)](https://github.com/gnumoksha/dotfiles/actions?query=workflow%3ATests)

Configuration files for command line and some graphical softwares.

## Installation
```bash
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"

export DOTFILES="$XDG_DATA_HOME/dotfiles"
git clone git@github.com:gnumoksha/dotfiles.git $DOTFILES
cd $DOTFILES
./install.sh
```

## Rules
* [If possible](https://wiki.archlinux.org/index.php/XDG_Base_Directory#Support), configuration files will follow [XDG Base Directory Specification](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html).
* A descriptive name is better than a short name.
