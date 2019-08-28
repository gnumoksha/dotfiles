#|
#| Manually install some plugins
#|
#
# This is useful because I've ended up with a slow shell startup while
# using more complete solutions like zplug.

minstall() {
    local REPO=${1:-}
    local DST=${2:-}
    local EXEC_AFTER=${3:-}
    local EXEC_ALWAYS=${4:-}

    local PKG_NAME=$(basename $REPO)

    if [[ -z "${DST}" ]]; then
	DST="${XDG_CACHE_HOME}/manually-installed/${PKG_NAME}"
    fi

    # FIXME dir do not exists before the first clone
    pushd -q "${DST}"

    if [[ ! -a "${DST}" ]]; then
	echo "Installing $PKG_NAME"
	git clone --depth=1 --recurse-submodules --quiet "${REPO}" "${DST}"

	if [[ ! -z "${EXEC_AFTER}" ]]; then
	    echo " -> Executing $EXEC_AFTER"
	    eval "${EXEC_AFTER}"
	    popd -q
	fi
    fi

    if [[ ! -z "${EXEC_ALWAYS}" ]]; then
	if [[ "${EXEC_ALWAYS}" == "plug" ]]; then
	    source "${PKG_NAME}.plugin.zsh"
	else
	    eval "${EXEC_ALWAYS}"
	fi
    fi

    popd -q
}

# Oh-my-zsh
minstall "https://github.com/robbyrussell/oh-my-zsh" "${ZSH}" "" "source oh-my-zsh.sh"


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

#minstall "https://github.com/romkatv/powerlevel10k" "" "" "source powerlevel9k.zsh-theme"

#minstall "https://github.com/martinrotter/powerless.git" "" "" "ssource ${POWERLESS}/powerless.zsh false && source ${POWERLESS}/utilities.zsh true"

minstall "https://github.com/eendroroy/alien-minimal" "" "" "source $DOTFILES_THEMES/alien-minimal.zsh && source alien-minimal.zsh"


#|
#| Tools
#|

if [[ ! -e "/usr/local/bin/git-extras" || ! -e "$XDG_CACHE_HOME/git-extras-completion.zsh" ]]; then
    echo "Installing git-extras"
    curl -sSL http://git.io/git-extras-setup | sudo bash /dev/stdin
    curl -sSL https://raw.githubusercontent.com/tj/git-extras/master/etc/git-extras-completion.zsh -o $XDG_CACHE_HOME/git-extras-completion.zsh
fi
source $XDG_CACHE_HOME/git-extras-completion.zsh

minstall "https://github.com/paulirish/git-open" "" "cp -f git-open /usr/local/bin/git-open"

minstall "https://github.com/junegunn/fzf" "" "./install --bin && mv ./bin/fzf /usr/local/bin/fzf" "source shell/completion.zsh && source shell/key-bindings.zsh"

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
minstall "https://github.com/zsh-users/zsh-syntax-highlighting" "" "" "plug"

#fpath=( "$XDG_CACHE_HOME/zsh/functions" $fpath )
#if [[ ! -e "${XDG_CACHE_HOME}/zsh/functions/docker-custom.zsh" ]]; then
	#echo "Installing docker-completions"
	#curl https://raw.githubusercontent.com/docker/cli/master/contrib/completion/zsh/_docker -o "${XDG_CACHE_HOME}/zsh/functions/docker-custom.zsh"
	#curl https://raw.githubusercontent.com/docker/compose/master/contrib/completion/zsh/_docker-compose -o $XDG_CACHE_HOME/zsh/functions/docker-compose.zsh
#fi

