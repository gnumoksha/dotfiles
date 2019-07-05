#
# Manually install some plugins
#

minstall() {
    local REPO=${1:-}
    local DST=${2:-}
    local EXEC_AFTER=${3:-}
    local EXEC_ALWAYS=${4:-}

    local PKG_NAME=$(basename $REPO)

    if [[ -z "${DST}" ]]; then
	DST="${XDG_CACHE_HOME}/manually-installed/${PKG_NAME}"
    fi

    if [[ ! -a "${DST}" ]]; then
	echo "Installing $PKG_NAME"
	git clone --depth=1 --recurse-submodules --quiet "${REPO}" "${DST}"

	if [[ ! -z "${EXEC_AFTER}" ]]; then
	    cd "${DST}"
	    echo " -> Executing $EXEC_AFTER"
	    eval "${EXEC_AFTER}"
	fi
    fi

    if [[ ! -z "${EXEC_ALWAYS}" ]]; then
	cd "${DST}"
	if [[ "${EXEC_ALWAYS}" == "plug" ]]; then
	    source "${PKG_NAME}.plugin.zsh"
	else
	    eval "${EXEC_ALWAYS}"
	fi
    fi
}

#|
#| Themes
#|

minstall "https://github.com/romkatv/powerlevel10k.git" "${ZSH_CUSTOM}/themes/powerlevel10k"

#minstall "https://github.com/martinrotter/powerless.git" "" "" "ssource ${POWERLESS}/powerless.zsh false && source ${POWERLESS}/utilities.zsh true"

minstall "https://github.com/eendroroy/alien-minimal.git" "${ZSH_CUSTOM}/themes/alien-minimal" "" "source $ZDOTDIR/themes/alien-minimal.zsh"

#|
#| Tools
#|

if [[ ! -e "/usr/local/bin/git-extras" || ! -e "$XDG_CACHE_HOME/git-extras-completion.zsh" ]]; then
    echo "Installing git-extras"
    curl -sSL http://git.io/git-extras-setup | sudo bash /dev/stdin
    curl -sSL https://raw.githubusercontent.com/tj/git-extras/master/etc/git-extras-completion.zsh -o $XDG_CACHE_HOME/git-extras-completion.zsh
fi
source $XDG_CACHE_HOME/git-extras-completion.zsh

minstall "https://github.com/paulirish/git-open" "" "cp git-open /usr/local/bin/git-open"

minstall "https://github.com/junegunn/fzf" "" "./install --bin && mv ./bin/fzf /usr/local/bin/fzf" "cd shell/ && source completion.zsh && source key-bindings.zsh"

# Must be sourced at the end of the .zshrc
minstall "https://github.com/zsh-users/zsh-syntax-highlighting" "" "" "plug"

#fpath=( "$XDG_CACHE_HOME/zsh/functions" $fpath )
#if [[ ! -e "${XDG_CACHE_HOME}/zsh/functions/docker-custom.zsh" ]]; then
	#echo "Installing docker-completions"
	#curl https://raw.githubusercontent.com/docker/cli/master/contrib/completion/zsh/_docker -o "${XDG_CACHE_HOME}/zsh/functions/docker-custom.zsh"
	#curl https://raw.githubusercontent.com/docker/compose/master/contrib/completion/zsh/_docker-compose -o $XDG_CACHE_HOME/zsh/functions/docker-compose.zsh
#fi

