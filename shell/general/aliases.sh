
# directory '_name' must come over before 'name'
# https://stackoverflow.com/a/18451819
alias ls='LANG=C.UTF-8 ls --color=auto'

alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# me from future: be careful and stay safe :)
alias rm='rm --interactive --verbose'
alias cp="cp --interactive"
alias mv="mv --interactive"

# Nice format :)
alias dmesg="dmesg --color --ctime --decode"

# Git in english
# https://githowto.com/aliases
alias git='LANG=en_US.UTF-8 git'

alias my_to_clipboard="xclip -selection c"

#EOF