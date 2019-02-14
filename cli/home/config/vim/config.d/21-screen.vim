"""""""""""""""""""""""""""""""
"                             "
"           Screen            "
"                             "
"""""""""""""""""""""""""""""""
"{{{
syntax on
set number " shows line number
set relativenumber " shows line number relative to the current line

set mouse=a
set mousefocus
set nomousehide
set mousemodel=popup_setpos
set t_Co=256
set guioptions=egmrti
set gfn=Hack\ 12
set signcolumn=yes " Always show sign column.

"autocmd FileType markdown colorscheme molokai
"autocmd FileType markdown :AirlineRefresh
" ggdG
" gg=G

" If you prefer the scheme to match the original monokai background color.
"let g:molokai_original = 1
" Alternative scheme under development for color terminals which attempts to bring the 256
" color version as close as possible to the the default (dark) GUI version.
"let g:rehash256 = 1

colorscheme onedark
"colorscheme gruvbox

" Matches the terminal colors
" Do not set this https://github.com/tmux/tmux/issues/699
"set termguicolors

"" Disable the blinking cursor.
"set gcr=a:blinkon0
set scrolloff=3

"" Use modeline overrides
set modeline
set modelines=10

set title
set titleold="Terminal"
" :h statusline
set titlestring="%F%m %Y"
" This is nice, but makes scrolling very slow
"set title titlestring=...%{strpart(expand(\"%:p:h\"),stridx(expand(\"%:p:h\"),\"/\",strlen(expand(\"%:p:h\"))-12))}%=%n.\ \ %{expand(\"%:t:r\")}\ %m\ %Y\ \ \ \ %l\ of\ %L " [ref05]

set showcmd

" Faz com que o vim pule para a posição no arquivo onde se parou na última
" fez que ele foi aberto
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Quando um bracket eh inserido, saltar rapidamente para o seu primeiro
" correspondente. O salto só ocorre se o correspondente pode ser visto na
" tela atual. Para definir por quanto tempo o salto ocorrera, use 'matchtime'
set showmatch
set colorcolumn=120
set cursorline " Destaca a linha onde o cursor está.

" airline already shows the current vim mode.
set noshowmode
"set cmdheight=1
"set laststatus=0


" Igora case sensitive durante as buscas
set ignorecase
" Ignora a opcao 'ignorecase' se o texto a ser buscado contem caracteres
" maiusculos
set smartcase
" Quando há uma padrao de uma pesquisa anterior, destaque todos os resultados
set hlsearch
" Busca incremental. Vai buscando e mostrando os resultados conforme se
" vai digitando o texto a buscar.
set incsearch

" Default indent with tabs. [ref 08]
" Changes the width of the TAB character.
set tabstop=4
" Affects what happens when you press >>, << or ==. It also affects how
" automatic indentation works.
"set shiftwidth=4
" Affects what happens when you press the <TAB> or <BS> keys.
" Its default value is the same as the value of 'tabstop'.
"set softtabstop=0
" Affects what happens when you press the <TAB> key.
" If 'expandtab' is set, pressing the <TAB> key will always
" insert 'softtabstop' amount of space characters.
" Otherwise, the amount of spaces inserted is minimized
" by using TAB characters.
"set expandtab

" Configure vimdiff
if &diff
    colorscheme apprentice

    set diffopt+=iwhite
    set diffexpr=""
endif

" Ignore whitespace on diff
" https://stackoverflow.com/a/4271247/4668660
"set diffopt+=iwhite
"set diffexpr=DiffW()
"function DiffW()
  "let opt = ""
   "if &diffopt =~ "icase"
     "let opt = opt . "-i "
   "endif
   "if &diffopt =~ "iwhite"
     "let opt = opt . "-w " " swapped vim's -b with -w
   "endif
   "silent execute "!diff -a --binary " . opt .
     "\ v:fname_in . " " . v:fname_new .  " > " . v:fname_out
"endfunction

" Removes | in window separator
" https://stackoverflow.com/questions/9001337/vim-split-bar-styling
"set fillchars+=vert:\ 
"}}}

