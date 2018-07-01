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

" Força a exibição de caracteres não imprimíveis
"set listchars=tab:⇨\ ,eol:⏎,nbsp:☠,trail:•,extends:⟩,precedes:⟨
set listchars=tab:⇨\ ,nbsp:☠,trail:•,extends:⟩,precedes:⟨
set list

" Make File-Open track directory of current file
set browsedir=buffer

"Keep backups of files in case I mess up :)
let s:backupDir = g:vimStuffDir . "/backup"
if !isdirectory(s:backupDir)
  call mkdir(s:backupDir, "", 0700)
endif
let &backupdir=s:backupDir
set backup
set backupcopy=yes

" Where store swap files.
let s:swapDir = g:vimStuffDir . "/swap"
if !isdirectory(s:swapDir)
  call mkdir(s:swpaDir, "", 0700)
endif
" /,. means: use default directory if an error occurs in swapDir
let &directory = s:swapDir . "/,."

" Persistent undo
let s:undoDir = "/tmp/.undodir_" . $USER
if !isdirectory(s:undoDir)
  call mkdir(s:undoDir, "", 0700)
endif
let &undodir=s:undoDir
set undofile

set viminfo='100,n$HOME/.vim/viminfo

" Enable spell checking.
" TODO enable spell checking only in a few file types
"if !filereadable(expand('~/.vim/spell/en.utf-8.sug'))
  "echo "Downloading spell files..."
  "echo ""
  "silent !\curl -fLo ~/.vim/spell/en.utf-8.sug --create-dirs http://ftp.vim.org/vim/runtime/spell/en.utf-8.sug
  "silent !\curl -fLo ~/.vim/spell/en.utf-8.spl --create-dirs http://ftp.vim.org/vim/runtime/spell/en.utf-8.spl

  "silent !\curl -fLo ~/.vim/spell/pt.utf-8.sug --create-dirs http://ftp.vim.org/vim/runtime/spell/pt.utf-8.sug
  "silent !\curl -fLo ~/.vim/spell/pt.utf-8.spl --create-dirs http://ftp.vim.org/vim/runtime/spell/pt.utf-8.spl
"endif
"set spell
"set spellfile=$HOME/.vim/spell/en.utf-8.add,$HOME/.vim/spell/pt.utf-8.add
"set spelllang=en,pt
"}}}

