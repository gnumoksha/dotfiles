#!/bin/bash
# By Tobias Sette. Public domain.

export TERM=xterm-256color

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dir_colors && eval "$(dircolors -b ~/.dir_colors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi


    # http://bashscript.blogspot.com/2010/01/shell-colors-colorizing-shell-scripts.html
    zera="\[\033[00m\]"
    zera2="\033[00m"
    bold="\[\033[01;34m\]"
    sublinhado="\[\033[00;4m\]"
    red="\[\033[00;31m\]"
    red2="\033[00;31m"
    green="\[\033[00;32m\]"
    green2="\033[00;32m"
    # https://wiki.archlinux.org/index.php/Color_Bash_Prompt
    #PROMPT_COMMAND='
    #RET=$?;
    #if [[ $RET -eq 0 ]]; then
#	    echo -ne "${green2}$RET${zera2}";
    #else
#	    echo -ne "${red2}$RET${zera2}";
    #fi;
    #echo -n " "'

    #PS1="${debian_chroot:+($debian_chroot)}${bold}\u${zera}@${sublinhado}\h${zera}:\w\$ "
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# https://www.ibm.com/developerworks/community/blogs/752a690f-8e93-4948-b7a3-c060117e8665/entry/prompt_de_bash_mais__c3_batil46?lang=en
cor_preto="\[\033[00;30m\]"
cor_azul="\[\033[00;34m\]"
cor_verde="\[\033[00;32m\]"
cor_ciano="\[\033[00;36m\]"
cor_vermelho="\[\033[00;31m\]"
cor_roxo="\[\033[00;35m\]"
cor_marrom="\[\033[00;33m\]"
cor_cinza_claro="\[\033[00;37m\]"
cor_cinza_escuro="\[\033[01;30m\]"
cor_azul_claro="\[\033[01;34m\]"
cor_verde_claro="\[\033[01;32m\]"
cor_ciano_claro="\[\033[01;36m\]"
cor_vermelho_claro="\[\033[01;31m\]"
cor_roxo_claro="\[\033[01;35m\]"
cor_amarelo="\[\033[01;33m\]"
cor_branco="\[\033[01;37m\]"
cor_nenhum="\[\033[00m\]"
cor_amarelo_fundo_vermelho="\[\033[01;33;41m\]"
sublinhado="\[\033[00;4m\]"

if [[ ${UEID} == 0 ]]; then
	# para root
	export PS1="${cor_marrom}\t ${cor_amarelo_fundo_vermelho}\u${cor_marrom}@${cor_verde_claro}\h${cor_nenhum}:\w\$ "
else
	export PS1="${cor_marrom}\t ${cor_azul_claro}\u${cor_marrom}@${cor_verde_claro}\h${cor_nenhum}:\w\$ "
fi

# http://www.cyberciti.biz/open-source/command-line-hacks/remark-command-regex-markup-examples/
REMARK=$(which remark)
if [[ ! -f $REMARK ]]; then
	echo "Instale o remark para habilitar destaque de sintaxe"
	echo "http://savannah.nongnu.org/download/regex-markup/"
else
	ping() { /bin/ping $@ | $REMARK /usr/share/regex-markup/ping; }
	traceroute() { /usr/sbin/traceroute $@ | $REMARK /usr/share/regex-markup/traceroute; }
	diff() { /usr/bin/diff $@ | $REMARK /usr/share/regex-markup/diff; }
fi

# http://www.cyberciti.biz/programming/color-terminal-highlighter-for-diff-files/
#alias diff="colordiff"
