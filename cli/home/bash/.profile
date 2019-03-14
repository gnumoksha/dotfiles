#
# User-specific configuration
#
# https://www.debian.org/doc/manuals/debian-reference/ch07.en.html#_starting_the_x_window_system
# https://en.wikipedia.org/wiki/Unix_shell#Configuration_files

# Create a shortcut to my dotfiles.
hash -d DOTFILES="$DOTFILES"

# EDITOR contains the command to run the lightweight program used for editing
#   files.
# VISUAL contains command to run the full-fledged editor that is used for more
#   demanding tasks, such as editing email (e.g., vi, vim, emacs etc).
# BROWSER contains the path to the web browser.
if [ -n "$DISPLAY" ]; then
    export EDITOR=vim
    export VISUAL=gvim
    export BROWSER=firefox
else
    export EDITOR=vim
    export VISUAL=vim
    export BROWSER=links
fi

#
# Golang
#
# GOPATH environment variable specifies the location of your workspace.
export GOPATH="$XDG_DATA_HOME/golang/workspace"
# Set the GOBIN path to generate a binary file when go install is run.
export GOBIN="$GOPATH/bin"
# If go is not in /usr/local/go, specify where it is.
export GOROOT=/usr/lib/go-1.9
PATH="$PATH:$GOROOT/bin:$GOBIN"

#
# PHP
#
# Composer
PATH="$PATH:$HOME/.config/composer/vendor/bin"

#
# Python
#
PATH="$PATH:$HOME/.local/bin"

#
# Rust-lang
#
export CARGO_HOME="$XDG_CONFIG_HOME/cargo"
[ -d /usr/lib/cargo/bin ] && PATH="$PATH:/usr/lib/cargo/bin"

# finally export the path
export PATH

#EOF
