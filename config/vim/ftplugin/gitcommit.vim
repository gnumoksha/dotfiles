
" Tip: use ":cq" to exit the commit while typing the commit message.

setlocal spell
setlocal spelllang=en
setlocal textwidth=72

" Colour the 51st column (for titles).
setlocal colorcolumn+=51

" Always start on first line
" https://vim.fandom.com/wiki/Always_start_on_first_line_of_git_commit_message
"call setpos('.', [0, 1, 1, 0])
au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

" Control+s save and quit
noremap <C-S> :wq<CR>
vnoremap <C-S> <C-C>:wq<CR>
inoremap <C-S> <C-O>:wq<CR>

