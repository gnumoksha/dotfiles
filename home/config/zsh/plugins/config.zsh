#################################
#                               #
#             Plugins           #
#                               #
#################################

# 2017-10-20 - Tobias - I've checked on-my-zsh and those are the useful plugins:
# colored-man-pages composer copybuffer copydir docker docker-compose
# git git-flow-avh git-extras
# gpg-agent history-substring-search httpie nmap npm pass pip
# redis-cli rsync screen shrink-path ssh-agent systemadmin tmux
# vi-mode virtualenv
# Repository: https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins

zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# From oh-my-zsh
zplug "lib/completion", from:oh-my-zsh
zplug "plugins/colored-man-pages", from:oh-my-zsh
zplug "plugins/copybuffer", from:oh-my-zsh
zplug "plugins/copydir", from:oh-my-zsh
zplug "plugins/docker", from:oh-my-zsh
zplug "plugins/docker-compose", from:oh-my-zsh
zplug "plugins/git-fast", from:oh-my-zsh
zplug "plugins/git-flow-avh", from:oh-my-zsh
zplug "plugins/gpg-agent", from:oh-my-zsh
#zplug "plugins/httpie", from:oh-my-zsh
zplug "plugins/pass", from:oh-my-zsh
#zplug "plugins/compleat", from:oh-my-zsh

# From prezto
zplug "modules/editor", from:prezto
zplug "modules/git", from:prezto
zplug "modules/prompt", from:prezto

# From zsh-users
zplug "zsh-users/zsh-syntax-highlighting", defer:2
#zplug "zsh-users/zsh-completions"

# From multiple sources
zplug "reorx/httpstat", from:github, as:command, use:'httpstat.py', rename-to:'httpstat'
#zplug "sharkdp/fd", from:gh-r, as:command, rename-to:fd, use:"x86_64-unknown-linux-gnu.tar.gz"
#zplug "junegunn/fzf-bin", from:gh-r, as:command, rename-to:fzf, use:"*linux_amd64*"
zplug "junegunn/fzf", from:github, as:command, rename-to:fzf, hook-build:"./install --all"
zplug "junegunn/fzf", from:github, as:plugin, use:"shell/*.zsh"
zplug "stedolan/jq", from:gh-r, as:command, rename-to:jq
#zplug "supercrabtree/k" " I did not use.
zplug 'tj/git-extras', as:plugin, hook-build:"make install"
zplug "so-fancy/diff-so-fancy", from:github, as:command, rename-to:diff-so-fancy
zplug 'wfxr/forgit', defer:1
zplug "paulirish/git-open", as:plugin
zplug "github/hub", from:gh-r, as:command, rename-to:hub
#zplug "mafredri/zsh-async", from:github

# Install plugins if there are plugins that have not been installed
# Note: This increases startup time.
# See https://github.com/zplug/zplug/issues/368
#if ! zplug check --verbose; then
	#printf "Install missing plugins? [y/N]: "
	#if read; then
		#echo; zplug install
	#fi
#fi

