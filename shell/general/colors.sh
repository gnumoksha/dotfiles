# Terminal with colors
export TERM=xterm-256color

# http://www.cyberciti.biz/open-source/command-line-hacks/remark-command-regex-markup-examples/
REMARK=$(which remark)
if [[ ! -f $REMARK ]]; then
	echo "Instale o remark para habilitar destaque de sintaxe"
	echo "http://savannah.nongnu.org/download/regex-markup/"
else
	ping_() { /bin/ping $@ | $REMARK /usr/share/regex-markup/ping; }
	traceroute_() { /usr/sbin/traceroute $@ | $REMARK /usr/share/regex-markup/traceroute; }
	diff_() { /usr/bin/diff $@ | $REMARK /usr/share/regex-markup/diff; }
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dir_colors && eval "$(dircolors -b ~/.dir_colors)" || eval "$(dircolors -b)"
fi

#EOF
