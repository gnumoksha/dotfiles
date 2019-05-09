# $ZDOTDIR/.zshrc: user-wide .zshrc file for zsh(1).
#
# This file is sourced only for interactive shells. It
# should contain commands to set up aliases, functions,
# options, key bindings, etc.
#
# Global Order: zshenv, zprofile, zshrc, zlogin


#|
#| Profiling
#|
#zmodload zsh/zprof
#/usr/bin/time zsh -i -c exit
STARTED_AT=$(date +%s.%N)


#|
#| My custom scripts
#|
# May start tmux.
source "$XDG_CONFIG_HOME/tmux/utils.sh"
# Settings related to the terminal prompt and ls colors.
# Contains prezto settings that need to be defined before prezto is loaded.
source "$ZDOTDIR/theme.zsh"


#|
#| Plugins
#|
# Plugins with zplug
#source $XDG_CONFIG_HOME/zsh/zplug.zsh

# Plugins with zgen
#source $XDG_CONFIG_HOME/zsh/zgen.zsh

# Plugins with oh-my-zsh
source $XDG_CONFIG_HOME/zsh/oh-my-zsh/oh-my-zsh.zsh


#|
#| ZSH settings
#|
# History
HISTFILE="$ZDOTDIR/.zsh_history"
HISTSIZE=50000
SAVEHIST=10000


#|
#| Load my custom bourne shell plugins.
#| It is here to ensure plugins will not override my configurations.
#|
source "$DOTFILES_SHELL_PLUGINS/bootstrap.sh"

ZSH_SYNTAX_HIGHLIGHTING="${XDG_CACHE_HOME}/zsh/zsh-syntax-highlighting"
if [[ ! -e "${ZSH_SYNTAX_HIGHLIGHTING}/zsh-syntax-highlighting.zsh" ]]; then
	echo "Installing zsh-syntax-highlighting"
	git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_SYNTAX_HIGHLIGHTING}"
fi
# Must be sourced at the end of the .zshrc
source "${ZSH_SYNTAX_HIGHLIGHTING}/zsh-syntax-highlighting.zsh"
unset ZSH_SYNTAX_HIGHLIGHTING

if [[ ! -e "/usr/local/bin/git-extras" ]]; then
    echo "Installing git-extras"
    curl -sSL http://git.io/git-extras-setup | sudo bash /dev/stdin
    curl -sSL https://raw.githubusercontent.com/tj/git-extras/master/etc/git-extras-completion.zsh -o $XDG_CACHE_HOME/git-extras-completion.zsh
fi
source $XDG_CACHE_HOME/git-extras-completion.zsh

if [[ ! -e /usr/local/bin/git-open ]]; then
    curl -sSL https://raw.githubusercontent.com/paulirish/git-open/master/git-open -o /usr/local/bin/git-open
fi

if [[ ! -e "${ZSH_CUSTOM}/themes/powerlevel10k/prompt_powerlevel10k_setup" ]]; then
    echo "Installing powerlevel 10k"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM}/themes/powerlevel10k"
fi

POWERLESS="${XDG_CACHE_HOME}/zsh/powerless"
if [[ ! -e "${POWERLESS}/powerless.zsh" ]]; then
	echo "Installing powerless theme"
	git clone --depth=1 https://github.com/martinrotter/powerless.git "${POWERLESS}"
fi
#source "${POWERLESS}/powerless.zsh" false
#source "${POWERLESS}/utilities.zsh" true
#unset POWERLESS

#FZF_INSTALL="${XDG_CACHE_HOME}/fzf"
#if [[ ! -e "${FZF_INSTALL}/install" ]]; then
	#echo "Installing fzf"
        ##curl -sSL https://raw.githubusercontent.com/junegunn/fzf/master/install -o /usr/local/fzf-install
	##bash /usr/local/fzf-install --bin
	#git clone --depth=1 https://github.com/junegunn/fzf.git "${FZF_INSTALL}"
#fi
#unset FZF_INSTALL

#fpath=( "$XDG_CACHE_HOME/zsh/functions" $fpath )
#if [[ ! -e "${XDG_CACHE_HOME}/zsh/functions/docker-custom.zsh" ]]; then
	#echo "Installing docker-completions"
	#curl https://raw.githubusercontent.com/docker/cli/master/contrib/completion/zsh/_docker -o "${XDG_CACHE_HOME}/zsh/functions/docker-custom.zsh"
	#curl https://raw.githubusercontent.com/docker/compose/master/contrib/completion/zsh/_docker-compose -o $XDG_CACHE_HOME/zsh/functions/docker-compose.zsh
#fi

LOAD_TIME=$(( $(date +%s.%N) - STARTED_AT ))
if [[ $LOAD_TIME -gt 1 ]]; then
    >&2 echo "[warning] startup time was $LOAD_TIME seconds."
fi
unset STARTED_AT LOAD_TIME


#|
#| References
#|
# man

# vim: ft=zsh
