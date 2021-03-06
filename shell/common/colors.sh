# Terminal with colors
export TERM=xterm-256color

# http://www.cyberciti.biz/open-source/command-line-hacks/remark-command-regex-markup-examples/
REMARK=$(which remark)
if [[ ! -f $REMARK ]]; then
	echo "http://savannah.nongnu.org/download/regex-markup/"
	echo "remark not found, installing it"
	wget -c http://download.savannah.gnu.org/releases/regex-markup/regex-markup_0.10.0-1_amd64.deb -O /tmp/regex-markup.deb
	sudo dpkg -i /tmp/regex-markup.deb
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
