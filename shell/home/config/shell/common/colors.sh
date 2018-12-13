
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

# coloquei aqui por usa um alias para ls que nao funciona
#[[ -s "/etc/grc.zsh" ]] && source /etc/grc.zsh

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

#EOF
