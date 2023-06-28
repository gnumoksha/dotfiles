#!/usr/bin/env bash
#
# Add colors to the shell
#
# shellcheck disable=SC1091

# https://wiki.archlinux.org/index.php/Color_output_in_console

DOTFILES_USE_COLORS=${DOTFILES_USE_COLORS:-}

case "$TERM" in
  xterm-color | *-256color) [[ -z "${DOTFILES_USE_COLORS}" ]] && DOTFILES_USE_COLORS=true ;;
esac

if [[ "${DOTFILES_USE_COLORS}" != 'true' ]]; then
  echo "Colors are disabled."
  return 1
fi

#
# Remark
#
# http://www.cyberciti.biz/open-source/command-line-hacks/remark-command-regex-markup-examples/
# http://savannah.nongnu.org/download/regex-markup/
# wget -c http://download.savannah.gnu.org/releases/regex-markup/regex-markup_0.10.0-1_amd64.deb -O /tmp/regex-markup.deb
#if [ $(command -v remark) ]; then
#    # Do alias the command because remark adds some delay to ping
#    ping_() { /bin/ping $@ | remark /usr/share/regex-markup/ping; }
#    traceroute_() { /usr/sbin/traceroute $@ | remark /usr/share/regex-markup/traceroute; }
#    diff_() { /usr/bin/diff $@ | remark /usr/share/regex-markup/diff; }
#fi

#
# GRC
#
# Exclude fedora because there is a kind of issue with "ls" alias.
if [[ -n "$ZSH_VERSION" && -e /etc/grc.zsh && ! -e /etc/fedora-release ]]; then
  source /etc/grc.zsh
elif [[ -n "$BASH_VERSION" && -e /etc/grc.bashrc ]]; then
  source /etc/grc.bashrc
fi

#
# dircolors
#
# https://github.com/trapd00r/LS_COLORS
# https://github.com/seebi/dircolors-solarized
# https://github.com/peterhellberg/dircolors-jellybeans
# https://github.com/arcticicestudio/nord-dircolors
# https://github.com/KKPMW/dircolors-moonshine
# https://github.com/karlding/dirchromatic
# https://github.com/ivoarch/dircolors-zenburn
# https://geoff.greer.fm/lscolors/
# cp --link --force LS_COLORS ~/.dircolors
#
# enable color support of ls and also add handy aliases
# reference: $HOME/.bashrc found on debian
if [ -x /usr/bin/dircolors ]; then
  if [ "$(command -v snazzy)" ]; then
    # https://github.com/sharkdp/vivid
    LS_COLORS="$(vivid generate molokai)"
    export LS_COLORS
  elif [ -r ~/.dircolors ]; then
    eval "$(dircolors --bourne-shell ~/.dircolors)"
  else
    eval "$(dircolors --bourne-shell)"
  fi

  alias ls='ls --color=auto'
  alias dir='dir --color=auto'
  alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
  alias ip='ip --color'
  # a trailing space causes the next word to be checked for alias
  # substitution when the alias is expanded.
  # https://unix.stackexchange.com/a/25329
  alias watch='watch --color '
fi

# Manpager
# Test it by running: man 2 select
# TODO use most if nvim is not available
# http://man7.org/linux/man-pages/man7/roff.7.html
# https://github.com/rtomayko/ronn
if [ $(command -v bat) ]; then
  # reference: https://github.com/sharkdp/bat#man
  alias cat='bat'
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
elif [ $(command -v batcat) ]; then
  alias cat='batcat'
  export MANPAGER="sh -c 'col -bx | batcat -l man -p'"
elif [ $(command -v nvim) ]; then
  export MANPAGER='nvim +Man!'
else
  export LESS_TERMCAP_mb=$'\e[1;32m'
  export LESS_TERMCAP_md=$'\e[1;32m'
  export LESS_TERMCAP_me=$'\e[0m'
  export LESS_TERMCAP_se=$'\e[0m'
  export LESS_TERMCAP_so=$'\e[01;33m'
  export LESS_TERMCAP_ue=$'\e[0m'
  export LESS_TERMCAP_us=$'\e[1;4;31m'
  #export LESS='-R --use-color -Dd+r$Du+b'
  export MANPAGER="less -R --use-color -Dd+r -Du+b"
fi

# colored GCC warnings and errors. Source: Debian's $HOME/.bashrc
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

export DOTFILES_USE_COLORS
