#
# My custom settings for zgen - A lightweight and simple plugin manager for ZSH
#
# https://github.com/tarjoilija/zgen

#
# Configuration
#
export ZGEN_DIR="${XDG_DATA_HOME}/zgen"
export ZGEN_RESET_ON_CHANGE=($XDG_CONFIG_HOME/zsh/zgen.zsh) # watch this file for modifications

#
# Instalation
#
if [[ ! -e "${ZGEN_DIR}" ]]; then
	git clone --depth=1 https://github.com/tarjoilija/zgen.git "${ZGEN_DIR}"
fi
source "${ZGEN_DIR}/zgen.zsh"

#
# Plugins
#
if ! zgen saved; then

	# comparar autocomplete do oh-my-zsh com prezto
	# usar script para apenas fazer download dos sh que quero?

	# Oh-my-zsh
	#zgen oh-my-zsh
	##zgen oh-my-zsh lib/completion
	#zgen oh-my-zsh plugins/colored-man-pages
	#zgen oh-my-zsh plugins/docker
	#zgen oh-my-zsh plugins/docker-compose
	#zgen oh-my-zsh plugins/git-flow-avh

	# Prezto
	# prezto options
	#zgen prezto editor key-bindings 'emacs'
	#zgen prezto prompt theme 'sorin'
	#zstyle ':prezto:module' completion no
	# prezto and its modules
	#zgen prezto
	#zgen prezto editor
	#zgen prezto git

	# Others plugins
	zgen load zsh-users/zsh-syntax-highlighting
	#zgen load zsh-users/zsh-completions #loaded by prezto
	# nao funciona no primeiro shell aberto
	zgen load trapd00r/zsh-syntax-highlighting-filetypes

	# Themes
	#zgen load denysdovhan/spaceship-prompt spaceship # slow
fi

source $ZGEN_DIR/robbyrussell/oh-my-zsh-master/lib/completion.zsh

source $ZGEN_DIR/sorin-ionescu/prezto-master/init.zsh
#source $ZGEN_DIR/sorin-ionescu/prezto-master/modules/editor/init.zsh
#source $ZGEN_DIR/sorin-ionescu/prezto-master/modules/git/init.zsh
#source $ZGEN_DIR/sorin-ionescu/prezto-master/modules/prompt/init.zsh

# ver https://github.com/sorin-ionescu/prezto/issues/1535

# vim: ft=zsh
