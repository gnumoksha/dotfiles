"""""""""""""""""""""""""""""""
"                             "
"    Plugins configuration    "
"                             "
"""""""""""""""""""""""""""""""

"""""""""""""""""""
" General purpose
"""""""""""""""""""
"{{{
" scrooloose/nerdtree {{{
"let g:nerdtree_tabs_open_on_gui_startup = 0 " Show vim-startify in a new gvim window without files
" natural sort order will be used
let NERDTreeNaturalSort=1
" the 'wildignore' setting is respected
let NERDTreeRespectWildIgnore=1
" single click will open directory nodes, while a double
" click will still be required for file nodes.
let NERDTreeMouseMode=2
" If set to 1, the NERD tree window will close after opening a file.
let NERDTreeQuitOnOpen=1
" display hidden files by default.
let NERDTreeShowHidden=1
" This options disables the 'Bookmarks' label 'Press ? for help' text.
let NERDTreeMinimalUI=1
" Disables listchars on NERDTree
autocmd filetype nerdtree set listchars=
" Closes vim if the only window left open is a NERDTree.
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Keys mapping
nnoremap <silent> <F3> :NERDTreeToggle<CR>
"}}}

" mhinz/vim-startify {{{
let g:startify_list_order = [
            \ ['   Sessions:'],
            \ 'sessions',
            \ ['   Most recently used files:'],
            \ 'files',
            \ ['   Bookmarks:'],
            \ 'bookmarks',
            \ ['   Commands:'],
            \ 'commands',
            \ ]

let g:startify_files_number = 30
let g:startify_change_to_dir = 1 " When opening a file or bookmark, change to its directory.
let g:startify_change_to_vcs_root = 1 " When opening a file or bookmark, seek and change to the root directory of the VCS.
let g:startify_fortune_use_unicode = 1 " Fortune header uses utf-8.
let g:startify_session_number = 10 " The maximum number of sessions to display.
let g:startify_session_sort = 1 " Sort sessions by modification time.
let g:ascii = [
      \ '  _____ _   _ _    _ ',
      \ ' / ____| \ | | |  | |',
      \ '| |  __|  \| | |  | |',
      \ '| | |_ | . ` | |  | |',
      \ '| |__| | |\  | |__| |',
      \ ' \_____|_| \_|\____/',
      \ '',
      \]
let g:startify_custom_header = 'map(g:ascii, "\"   \".v:val")'
function! StartifyEntryFormat()
    return 'WebDevIconsGetFileTypeSymbol(absolute_path) ." ". entry_path'
endfunction
"}}}

" xolox/vim-session {{{
let g:session_directory = g:vimStuffDir . "/session" " Controls the location of your session scripts.
let g:session_autoload = "no"
let g:session_autosave = "yes"
let g:session_command_aliases = 1 " The names of the commands defined by the session plug-in start with the action they perform, followed by the string 'Session'.
" Keys mapping
nnoremap <leader>so :OpenSession<Space>
nnoremap <leader>ss :SaveSession<Space>
nnoremap <leader>sd :DeleteSession<CR>
nnoremap <leader>sc :CloseSession<CR>
"}}}

" ctrlpvim/ctrlp.vim {{{
" Key mappings
" #TODO compare with fzf
map <silent> <leader>jd :CtrlPTag<cr><c-\>w
"}}}

" junegunn/fzf {{{
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"
" The Silver Searcher
" https://github.com/ggreer/the_silver_searcher
if executable('ag')
  let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
  set grepprg=ag\ --nogroup\ --nocolor
else
    echoerr "Execute: sudo apt install silversearcher-ag"
endif
" ripgrep
" https://github.com/BurntSushi/ripgrep
if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
  set grepprg=rg\ --vimgrep
  command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
endif
" Keys mapping
" Show files in current directory
nnoremap <silent> <leader>e :FZF -m<CR>
nnoremap <silent> <leader>fb :Buffers<CR>
nnoremap <silent> <leader>fc :Commits<CR>
nnoremap <silent> <leader>ff :FZF<CR>
nnoremap <silent> <leader>fh :History<CR>
nnoremap <silent> <leader>fs :Snippets<CR>
nnoremap <silent> <leader>ft :Tags<CR>
nnoremap <silent> <leader>fw :Windows<CR>
" Git SearcH
noremap <Leader>gsh :Commit<CR>

"}}}

" mbbill/undotree {{{
let g:undotree_WindowLayout = 2
let g:undotree_SetFocusWhenToggle = 1 " If set, let undotree window get focus after being opened, otherwise focus will stay in current window.
" Keys mapping
nnoremap <F4> :UndotreeToggle<cr>
"}}}
"}}}

"""""""""""""""""""
" Screen
"""""""""""""""""""
"{{{
" vim-airline {{{
function! s:randnum(max) abort
  return str2nr(matchstr(reltimestr(reltime()), '\v\.@<=\d+')[1:]) % a:max
endfunction
let g:airline_powerline_fonts = 1
" Nice themes: molokai, powerlineish, tomorrow, base16, angr
let s:airline_themes = ['molokai', 'powerlineish', 'tomorrow', 'base16', 'angr']
let g:airline_theme = 'tomorrow'
"let g:airline_theme = s:airline_themes[s:randnum(5)]
let g:airline#extensions#tabline#enabled = 1 " Automatically displays all buffers when there's only one tab open.
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline_skip_empty_sections = 1
"}}}

" junegunn/limelight.vim {{{
autocmd! User GoyoEnter Limelight
" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240
" Color name (:help gui-colors) or RGB color
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_conceal_guifg = '#777777'
"}}}
"}}}

"""""""""""""""""""
" Git
"""""""""""""""""""
"{{{
" tpope/vim-fugitive {{{
" The following autocommand will cause the quickfix window to open after any grep invocation
autocmd QuickFixCmdPost *grep* cwindow
" fugitive-gitlab.vim
"let g:fugitive_gitlab_domains = ['http://gitlab.com']
" tpope/vim-rhubarb
"let g:github_enterprise_urls = ['https://example.com']
" Keys mapping
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
"}}}

" airblade/vim-gitgutter {{{
let g:gitgutter_max_signs = 500  " 500 is the default value
"let g:gitgutter_highlight_lines = 1 " To turn on line highlighting by default
" If you experience a lag, you can trade speed for accuracy:
"let g:gitgutter_realtime = 0
"let g:gitgutter_eager = 0
"}}}
"}}}

"""""""""""""""""""
" Software
" development
"""""""""""""""""""
"{{{
" w0rp/ale {{{
"let g:ale_fix_on_save = 1 " fix files automatically on save.
"let g:ale_completion_enabled = 1 " By now only TypeScript is supported.
"let g:ale_sign_column_always = 1 " keep the sign gutter open at all times
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
let g:ale_echo_msg_error_str = 'E' " is the string used for error severity.
let g:ale_echo_msg_warning_str = 'W' " is the string used for warning severity.
let g:ale_echo_msg_format = '[%linter%] [%severity%] %s' " the format of message echoed by ALE.
let g:ale_set_loclist = 0 " Toggle the loclist use.
let g:ale_set_quickfix = 1 " Toggle the quickfix use.
let g:ale_open_list = 1 " Oppen quickfix when ALE detects errors/warnings.
"let g:ale_keep_list_window_open = 1 " Keep the window open even after errors disappear.
" Put this in vimrc or a plugin file of your own.
" After this is configured, :ALEFix will try and fix your JS code with ESLint.
let g:ale_fixers = {
\   'php': ['phpcbf'],
\}
" Set this setting in vimrc if you want to fix files automatically on save.
" This is off by default.
let g:ale_fix_on_save = 1
let g:airline#extensions#ale#enabled = 1 " enable support for w0rp/ale in vimairline
"}}}

" scrooloose/nerdcommenter {{{
imap <C-/> <plug>NERDCommenterInsert
imap <C-f> <plug>NERDCommenterToggle
"}}}

" Yggdroot/indentLine {{{
let g:indentLine_enabled = 1
let g:indentLine_concealcursor = 0
let g:indentLine_char = '⁞'
let g:indentLine_faster = 1
"}}}

" SirVer/ultisnips {{{
"let g:UltiSnipsExpandTrigger="<tab>" " #TODO configurar uma tecla. Nao nao pode pois uso o youcompleteme
"let g:UltiSnipsJumpForwardTrigger="<tab>"
"let g:UltiSnipsJumpBackwardTrigger="<c-b>"
"let g:UltiSnipsEditSplit="vertical"
"}}}

" ervandew/supertab {{{
"let g:SuperTabDefaultCompletionType = "<c-n>"
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabCrMapping = 1
let g:SuperTabClosePreviewOnPopupClose = 1
"}}}

" ludovicchabant/vim-gutentags {{{
let g:gutentags_cache_dir = '~/.vim/gutentags'
let g:gutentags_ctags_exclude = ['*.css', '*.html', '*.js']
"}}}

" majutsushi/tagbar {{{
let g:tagbar_autofocus = 1
" Keys mapping
nmap <silent> <C-F12> :TagbarToggle<CR>
"}}}

" YouCompleteMe {{{
"nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>
"let g:ycm_always_populate_location_list = 1
"}}}

" Shougo/deoplete.nvim {{{
" Enables automatic completation.
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#jedi#show_docstring = 1
"let g:python_host_prog = '/tmp/neovim_env/bin/python'
"let g:python3_host_prog = '/tmp/neovin_env/bin/python3'
"}}}


""""""""""""""""""
" Misc
"""""""""""""""""""
"{{{
" iamcco/markdown-preview.vim {{{
" path to the chrome or the command to open chrome(or other modern browsers)
" if set, g:mkdp_browserfunc would be ignored
let g:mkdp_path_to_chrome = "/usr/bin/firefox"
" callback vim function to open browser, the only param is the url to open
let g:mkdp_browserfunc = 'MKDP_browserfunc_default'
" set to 1, the vim will open the preview window once enter the markdown
" buffer
let g:mkdp_auto_start = 0
" set to 1, the vim will auto open preview window when you edit the
" markdown file
let g:mkdp_auto_open = 0
" set to 1, the vim will auto close current preview window when change
" from markdown buffer to another buffer
let g:mkdp_auto_close = 1
" set to 1, the vim will just refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
let g:mkdp_refresh_slow = 0
" set to 1, the MarkdownPreview command can be use for all files,
" by default it just can be use in markdown file
let g:mkdp_command_for_global = 0
" Keys mapping
nmap <silent> <F8> <Plug>MarkdownPreview        " for normal mode
imap <silent> <F8> <Plug>MarkdownPreview        " for insert mode
nmap <silent> <F9> <Plug>StopMarkdownPreview    " for normal mode
imap <silent> <F9> <Plug>StopMarkdownPreview    " for insert mode
"}}}

" plasticboy/vim-markdown {{{
"let g:vim_markdown_folding_disabled = 1
"let g:vim_markdown_folding_style_pythonic = 1
let g:vim_markdown_folding_level = 2
set conceallevel=2
let g:vim_markdown_fenced_languages = ['c++=cpp', 'viml=vim', 'bash=sh', 'ini=dosini', 'csharp=cs', 'php']
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_json_frontmatter = 1
"}}}
"}}}


