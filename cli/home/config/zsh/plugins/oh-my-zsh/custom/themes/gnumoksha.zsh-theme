# based on daveverwer.zsh-theme and wezm (for second column)
#
# Copied and modified from the oh-my-zsh theme from geoffgarside
# Red server name, green cwd, blue git status

# tobias@zefram:/tmp/a$ command

# %n = user
PROMPT='%{$fg[red]%}%m%{$reset_color%}:%{$fg_bold[green]%}%~%{$reset_color%}%(!.#.$) '
RPROMPT='%? $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[magenta]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX=")%{$reset_color%}"

# wezm
#PROMPT='$(git_prompt_info)%(?,,%{${fg_bold[white]}%}[%?]%{$reset_color%} )%{$fg[yellow]%}%#%{$reset_color%} '
#RPROMPT='%{$fg[green]%}%~%{$reset_color%}'

#ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[blue]%}("
#ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
#ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%})%{$fg[red]%}⚡%{$reset_color%}"
#ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

# vim: ft=zsh
# http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
