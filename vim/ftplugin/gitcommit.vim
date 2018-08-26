set syntax
"plugin indenting on
set spell
set spelllang=en
set textwidth=72

" from /usr/share/vim/vim81/defaults.vim
augroup vimStartup | au! | augroup END

" Save and quit
noremap <C-S> :wq<CR>
vnoremap <C-S> <C-C>:wq<CR>
inoremap <C-S> <C-O>:wq<CR>

