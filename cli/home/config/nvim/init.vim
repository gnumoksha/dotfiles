"
" NeoVim Configuration
"
let g:vimConfigDir = $XDG_CONFIG_HOME . "/nvim"
let g:vimCacheDir = $XDG_CACHE_HOME . "/nvim"
let g:plugFile = $XDG_DATA_HOME . "/nvim/site/autoload/plug.vim"
let g:plugDir = g:vimCacheDir . "/plugged"
" Vim plug does not accept script vars
"let g:myBinDir = "/usr/local/bin"
let g:zplugHome = $XDG_DATA_HOME . "/zplug"
" This var is used to load plugins only for those programming languages.
let g:myLangs = ['go', 'html', 'javascript', 'perl', 'php', 'python', 'sh', 'vim']
let g:startify_session_dir = g:vimConfigDir . "/session"

set runtimepath+=$XDG_CONFIG_HOME/vim,$VIMRUNTIME,$XDG_CONFIG_HOME/vim/after
runtime config.d/00-general.vim
runtime config.d/10-plugins-load.vim
runtime config.d/11-plugins-config.vim
runtime config.d/20-keys-mapping.vim
runtime config.d/21-screen.vim

