#|
#| Oh My Zsh configuration file
#|

export ZSH="${XDG_CACHE_HOME}/zsh/oh-my-zsh"

if [[ ! -e "${ZSH}/oh-my-zsh.sh" ]]; then
	echo "Installing oh-my-zsh..."
	git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git "${ZSH}"
fi

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#
# Nice simple themes: risto, gentoo, gianu, alanpeabody, daveverwer,
# dieter, maran, miloshadzic, wezm
ZSH_THEME="gnumoksha"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Do not use case-sensitive completion.
CASE_SENSITIVE="false"

# Use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Enable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="false"

# How often to auto-update (in days).
export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Disable command auto-correction.
ENABLE_CORRECTION="false"

# Display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM="${0:a:h}/custom"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
#
# 2017-10-20 - Tobias - I've checked on-my-zsh and those are the useful plugins:
# colored-man-pages composer copybuffer copydir docker docker-compose
# git git-flow-avh git-extras
# gpg-agent history-substring-search httpie nmap npm pass pip
# redis-cli rsync screen shrink-path ssh-agent systemadmin tmux
# vi-mode virtualenv
# Repository: https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins
plugins=(git-flow-avh)

source "${ZSH}/oh-my-zsh.sh"

#|
#| References
#|
# https://github.com/robbyrussell/oh-my-zsh/blob/master/templates/zshrc.zsh-template

