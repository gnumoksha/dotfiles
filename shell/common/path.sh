###################################
#               PATH              #
###################################
# Para o debian
export PATH="$PATH:/sbin"
export PATH="$PATH:/usr/games"
# PHP composer
export PATH="$PATH:$HOME/.config/composer/vendor/bin"
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

export JAVA_HOME=/opt/apps/gnu+linux/java/jdk
#export PHPSTORM_JDK=$JAVA_HOME

