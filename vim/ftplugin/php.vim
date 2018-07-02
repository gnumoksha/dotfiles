""""""""""""""""""""""""""""""""""""""""""
"                                        "
"       VIM configuration file for       "
"            PHP development             "
"                                        "
""""""""""""""""""""""""""""""""""""""""""

" For smart indentation without tabs
setlocal smartindent expandtab shiftwidth=4 softtabstop=4 tabstop=8

setlocal textwidth=120 "	Maximum width of text that is being inserted
setlocal colorcolumn=+1 " highlight column after 'textwidth'

"set omnifunc=phpcomplete#CompletePHP

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
let g:DisableAutoPHPFolding = 1
" Include the '$' as part of identifiers.
"let php_var_selector_is_identifier = 1
" Indent 'case:' and 'default:' statements in switch() blocks:
"let g:PHP_vintage_case_default_indent = 1

" w0rp/ale
"let g:ale_php_phpcs_executable="~/.config/composer/vendor/bin/phpcs"
let g:ale_php_phpcs_standard='PSR2'
"let g:ale_php_phpmd_executable="~/.config/composer/vendor/bin/phpmd"
let g:ale_php_phpmd_ruleset='cleancode,codesize,controversial,design,naming,unusedcode'
"let g:ale_php_phpstan_executable="~/.config/composer/vendor/bin/phpstan"
"let g:ale_php_phpstan_configuration=/tmp/a
"let g:ale_php_phan_executable="~/.config/composer/vendor/bin/phan"

