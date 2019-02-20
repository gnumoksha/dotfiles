
"""""""""""""""""""""""""""""""
"                             "
" Keys mapping for built-in   "
" vim features                "
"                             "
"""""""""""""""""""""""""""""""
" Keys mapping for plugins is on plugins_config.vim file.
"{{{
" The idea with this function is to be like a complete refresh of vim.
if !exists('*MyReload')
  function! MyReload()
    echom "Reloading VIM..."
    source ~/.vimrc " Reload vimrc
    filetype detect " force file type detection
    echom "VIM reloaded."
  endfunction
endif
"nnoremap <F5> :call MyReload()<CR>
nnoremap <F5> :so ~/.vimrc<CR>

" Leader key
"let mapleader=","
"let g:mapleader=","
" [ref 07]
map <space> <leader>
map <space><space> <leader><leader>

"Ao inves de usar : use ; que nao precisa do shift
nnoremap ; :

" Avoid some common mistakes
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

" Press i to enter insert mode, and ii to exit.
imap ii <Esc>

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Faz com que blocos selecionados sejam reselecionados após identações
vnoremap < <gv
vnoremap > >gv

" ,p alterna o modo paste
" parece que é melhor que pastetoggle
"nmap <leader>p :set paste!<BAR>set paste?<CR>
noremap YY "+y<CR>
noremap <leader>p "+gP<CR>
noremap XX "+x<CR>

" cd. muda para o diretorio do arquivo atual
"cmap cd. lcd %:p:h

" Save current file [09]
noremap <C-S> :w<CR>
vnoremap <C-S> <C-C>:w<CR>
inoremap <C-S> <C-O>:w<CR>

" Quit vim with C-Q
noremap <C-Q> :qa<CR>
vnoremap <C-Q> <C-C>:qa<CR>
inoremap <C-Q> <C-O>:qa<CR>

" Switching windows
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

" https://github.com/amix/vimrc#spell-checking
map <leader>ss :setlocal spell!<cr>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=
"
map <leader>es :botright cope<cr>
"map <leader>co ggVGy:tabnew<cr>:set syntax=qf<cr>pgg
map <leader>en :cn<cr>
map <leader>ep :cp<cr>

" Set working directory
nnoremap <leader>cd :lcd %:p:h<CR>

" Diff Get Right
" #TODO Seria bom usar apenas o `do` e `dp`. se for git repo, usar diffget, se nao,
" usar normal. o diffget nao parece ser de plugin.
noremap <Leader>dgr :diffget RE<CR>
" Diff Get Base
noremap <Leader>dgb :diffget BA<CR>
" Diff Get Left
noremap <Leader>dgl :diffget LO<CR>

" Clean search highlight
nnoremap <silent> <leader>n :noh<cr>

" Execute (run) current file
nnoremap <leader>r :!"%:p"<CR>

" Split
noremap <Leader>sp :<C-u>split<CR>
noremap <Leader>sv :<C-u>vsplit<CR>

" Tabs
nnoremap <silent> <Tab> gt
nnoremap <silent> <S-Tab> gT
nnoremap <silent> <C-t> :tabnew<CR>
nnoremap <silent> <A-t> :tabnew<CR>
nnoremap <silent> <A-w> :close<CR> " Ctrl + w c

" SmartHome
" Pressing the Home key moves the cursor to the first nonblank character on
" the line, or, if already at that position, to the start of the line.
function! SmartHome()
  let first_nonblank = match(getline('.'), '\S') + 1
  if first_nonblank == 0
    return col('.') + 1 >= col('$') ? '0' : '^'
  endif
  if col('.') == first_nonblank
    return '0'  " if at first nonblank, go to start line
  endif
  return &wrap && wincol() > 1 ? 'g^' : '^'
endfunction
noremap <expr> <silent> <Home> SmartHome()
imap <silent> <Home> <C-O><Home>
"}}}

"""""""""""""""""""""""""""""""
"                             "
"        Main References      "
"                             "
"""""""""""""""""""""""""""""""
" 09 http://vim.wikia.com/wiki/Map_Ctrl-S_to_save_current_or_new_files

