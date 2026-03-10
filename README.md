# dotfiles
![Build Status](https://github.com/gnumoksha/dotfiles/actions/workflows/tests.yml/badge.svg)
[![Continuous integration status](https://github.com/gnumoksha/dotfiles/workflows/Tests/badge.svg)](https://github.com/gnumoksha/dotfiles/actions?query=workflow%3ATests)

Configuration files for command line and some graphical softwares.

## Installation
```bash
export DOTFILES=$HOME/.local/share/dotfiles
git clone git@github.com:gnumoksha/dotfiles.git $DOTFILES
cd $DOTFILES
./install.sh
```

## Rules
* [If possible](https://wiki.archlinux.org/index.php/XDG_Base_Directory#Support), configuration files will follow [XDG Base Directory Specification](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html).
* A descriptive name is better than a short name.
