#################################
#                               #
#      Themes and dircolors     #
#                               #
#################################

# For a list of themes, type prompt -l.
# To preview a theme, type prompt -p name.

zplug "modules/git", from:prezto
zplug "modules/prompt", from:prezto
#zplug "themes/paradox", from:prezto, as:theme
zstyle ':prezto:module:prompt' theme 'sorin'
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
#zplug "arcticicestudio/nord-dircolors", from:github, hook-build:"mv ~/.dir_colors{,.bkp} &&  ./install.sh"
#zplug "peterhellberg/dircolors-jellybeans", from:github, hook-build:"mv ~/.dir_colors{,.bkp} &&  cp dircolors.jellybeans ~/.dir_colors"
zplug "trapd00r/LS_COLORS", from:github, hook-build:"mv ~/.dir_colors{,.bkp} && cp LS_COLORS ~/.dir_colors"
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

