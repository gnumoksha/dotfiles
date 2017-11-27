" Vim plugins for PHP development


" StanAngeloff/php.vim is loaded by vim-polyglot.
Plug 'shawncplus/phpcomplete.vim'
Plug 'arnaud-lb/vim-php-namespace'
"Plug 'vim-php/vim-php-refactoring'
Plug 'vim-php/tagbar-phpctags.vim'
let phpctags_exists=expand('~/.vim/bin/phpctags')
if !filereadable(phpctags_exists)
  echo "Installing phpctags..."
  echo ""
  silent !\curl -fLo ~/.vim/bin/phpctags --create-dirs http://vim-php.com/phpctags/install/phpctags.phar
endif

Plug 'rayburgemeestre/phpfolding.vim'
Plug '2072/PHP-Indenting-for-VIm'

"Plug 'vim-php/vim-composer'
"Plug 'wdalmut/vim-phpunit.git'


