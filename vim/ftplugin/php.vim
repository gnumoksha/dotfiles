""""""""""""""""""""""""""""""""""""""""""
"                                        "
"       VIM configuration file for       "
"            PHP development             "
"                                        "
""""""""""""""""""""""""""""""""""""""""""

" For indentation without tabs
" FIXME only work if there is 'expandtab' in .vimrc
" Copied from vim80/ftdetect/python.vim
setlocal expandtab shiftwidth=4 softtabstop=4 tabstop=8

"""""""""""""""""""""""""""""""
"                             "
"    Plugins configuration    "
"                             "
"""""""""""""""""""""""""""""""
" StanAngeloff/php.vim (loaded by vim-polyglot)
function! PhpSyntaxOverride()
  hi! def link phpDocTags  phpDefine
  hi! def link phpDocParam phpType
endfunction
augroup phpSyntaxOverride
  autocmd!
  autocmd FileType php call PhpSyntaxOverride()
augroup END

" vim-php/tagbar-phpctags.vim
let g:tagbar_phpctags_bin='~/.vim/bin/phpctags'

" Don't use the PHP syntax folding.
"let g:DisableAutoPHPFolding = 1
" Include the '$' as part of identifiers.
"let php_var_selector_is_identifier = 1
" Indent 'case:' and 'default:' statements in switch() blocks:
"let g:PHP_vintage_case_default_indent = 1

