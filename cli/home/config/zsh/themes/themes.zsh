#|
#| Settings for zsh theme that are framework agnostic.
#| For oh-my-zsh or prezto themes see oh-my-zsh.zsh / prezto.zsh
#|

# For a list of themes, type prompt -l.
# To preview a theme, type prompt -p name.

#|
#| Themes list
#|
# bhilburn/powerlevel9k
# caiogondim/bullet-train.zsh
# halfo/lambda-mod-zsh-theme
# agkozak/agkozak-zsh-prompt
# zakaziko99/agnosterzak-ohmyzsh-theme
# eendroroy/alien-minimal
# sindresorhus/pure
# denysdovhan/spaceship-prompt
# simnalamburt/shellder

#zplug "zlsun/solarized-man"

#|
#| Syntax Highlighting
#|
# https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern root)
# Declare the variable
typeset -A ZSH_HIGHLIGHT_STYLES
typeset -A ZSH_HIGHLIGHT_PATTERNS
# To have paths colored instead of underlined
ZSH_HIGHLIGHT_STYLES[path]='fg=yellow,bold'
# To have commands starting with `rm -rf` in red:
ZSH_HIGHLIGHT_PATTERNS+=('rm -[rR]f *' 'fg=white,bold,bg=red')

