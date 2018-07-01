
"""""""""""""""""""""""""""""""
"                             "
"        Keys mapping         "
"                             "
"""""""""""""""""""""""""""""""
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

" scrooloose/nerdtree
nnoremap <silent> <F3> :NERDTreeToggle<CR>

" mbbill/undotree
nnoremap <F4> :UndotreeToggle<cr>

" MarkdownPreview
nmap <silent> <F8> <Plug>MarkdownPreview        " for normal mode
imap <silent> <F8> <Plug>MarkdownPreview        " for insert mode
nmap <silent> <F9> <Plug>StopMarkdownPreview    " for normal mode
imap <silent> <F9> <Plug>StopMarkdownPreview    " for insert mode

" ,p alterna o modo paste
" parece que é melhor que pastetoggle
"nmap <leader>p :set paste!<BAR>set paste?<CR>
noremap YY "+y<CR>
noremap <leader>p "+gP<CR>
noremap XX "+x<CR>

" cd. muda para o diretorio do arquivo atual
"cmap cd. lcd %:p:h

" majutsushi/tagbar
nmap <silent> <C-F12> :TagbarToggle<CR>

" Save current file [09]
noremap <C-S> :update<CR>
vnoremap <C-S> <C-C>:update<CR>
inoremap <C-S> <C-O>:update<CR>

" Switching windows
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

" Buffer Prev
noremap <silent> <leader>bp :bp<CR>
" Buffer Next
noremap <silent> <leader>bn :bn<CR>
" Buffer Close
noremap <silent> <leader>bc :bd<CR>

" abre o console de erro
"map <leader>cc :botright cope<CR>

" Set working directory
nnoremap <leader>cd :lcd %:p:h<CR>

" Diff Get Right
noremap <Leader>dgr :diffget RE<CR>
" Diff Get Base
noremap <Leader>dgb :diffget BA<CR>
" Diff Get Left
noremap <Leader>dgl :diffget LO<CR>

" Executa fzf -m que exibe os arquivos no diretorio atual
nnoremap <silent> <leader>e :FZF -m<CR>

" junegunn/fzf.vim
nnoremap <silent> <leader>fb :Buffers<CR>
nnoremap <silent> <leader>fc :Commits<CR>
nnoremap <silent> <leader>ff :FZF<CR>
nnoremap <silent> <leader>fh :History<CR>
nnoremap <silent> <leader>fs :Snippets<CR>
nnoremap <silent> <leader>ft :Tags<CR>
nnoremap <silent> <leader>fw :Windows<CR>

" Git
noremap <Leader>ga :Gwrite<CR>
" Git COmmit
noremap <Leader>gco :Gcommit<CR>
"noremap <Leader>gsh :Gpush<CR>
"noremap <Leader>gll :Gpull<CR>
" Git STatus
noremap <Leader>gst :Gstatus<CR>
" Git BLame
noremap <Leader>gbl :Gblame<CR>
" Git DIff
noremap <Leader>gdi :Gvdiff<CR>
" Git REmove
noremap <Leader>gre :Gremove<CR>
" Git Open Browser
nnoremap <Leader>gob :.Gbrowse<CR>
" Git SearcH - powered by FZF
noremap <Leader>gsh :Commit<CR>

" ctrlpvim/ctrlp.vim
" #TODO needs comparison with fzf
map <silent> <leader>jd :CtrlPTag<cr><c-\>w

" Clean search highlight
nnoremap <silent> <leader>n :noh<cr>

" Execute (run) current file
nnoremap <leader>r :!"%:p"<CR>

" Session management
nnoremap <leader>so :OpenSession<Space>
nnoremap <leader>ss :SaveSession<Space>
nnoremap <leader>sd :DeleteSession<CR>
nnoremap <leader>sc :CloseSession<CR>

" Split
noremap <Leader>sp :<C-u>split<CR>
noremap <Leader>sv :<C-u>vsplit<CR>

" Shougo/vimshell
nnoremap <silent> <leader>sl :VimShellCreate<CR>

" Tabs
nnoremap <Tab> gt
nnoremap <S-Tab> gT
nnoremap <silent> <S-t> :tabnew<CR>

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

