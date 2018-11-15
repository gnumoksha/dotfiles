###################################
#               PATH              #
###################################

# https://specifications.freedesktop.org/basedir-spec/basedir-spec-0.6.html
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

# For Debian
export PATH="$PATH:/sbin"
export PATH="$PATH:/usr/games"
# PHP composer
export PATH="$PATH:$HOME/.config/composer/vendor/bin"
export MY_BIN_DIR="/usr/local/bin"
# Binarios extras sem instalador para debian
export PATH="$MY_BIN_DIR:$PATH"
# Python
export PATH="$PATH:$HOME/.local/bin"

# For Golang
# GOPATH environment variable specifies the location of your workspace.
export GOPATH=$HOME/play/go/ws
# Set the GOBIN path to generate a binary file when go install is run.
export GOBIN=$GOPATH/bin
# If go is not in /usr/local/go, specify where it is.
export GOROOT=/usr/lib/go-1.9
export PATH="$PATH:$GOROOT/bin:$GOBIN"

# For rust-lang
export CARGO_HOME="$HOME/.config/cargo"
#export PATH="$PATH:$HOME/play/rust/cargo/bin"

export JAVA_HOME=/opt/apps/gnu+linux/java/jdk
#export PHPSTORM_JDK=$JAVA_HOME

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

export PAGER=most

