"""""""""""""""""""""""""""""""
"                             "
"    General configurations   "
"                             "
"""""""""""""""""""""""""""""""
"{{{
" http://stackoverflow.com/questions/5845557/in-a-vimrc-is-set-nocompatible-completely-useless
set nocompatible

" Enable hidden buffers
set hidden

" Enable filetype detection, plugin and indent loading for specific file
" types.
filetype plugin indent on

" Disable visualbell
set noerrorbells visualbell t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif

"" Copy/Paste/Cut
if has('unnamedplus')
  set clipboard=unnamed,unnamedplus
endif

" Recarrega automaticamente arquivos que foram alterados no disco
set autoread

"" Encoding
set encoding=utf-8
set fileencoding=utf-8
"set bomb
"set binary
set ttyfast
" nao funciona no nvim
"set ttymouse=xterm2

"" Fix backspace indent
set backspace=indent,eol,start

" http://vim.wikia.com/wiki/Make_Vim_completion_popup_menu_work_just_like_in_an_IDE
" https://github.com/ncm2/ncm2#install
" suppress the annoying 'match x of y', 'The only match' and 'Pattern not found' messages
set shortmess+=c
"set completeopt=noinsert,longest,menuone
set completeopt=menu,menuone,preview,noinsert,noselect
" Enter select first option
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Remap code completion to Ctrl+Space {{{
inoremap <Nul> <C-x><C-o>
inoremap <Nul> <C-n>
"}}}
" Autocomplete with TAB {{{
"inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"}}}
" Workflow: ao difigitar ir exibindo as sugestoes mas sem
" selecionar. Ao precisar enter ou control+space completar
" com a primeira sugestao. Backspace apos isso deleta esse autocomplete.
" Talvez digitar control+space para chamar o autocomplete ja ajude, ai
" depois uso control+pace para selecionar.
"Read some more on :help popupmenu-keys or :help ins-completion

set concealcursor=nc
" Show confirmation when exiting an unsaved buffer.
set confirm

" For airblade/vim-gitgutter
set updatetime=100

" Show non printable characters
"set listchars=tab:⇨\ ,eol:⏎,nbsp:☠,trail:•,extends:⟩,precedes:⟨
set listchars=tab:⇨\ ,nbsp:☠,trail:•,extends:⟩,precedes:⟨
set list

" Make File-Open track directory of current file
set browsedir=buffer

"Keep backups of files in case I mess up :)
let s:backupDir = g:vimCacheDir . "/backup"
if !isdirectory(s:backupDir)
  call mkdir(s:backupDir, "", 0700)
endif
let &backupdir=s:backupDir
set backup
set backupcopy=yes

" Where store swap files.
let s:swapDir = g:vimCacheDir . "/swap"
if !isdirectory(s:swapDir)
  call mkdir(s:swapDir, "", 0700)
endif
" /,. means: use default directory if an error occurs in swapDir
let &directory = s:swapDir . "/,."

" Persists undo while computer is on
"let s:undoDir = "/tmp/.undodir_" . $USER
let s:undoDir = g:vimCacheDir . "/undo"
if !isdirectory(s:undoDir)
  call mkdir(s:undoDir, "", 0700)
endif
let &undodir=s:undoDir
set undofile
set undolevels=10000

if has('nvim')
  set viminfo+='1000,n$XDG_CACHE_HOME/nvim/viminfo
else
  set viminfo+='1000,n$XDG_CACHE_HOME/vim/viminfo
endif

" Session
" If you don't want help windows to be restored:
set sessionoptions-=help
" Don't save hidden and unloaded buffers in sessions.
set sessionoptions-=buffers

" Enable spell checking.
"if !filereadable(expand('~/.vim/spell/en.utf-8.sug'))
  "echo "Downloading spell files..."
  "echo ""
  "silent !\curl -fLo ~/.vim/spell/en.utf-8.sug --create-dirs http://ftp.vim.org/vim/runtime/spell/en.utf-8.sug
  "silent !\curl -fLo ~/.vim/spell/en.utf-8.spl --create-dirs http://ftp.vim.org/vim/runtime/spell/en.utf-8.spl

  "silent !\curl -fLo ~/.vim/spell/pt.utf-8.sug --create-dirs http://ftp.vim.org/vim/runtime/spell/pt.utf-8.sug
  "silent !\curl -fLo ~/.vim/spell/pt.utf-8.spl --create-dirs http://ftp.vim.org/vim/runtime/spell/pt.utf-8.spl
"endif
""set spell
"set spellfile=$HOME/.vim/spell/en.utf-8.add,$HOME/.vim/spell/pt.utf-8.add
"set spelllang=en,pt
"}}}

" For spell checking
set mousemodel=popup_setpos

