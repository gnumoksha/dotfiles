#
# Add colors to the shell
#

# https://wiki.archlinux.org/index.php/Color_output_in_console

DOTFILES_USE_COLORS=${DOTFILES_USE_COLORS:-}

case "$TERM" in
    xterm-color|*-256color) [[ -z "${DOTFILES_USE_COLORS}" ]] && DOTFILES_USE_COLORS=true;;
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
if [ $(command -v remark) ]; then
    # Do alias the command because remark adds some delay to ping
    ping_() { /bin/ping $@ | remark /usr/share/regex-markup/ping; }
    traceroute_() { /usr/sbin/traceroute $@ | remark /usr/share/regex-markup/traceroute; }
    diff_() { /usr/bin/diff $@ | remark /usr/share/regex-markup/diff; }
fi

#
# GRC
#
if [[ ! -z "$ZSH_VERSION" && -e /etc/grc.zsh ]]; then
    source /etc/grc.zsh
elif [[ ! -z "$BASH_VERSION" && -e /etc/grc.bashrc ]]; then
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
    if [ $(command -v snazzy) ]; then
       # https://github.com/sharkdp/vivid
       export LS_COLORS="$(vivid generate molokai)"
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
fi

# colored GCC warnings and errors. Source: Debian's $HOME/.bashrc
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

export DOTFILES_USE_COLORS

#EOF
