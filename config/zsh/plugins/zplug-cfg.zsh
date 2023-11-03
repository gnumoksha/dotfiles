#
# My custom settings for zplug - A next-generation plugin manager for zsh
#
# https://github.com/zplug/zplug

# If you need to uninstall zplug, do:
# rm -Rf $ZPLUG_HOME $ZPLUG_CACHE_DIR $ZPLUG_BIN
ZPLUG_HOME="$XDG_DATA_HOME/zplug"
#ZPLUG_LOADFILE="$XDG_CONFIG_HOME/zsh/zplug.zsh"
ZPLUG_BIN='/usr/local/bin/zplug'
ZPLUG_USE_CACHE=true
ZPLUG_CACHE_DIR="$XDG_CACHE_HOME/zplug"
if [[ ! -e "$ZPLUG_HOME/init.zsh" ]]; then
  echo "Installing zplug..."
  if [[ ! -d "$ZPLUG_HOME" ]]; then
    mkdir -p "$ZPLUG_HOME"
  fi
  curl --silent --show-error --location --proto-redir -all,https \
    https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
  # in order to wait something that will make zplug available.
  sleep 3s
  ZPLUG_WAS_JUST_INSTALLED=true
fi
source "$ZPLUG_HOME/init.zsh"

zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# From oh-my-zsh
zplug "lib/completion", from:oh-my-zsh
# Gnome already launch ssh-agent.
#zplug "plugins/ssh-agent", from:oh-my-zsh
#zplug "plugins/gpg-agent", from:oh-my-zsh
zplug "plugins/colored-man-pages", from:oh-my-zsh
#zplug "plugins/copybuffer", from:oh-my-zsh
#zplug "plugins/copydir", from:oh-my-zsh
zplug "plugins/docker", from:oh-my-zsh
zplug "plugins/docker-compose", from:oh-my-zsh
# I will use prezto because I need its git related functions on prompt
#zplug "plugins/git-fast", from:oh-my-zsh
zplug "plugins/git-flow-avh", from:oh-my-zsh
#zplug "plugins/httpie", from:oh-my-zsh
#zplug "plugins/pass", from:oh-my-zsh
#zplug "plugins/compleat", from:oh-my-zsh

# From prezto
#source $ZPLUG_REPOS/sorin-ionescu/prezto/init.zsh # ZPLUG-PREZTO-BUG
zplug "modules/editor", from:prezto
zplug "modules/git", from:prezto
zplug "modules/prompt", from:prezto

# From zsh-users
zplug "zsh-users/zsh-syntax-highlighting", defer:2
#zplug "zsh-users/zsh-completions"

# From multiple sources
#zplug "reorx/httpstat", from:github, as:command, use:'httpstat.py', rename-to:'httpstat'
#zplug "sharkdp/fd", from:gh-r, as:command, rename-to:fd, use:"x86_64-unknown-linux-gnu.tar.gz"
#zplug "junegunn/fzf-bin", from:gh-r, as:command, rename-to:fzf, use:"*linux_amd64*"
#zplug "junegunn/fzf", from:github, as:command, rename-to:fzf, hook-build:"./install --all"
# This load only works on the first shell opened just after the installation.
#zplug "junegunn/fzf", from:github, as:plugin, use:"shell/*.zsh"
#zplug "stedolan/jq", from:gh-r, as:command, rename-to:jq
#zplug "supercrabtree/k" " I did not use.
zplug 'tj/git-extras', as:plugin, hook-build:"make install"
zplug "so-fancy/diff-so-fancy", from:github, as:command, rename-to:diff-so-fancy
#zplug 'wfxr/forgit', defer:1
zplug "paulirish/git-open", as:plugin
#zplug "github/hub", from:gh-r, as:command, rename-to:hub
#zplug "mafredri/zsh-async", from:github
#zplug "sharkdp/bat", from:gh-r, as:command, rename-to:cat
#https://github.com/lunaryorn/mdcat/releases
#https://gitlab.com/pepa65/tldr-bash-client

#zplug load --verbose
zplug load

# Install plugins if there are plugins that have not been installed.
# This increases startup time so I will only do it
# if zsh was just installed.
# See https://github.com/zplug/zplug/issues/368
if [[ "$ZPLUG_WAS_JUST_INSTALLED" == true ]]; then
  if ! zplug check --verbose; then
    printf "Install missing plugins? [y/N]: "
    if read; then
      echo
      zplug install
    fi
  fi
fi
#https://github.com/zplug/zplug/issues/509
