# dotfiles
![pipeline](https://gitlab.com/gnumoksha/dotfiles/badges/master/pipeline.svg?style=flat-square)
![coverage](https://gitlab.com/gnumoksha/dotfiles/badges/master/coverage.svg?style=flat-square)

Configuration files for command line and some graphical softwares.

## Installation
```bash
git clone --recursive https://gitlab.com/gnumoksha/dotfiles.git ~/.local/share/dotfiles
cd ~/.local/share/dotfiles
# This will install configurations for some softwares under your $HOME and
# will ask about other things.
./install.sh
```

## Rules
* [If possible](https://wiki.archlinux.org/index.php/XDG_Base_Directory#Support), configuration files will follow [XDG Base Directory Specification](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html).
* A descriptive name is better than a short name.

## Warning
* Please, note that github repository is only a mirror, the main efforts in this code are submitted to [gitlab](https://gitlab.com/gnumoksha/dotfiles).

