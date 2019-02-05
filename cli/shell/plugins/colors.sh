#
# Add colors to the shell
##########################

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
# dircolos
#
# enable color support of ls and also add handy aliases
# source: $HOME/.bashrc found on debian
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
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

#EOF
