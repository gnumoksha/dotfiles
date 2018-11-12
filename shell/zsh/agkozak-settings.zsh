AGKOZAK_PROMPT_DIRTRIM=4

AGKOZAK_CUSTOM_PROMPT='%(?..%B%F{red}(%?%)%f%b )'
AGKOZAK_CUSTOM_PROMPT+='%(!.%S%B.%B%F{green})%n%1v%(!.%b%s.%f%b) '
AGKOZAK_CUSTOM_PROMPT+=$'%B%F{blue}%2v%f%b%(3V.%F{243}%3v%f.)\n'
#AGKOZAK_CUSTOM_PROMPT+='$(_agkozak_vi_mode_indicator) '
AGKOZAK_CUSTOM_PROMPT+='$ '

AGKOZAK_CUSTOM_RPROMPT='%*'
