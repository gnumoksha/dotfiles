#
# Manually install some plugins
#

ZSH_SYNTAX_HIGHLIGHTING="${XDG_CACHE_HOME}/zsh/zsh-syntax-highlighting"
if [[ ! -e "${ZSH_SYNTAX_HIGHLIGHTING}/zsh-syntax-highlighting.zsh" ]]; then
	echo "Installing zsh-syntax-highlighting"
	git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_SYNTAX_HIGHLIGHTING}"
fi
# Must be sourced at the end of the .zshrc
source "${ZSH_SYNTAX_HIGHLIGHTING}/zsh-syntax-highlighting.zsh"
unset ZSH_SYNTAX_HIGHLIGHTING

if [[ ! -e "/usr/local/bin/git-extras" || ! -e "$XDG_CACHE_HOME/git-extras-completion.zsh" ]]; then
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

if [[ ! -e "${ZSH_CUSTOM}/themes/alien-minimal" ]]; then
	echo "Installing prompt 'alien minimal'"
	git clone --depth=1 --recurse-submodules https://github.com/eendroroy/alien-minimal.git ${ZSH_CUSTOM}/themes/alien-minimal
fi
source $ZDOTDIR/themes/alien-minimal.zsh
