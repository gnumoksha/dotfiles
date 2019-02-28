#################################
#                               #
#      Themes and dircolors     #
#                               #
#################################

# For a list of themes, type prompt -l.
# To preview a theme, type prompt -p name.

#zplug "themes/risto", from:oh-my-zsh, as:theme
#zplug "bhilburn/powerlevel9k", use:powerlevel9k.zsh-theme
#zplug "bhilburn/powerlevel9k", as:theme
#zplug "caiogondim/bullet-train.zsh", use:bullet-train.zsh-theme, defer:3 # defer until other plugins like oh-my-zsh is loaded
#zplug "themes/gentoo", from:oh-my-zsh, as:theme
#zplug "themes/gianu", from:oh-my-zsh, as:theme
#zplug "zlsun/solarized-man"
#zplug "halfo/lambda-mod-zsh-theme", as:theme
#zplug "agkozak/agkozak-zsh-prompt"
#zplug "zakaziko99/agnosterzak-ohmyzsh-theme", as:theme
#zplug "eendroroy/alien-minimal"
#zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme
#zplug "denysdovhan/spaceship-prompt", use:spaceship.zsh, from:github, as:theme
#zplug "el1t/statusline"
#zplug 'simnalamburt/shellder', as:theme
#zplug "joel-porquet/zsh-dircolors-solarized"
#zplug "arcticicestudio/nord-gnome-terminal", from:github, hook-build:"./src/nord.sh"
#zplug "peterhellberg/dircolors-jellybeans", from:github, hook-build:"cp --force dircolors.jellybeans $HOME/.dircolors"
#zplug "arcticicestudio/nord-dircolors", from:github, hook-build:"./install.sh"
#zplug "KKPMW/dircolors-moonshine", from:github, hook-build:"cp --force dircolors.moonshine $HOME/.dircolors"
#zplug "trapd00r/LS_COLORS", from:github, hook-build:"cp --link --force LS_COLORS ~/.dir_colors"
#zplug "themes/alanpeabody", from:oh-my-zsh, as:theme
#zplug "themes/daveverwer", from:oh-my-zsh, as:theme
#zplug "themes/dieter", from:oh-my-zsh, as:theme
#zplug "themes/maran", from:oh-my-zsh, as:theme
#zplug "themes/miloshadzic", from:oh-my-zsh, as:theme
## nice ideia
#zplug "themes/wezm", from:oh-my-zsh, as:theme
#source "$DOTFILES/shell/zsh/powerlevel9k_settings.zsh"
# Only this in interactive shells, not from a script or from scp
#[[ $- = *i* ]] && source "$DOTFILES/shell/zsh/agkozak-settings.zsh"

# Do not use alias from prezto git module.
zstyle ':prezto:module:git:alias' skip 'yes'


#
# Prezto prompt
#
# Set the prompt theme to load.
# Setting it to 'random' loads a random theme.
# Auto set to 'off' on dumb terminals.
# Nice prompts: paradox, sorin, skwp, bart, giddie, damoekri, kylewest.
zstyle ':prezto:module:prompt' theme 'sorin'
prompt sorin # ZPLUG-PREZTO-BUG

# Set the working directory prompt display length.
# By default, it is set to 'short'. Set it to 'long' (without '~' expansion)
# for longer or 'full' (with '~' expansion) for even longer prompt display.
zstyle ':prezto:module:prompt' pwd-length 'long'

# Set the prompt to display the return code along with an indicator for non-zero
# return codes. This is not supported by all prompts.
zstyle ':prezto:module:prompt' show-return-val 'yes'

#
# Syntax Highlighting
#

# https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern root)

# Declare the variable
typeset -A ZSH_HIGHLIGHT_STYLES
typeset -A ZSH_HIGHLIGHT_PATTERNS

# To have paths colored instead of underlined
ZSH_HIGHLIGHT_STYLES[path]='fg=yellow,bold'

# To have commands starting with `rm -rf` in red:
ZSH_HIGHLIGHT_PATTERNS+=('rm -[rR]f *' 'fg=white,bold,bg=red')

