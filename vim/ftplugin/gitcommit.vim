
setlocal spell
setlocal spelllang=en
setlocal textwidth=72

" Do not jump to the last known cursor position when editing a file.
" Taken from /usr/share/vim/vim81/defaults.vim
augroup vimStartup | au! | augroup END

" Control+s save and quit
noremap <C-S> :wq<CR>
vnoremap <C-S> <C-C>:wq<CR>
inoremap <C-S> <C-O>:wq<CR>

