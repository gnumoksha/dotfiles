
if [[ -n "$ZSH_VERSION" && -f ~/.fzf.zsh ]]; then
  source ~/.fzf.zsh
elif [[ -n "$BASH_VERSION" && -f ~/.fzf.bash ]]; then
  source ~/.fzf.bash
fi

# Setting fd as the default source for fzf
if [ $(command -v fd) ]; then
  FZF_DEFAULT_COMMAND='fd --type f'
else
   FZF_DEFAULT_COMMAND='find --type f'
fi
export FZF_DEFAULT_COMMAND
# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --inline-info'

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

# fkill - kill process
fkill() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs kill -${1:-9}
  fi
}
# fco_preview - checkout git branch/tag, with a preview showing the commits between the tag/branch and HEAD
fco_preview() {
  local tags branches target
  tags=$(
git tag | awk '{print "\x1b[31;1mtag\x1b[m\t" $1}') || return
  branches=$(
git branch --all | grep -v HEAD |
sed "s/.* //" | sed "s#remotes/[^/]*/##" |
sort -u | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}') || return
  target=$(
(echo "$tags"; echo "$branches") |
    fzf --no-hscroll --no-multi --delimiter="\t" -n 2 \
        --ansi --preview="git log -200 --pretty=format:%s $(echo {+2..} |  sed 's/$/../' )" ) || return
  git checkout $(echo "$target" | awk '{print $2}')
}
# change to the directory of the file
cdf() {
   local file
   local dir
   file=$(fzf +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
}

# inspired by https://gist.github.com/f440/9992963
fzf-pass-widget() {
	CMD=$1
	show_pass_files() {
		local password_store=${PASSWORD_STORE_DIR-~/.password-store}
		cd "$password_store" > /dev/null
		find . -type f ! -name .gpg-id | sed -e 's/\.\/\(.*\).gpg$/\1/'
	}
	local FILE=$(show_pass_files | fzf)
	[ -n "$FILE" ] && pass $CMD $FILE

	zle reset-prompt
}

fzf-pass-copy-widget() {
	fzf-pass-widget "-c"
}

fzf-pass-show-widget() {
	fzf-pass-widget "show"
}

# TODO is it possible just pass the arg on zle?
fzf-pass-edit-widget() {
	fzf-pass-widget "edit"
}

#  colocar no KDB:
# showkey -a
#bindkey -s '^Xm' "My mistress\' eyes are nothing like the sun."

if [ -n "$ZSH_VERSION" ]; then
  zle     -N    fzf-pass-copy-widget
  bindkey '^Pc' fzf-pass-copy-widget
  zle     -N    fzf-pass-edit-widget
  bindkey '^Pe' fzf-pass-edit-widget
  zle     -N    fzf-pass-show-widget
  bindkey '^Ps' fzf-pass-show-widget

fi

#TODO for bash
# TODO fzf has modifiers? Send c/e/s to fzf.
#TODO copy login too (as second register?)

