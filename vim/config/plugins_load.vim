"""""""""""""""""""""""""""""""
"                             "
"         Load plugins        "
"                             "
"""""""""""""""""""""""""""""""
"{{{
if !filereadable(g:plugFile)
  echo "Installing Vim-Plug..."
  echo ""
  execute ':!curl --fail --location --create-dirs --output ' . s:plugFile . ' https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

  autocmd VimEnter * PlugInstall
endif

call plug#begin(g:plugDir)
  """""""""""""""""""
  " General purpose
  """""""""""""""""""
  "{{{
  Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' } " A tree explorer plugin for vim.
    Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' } " A plugin of NERDTree showing git status.
  " Plug 'jistr/vim-nerdtree-tabs' " TODO this plugin is not necessary https://github.com/scrooloose/nerdtree#faq
  Plug 'mhinz/vim-startify' " The fancy start screen for Vim.
  Plug 'xolox/vim-misc' " Miscellaneous auto-load Vim scripts (for vim-session).
    Plug 'xolox/vim-session' " Extended session management for Vim (:mksession on steroids).
"  Plug 'Shougo/vimproc.vim', { 'do': 'make' } " Interactive command execution in Vim (for vimshell).
"    Plug 'Shougo/vimshell.vim' " Powerful shell implemented by vim.
  " CtrlPMixed seems nice
  Plug 'ctrlpvim/ctrlp.vim' " Active fork of kien/ctrlp.vim—Fuzzy file, buffer, mru, tag, etc finder.
  Plug 'junegunn/fzf', { 'dir': g:myBinDir . '/fzf', 'do': './install --all' } " A command-line fuzzy finder.
    Plug 'junegunn/fzf.vim' " Vim plugin for FZF: a command-line fuzzy finder. TODO estudar mais este plugin. Ele é muito bom!
  Plug 'sheerun/vim-polyglot' " A solid language pack for Vim.
  Plug 'tpope/vim-sleuth' " Automatically adjusts 'shiftwidth' and 'expandtab' heuristically.
  Plug 'mbbill/undotree' " The ultimate undo history visualizer for VIM.
  Plug 'https://git.zx2c4.com/password-store', { 'rtp': 'contrib/vim/noplaintext.vim' } " Prevent various Vim features from keeping the contents of passwordstore.org.
  Plug 'xolox/vim-notes' " Easy note taking in Vim.
  "Plug 'chrisbra/Recover.vim' " A Plugin to show a diff, whenever recovering a buffer.
  "}}}

  """""""""""""""""""
  " Screen
  """""""""""""""""""
  "{{{
  Plug 'vim-airline/vim-airline' " lean & mean status/tabline for vim that's light as air.
    Plug 'vim-airline/vim-airline-themes' " A collection of themes for vim-airline.
  Plug 'junegunn/goyo.vim' " Distraction-free writing in Vim .
    Plug 'junegunn/limelight.vim' " Hyperfocus-writing in VimHyperfocus-writing in Vim.
  Plug 'ryanoasis/vim-devicons' " Adds file type glyphs/icons to popular Vim plugins.
  "}}}

  """""""""""""""""""
  " Git
  """""""""""""""""""
  "{{{
  Plug 'tpope/vim-fugitive' " a Git wrapper so awesome, it should be illegal.
    "Plug 'tpope/vim-rhubarb' " GitHub extension for fugitive.vim
    "Plug 'shumphrey/fugitive-gitlab.vim' " An extension to fugitive.vim for gitlab support
  Plug 'gregsexton/gitv', {'on': ['Gitv']} " gitk for Vim.
  Plug 'airblade/vim-gitgutter' " A Vim plugin which shows a git diff in the gutter (sign column) and stages/undoes hunks.
  "}}}

  """""""""""""""""""
  " Software
  " development
  """""""""""""""""""
  "{{{
  "Plug 'vim-syntastic/syntastic' " Syntax checking hacks for vim. (conflicts with 'w0rp/ale')
  " Highlights trailing whitespace in red and provides :FixWhitespace to fix it. ('w0rp/ale' does the same)
  "Plug 'bronson/vim-trailing-whitespace'
  Plug 'w0rp/ale' " Asynchronous Lint Engine.
  Plug 'ntpeters/vim-better-whitespace', {'for': g:myLangs}
  Plug 'scrooloose/nerdcommenter' " Vim plugin for intensely orgasmic commenting.
  Plug 'Yggdroot/indentLine' " Display the indention levels with thin vertical lines.
  Plug 'junegunn/vim-easy-align' " A Vim alignment plugin. # TODO estudar
  "Plug 'tpope/vim-surround' " Quoting/parenthesizing made simple. # TODO conferir se preciso ou se o outro plugin é melhor
  Plug 'SirVer/ultisnips', {'for': g:myLangs} " The ultimate snippet solution for Vim.
    Plug 'honza/vim-snippets', {'for': g:myLangs} " Snippets files for various programming languages.
  Plug 'ervandew/supertab' " Perform all your vim insert mode completions with Tab.
  Plug 'ludovicchabant/vim-gutentags', {'for': g:myLangs} " A Vim plugin that manages your tag files.
  Plug 'majutsushi/tagbar', {'for': g:myLangs} " Displays tags in a window, ordered by scope.
  Plug 'tpope/vim-db'
  " A code-completion engine for Vim.
  " 2017-11-27 - Tobias - PHP support is insufficient.
  " Must have: apt-get install build-essential cmake python-dev python3-dev
  " Nice to have: apt-get install golang nodejs npm
  "Plug 'Valloric/YouCompleteMe', { 'do': './install.py --go-completer --js-completer' }
  " deoplete: Dark powered asynchronous completion framework for neovim/Vim8.
  if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  else
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
  endif
  "Plug 'ekalinin/Dockerfile.vim' " Vim syntax file & snippets for Docker's Dockerfile.
  Plug 'jiangmiao/auto-pairs' " Insert or delete brackets, parens, quotes in pair.
  Plug 'andymass/vim-matchup', {'for': g:myLangs} " Navigate and highlight matching words. Modern matchit and matchparen replacement.
  "Plug 'jaxbot/semantic-highlight.vim' " Where every variable is a different color.
  Plug 'janko-m/vim-test', {'for': g:myLangs} " Run your tests at the speed of thought.
  "Plug 'terryma/vim-multiple-cursors' " True Sublime Text style multiple selections for Vim.

  " PHP {{{
  " StanAngeloff/php.vim is loaded by vim-polyglot.
  "Plug 'shawncplus/phpcomplete.vim' " Improved PHP omnicompletion
  Plug 'lvht/phpcd.vim', {'for': 'php'} " A Intelligent/Smart PHP Complete Daemon Plugin for Vim/NeoVim
  Plug 'arnaud-lb/vim-php-namespace', {'for': 'php'} " types "use" statements for you
  "Plug 'vim-php/vim-php-refactoring'
  Plug 'vim-php/tagbar-phpctags.vim', {'for': 'php'}
  let phpctags_exists=expand('~/.vim/bin/phpctags')
  if !filereadable(phpctags_exists)
    echo "Installing phpctags..."
    echo ""
    silent !\curl -fLo ~/.vim/bin/phpctags --create-dirs http://vim-php.com/phpctags/install/phpctags.phar
  endif
  Plug 'rayburgemeestre/phpfolding.vim', {'for': 'php'}
  Plug '2072/PHP-Indenting-for-VIm', {'for': 'php'}
  "Plug 'vim-php/vim-composer'
  "Plug 'wdalmut/vim-phpunit.git'
  "}}}

  " Golang {{{
  " fatih/vim-go is loaded by vim-polyglot but I want the original package =)
  Plug 'fatih/vim-go', {'for': 'go', 'do': ':GoInstallBinaries'}
  "}}}
  "}}}

  """""""""""""""""""
  " Color schemes
  " and icons
  """""""""""""""""""
  "Plug 'godlygeek/csapprox' " (old: vim-scripts/CSApprox) Make gvim-only colorschemes work transparently in terminal vim.
  Plug 'tomasr/molokai' " Molokai color scheme for Vim.
  "Plug 'junegunn/seoul256.vim' " Low-contrast Vim color scheme based on Seoul Colors.
  Plug 'joshdick/onedark.vim' " A dark Vim/Neovim color scheme inspired by Atom's One Dark syntax theme.
  "Plug 'chriskempson/base16-vim' " Base16 for Vim.
  "Plug 'mhinz/vim-janah' " A dark colorscheme for Vim.
  "Plug 'nanotech/jellybeans.vim', { 'tag': 'v1.6' } " A colorful, dark color scheme for Vim.
  Plug 'romainl/Apprentice' " A dark, low-contrast, Vim colorscheme.
  "Plug 'rakr/vim-one' " Adaptation of one-light and one-dark colorschemes for Vim.
  Plug 'morhetz/gruvbox' " Retro groove color scheme for Vim.

  """""""""""""""""""
  " Misc
  """""""""""""""""""
  "{{{
  Plug 'johngrib/vim-game-code-break'
  Plug 'iamcco/markdown-preview.vim', {'for': 'markdown'} " Real-time markdown preview plugin for vim.
  Plug 'godlygeek/tabular', {'for': 'markdown'}
  Plug 'plasticboy/vim-markdown', {'for': 'markdown'}
  "Plug 'tpope/vim-markdown'
  "Plug 'gabrielelana/vim-markdown'
  " Tests
  "source /home/tobias/play/side_projects/dotfiles/vim/tests/vim-lsp_asyncomplete/plug.vim
  "source /home/tobias/play/side_projects/dotfiles/vim/tests/LanguageClient-neovim_nvim-completion-manager/plug.vim
  "}}}
  " Initialize plugin system
call plug#end()

"source /home/tobias/play/side_projects/dotfiles/vim/tests/vim-lsp_asyncomplete/config.vim
"source /home/tobias/play/side_projects/dotfiles/vim/tests/LanguageClient-neovim_nvim-completion-manager/config.vim
"autocmd BufNewFile,BufReadPost *.md set filetype=markdown
"let g:markdown_fenced_languages = ['html', 'php', 'python', 'bash=sh']

"}}}

