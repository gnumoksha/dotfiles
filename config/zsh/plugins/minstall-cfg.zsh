#|
#| Manually install some plugins
#|
#
# This is useful because I've ended up with a slow shell startup while
# using more complete solutions like zplug.

#|
#| Oh-my-zsh
#|
#DISABLE_AUTO_UPDATE=true
UPDATE_ZSH_DAYS=7
# I don't automatically want url quotation because it is buggy, i.e. that ignores ''
DISABLE_MAGIC_FUNCTIONS=true
minstall "https://github.com/robbyrussell/oh-my-zsh" "" "" "source oh-my-zsh.sh"

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

minstall "https://github.com/romkatv/powerlevel10k" "" "" "source powerlevel10k.zsh-theme && source ~/.config/zsh/.p10k.zsh"

#minstall "https://github.com/martinrotter/powerless.git" "" "" "source powerless.zsh false && source utilities.zsh true"

#minstall "https://github.com/eendroroy/alien-minimal" "" "" "source $DOTFILES_THEMES/alien-minimal.zsh && source alien-minimal.zsh"

# https://github.com/starship/starship
# has buffer problems with tmux / oh-my-zsh / zsh-highlighting
#eval "$(starship init zsh)"

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
