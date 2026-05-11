#|
#| Manually install some plugins
#|
#
# This is useful because I've ended up with a slow shell startup while
# using more complete solutions like zplug.

#|
#| Oh-my-zsh
#|
# Updates every 7 days
zstyle ':omz:update' frequency 7
# This avoids omz to set the alias ls="ls --color=tty" which will list one
# entry per line with no colors.
DISABLE_LS_COLORS="true"
# I don't automatically want url quotation because it is buggy, i.e. that ignores ''
DISABLE_MAGIC_FUNCTIONS=true
# Disable all oh-my-zsh aliases (in lib files and enabled plugins)
zstyle ':omz:*' aliases no
# Enabled plugins
plugins=(command-not-found)
zsh-plugin-installer \
	--repo "https://github.com/ohmyzsh/ohmyzsh" \
	--exec-always "source oh-my-zsh.sh"

#|
#| Themes
#|
# For a list of themes, type prompt -l.
# To preview a theme, type prompt -p name.
#
# Themes list:
# bhilburn/powerlevel9k
# caiogondim/bullet-train.zsh
# halfo/lambda-mod-zsh-theme
# agkozak/agkozak-zsh-prompt
# zakaziko99/agnosterzak-ohmyzsh-theme
# eendroroy/alien-minimal
# sindresorhus/pure
# denysdovhan/spaceship-prompt
# simnalamburt/shellder
# zlsun/solarized-man

DOTFILES_THEMES="${0:a:h}/../themes"

#zsh-plugin-installer \
#	--repo "https://github.com/martinrotter/powerless.git" \
#	--exec-always "source powerless.zsh false && source utilities.zsh true"

#zsh-plugin-installer \
#	--repo "https://github.com/eendroroy/alien-minimal" \
#	--exec-always "source $DOTFILES_THEMES/alien-minimal.zsh && source alien-minimal.zsh"

# powerlevel10k is on life support
# https://github.com/romkatv/powerlevel10k/commit/bde5ca4c2aa6e0c52dd7f15cf216dffdb1ec788c
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
# 	source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi
# zsh-plugin-installer \
#	--repo "https://github.com/romkatv/powerlevel10k" \
#	--exec-always "source powerlevel10k.zsh-theme && source $XDG_CONFIG_HOME/zsh/.p10k.zsh"

# starship has less options than powerlevel10k (such as the highlight of current
# dir, number of modified files in git) but powerlevel10k is on life support.
[[ ":$PATH:" != *":$HOME/.local/bin:"* ]] && export PATH="$PATH:$HOME/.local/bin"
zsh-plugin-installer \
	--repo "https://github.com/starship/starship" \
	--exec-after "./install/install.sh --yes --bin-dir=$HOME/.local/bin" \
	--exec-always 'eval "$(starship init zsh)"'

# oh-my-posh is difficult to customize and it is focused on Windows
# nice themes: agnoster, mojada, nu4a, powerline, unicorn
#zsh-plugin-installer \
#	--repo "https://github.com/JanDeDobbeleer/oh-my-posh" \
#	--exec-after "bash ./website/static/install.sh -d /usr/local/bin" \
#	--exec-always='eval "$(oh-my-posh init zsh --config $XDG_CACHE_HOME/oh-my-posh/themes/agnoster.omp.json)"'

#|
#| Tools
#|
if [[ ! -e "/usr/local/bin/git-extras" || ! -e "$XDG_CACHE_HOME/git-extras-completion.zsh" ]]; then
	echo "Installing git-extras"
	curl -sSL http://git.io/git-extras-setup | sudo bash /dev/stdin
	curl -sSL https://raw.githubusercontent.com/tj/git-extras/master/etc/git-extras-completion.zsh \
		-o $XDG_CACHE_HOME/git-extras-completion.zsh
fi
source $XDG_CACHE_HOME/git-extras-completion.zsh

zsh-plugin-installer \
	--repo "https://github.com/paulirish/git-open" \
	--exec-after "cp -f git-open $HOME/.local/bin/git-open"

zsh-plugin-installer \
	--repo "https://github.com/junegunn/fzf" \
	--exec-after "./install --bin && mv -f ./bin/fzf $HOME/.local/bin/fzf" \
	--exec-always "source shell/completion.zsh && source shell/key-bindings.zsh"

# Syntax Highlighting
# https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern root)
# Declare the variable
typeset -A ZSH_HIGHLIGHT_STYLES
typeset -A ZSH_HIGHLIGHT_PATTERNS
# Paths colored instead of underlined
ZSH_HIGHLIGHT_STYLES[path]='fg=green'
# Commands starting with `rm -rf` in red:
ZSH_HIGHLIGHT_PATTERNS+=('rm -[rR]f *' 'fg=white,bold,bg=red')
# Must be sourced at the end of the .zshrc
zsh-plugin-installer \
	--repo "https://github.com/zsh-users/zsh-syntax-highlighting" \
	--exec-always "plug"
