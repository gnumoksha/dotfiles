PROMPT='%{$fg[red]%}%m%{$reset_color%}:%{$fg_bold[green]%}%~%{$reset_color%}%(!.#.$) '
RPROMPT='%? $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[magenta]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX=")%{$reset_color%}"

# vim: ft=zsh
# http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
