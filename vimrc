""""""""""""""""""""""""""""""""""""""""""
"                                        "
"   Arquivo de configuracao para o VIM   "
"                                        "
""""""""""""""""""""""""""""""""""""""""""
"
" Objetivo destas configurações é aprimorar o uso genérico
" do vim; em servidores, por exemplo.
" Testado no vim
"	7.3 debian
"	7.4 debian jessie (testing)
" Tobias <contato@eutobias.org>


"""""""""""""""""""""""""""""""
"     Definições genéricas    "
"""""""""""""""""""""""""""""""
"{
" http://stackoverflow.com/questions/5845557/in-a-vimrc-is-set-nocompatible-completely-useless
set nocompatible

" Recarrega o vim automaticamente quando editando o vimrc
autocmd! bufwritepost .vimrc source ~/.vimrc

" ? Esconder buffers quando eles são abandonados
"set hidden
"}


"""""""""""""""""""""""""""""""
"             Tela            "
"""""""""""""""""""""""""""""""
"{
" ? Exibe parte do comando na linha de status
set showcmd

" Exibe os numeros das linhas
"set number

" Mostra o número da linha e da coluna, separados por virgula,  onde
" o cursor está. Desativado pois o texto na linha de status exibe estas
" informações.
"set ruler 

" Exibe o modo atual
set showmode

" Exibe barra de status
set laststatus=2

" Define um texto na barra de status
set statusline=\ %f%m%r%h\ %w\ \|
set statusline+=\ [%{&ff}/%Y]\ \|
set statusline+=\ %<%0(%{hostname()}:%{DiretorioAtual()}%)\ \|
set statusline+=%=%-10.(%l,%c%V%)\ %p%%/%L

" ? Iniciar a wild expansion na linha de comando usando <Tab>
set wildchar=<TAB>

" Ativar o uso do mouse (todos os modos)
"set mouse=a
"}


"""""""""""""""""""""""""""""""
"            Texto            "
"""""""""""""""""""""""""""""""
"{
" Destaque de sintexe.
if has("syntax")
	syntax on
	colorscheme Tomorrow-Night
	"força o vim a usar o modo de 256 cores
	"set t_Co=256 " [4]
	highlight Normal ctermbg=NONE| "[4]
	highlight nonText ctermbg=NONE| "[4]
endif

" Quando definido para 'dark', vim vai tentar usar cores que ficam
" bom em um fundo escuro. Quando definido para 'light' vim vai tentar
" usar cores que fiquem bem em fundo claro. Outros valores são inválidos.
"set background=dark

" Faz com que o vim pule para a posição no arquivo onde se parou na última
" fez que ele foi aberto
if has("autocmd")
	au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Diz ao vim para carregar as regras de indentação e plugins de acordo com o
" tipo de arquivo detectado
if has("autocmd")
	filetype plugin indent on
endif

" copia a indentação anterior na auto indentação
set copyindent

" Quando um bracket eh inserido, saltar rapidamente para o seu primeiro
" correspondente. O salto só ocorre se o correspondente pode ser visto na
" tela atual. Para definir por quanto tempo o salto ocorrera, use 'matchtime'
set showmatch

" Define a largura do texto, em numero de caracteres
"set textwidth=79

" Coluna 80 colorida
set colorcolumn=81

" Destaca a linha atual
set cursorline

" Copia do vim para a area de transferencia
set clipboard=unnamedplus

" Recarrega automaticamente arquivos que foram alterados no disco
set autoread

" Salve automaticamente antes de comandos como :next e :make
"set autowrite

" Exibe um menu durante o autocomplete
set wildmenu

" Influencia o funcionamento de <BS>, <Del>, Ctrl-W, Ctrl-U no modo de
" insercao. Esta eh uma lista de itens separados por virgula. Cade item
" permite uma forma de retrocesso sobre alguma coisa
"set backspace=2

"set formatoptions=c,q,r,t
"}


"""""""""""""""""""""""""""""""
"           Pesquisa          "
"""""""""""""""""""""""""""""""
"{
" Igora case sensitive durante as buscas
set ignorecase

" Ignora a opcao 'ignorecase' se o texto a ser buscado contem caracteres
" maiusculos
set smartcase

" Quando há uma padrao de uma pesquisa anterior, destaque todos os resultados
set hlsearch

" Busca incremental. Vai buscando e mostrando os resultados conforme se
" vai digitando o texto a buscar.
set incsearch
"}


"""""""""""""""""""""""""""""""
"   Espaços no lugar de Tab   "
"""""""""""""""""""""""""""""""
" ? numero de espacos que <Tab>
"set tabstop=4

" numero de espacos a ser utilizado em cada autoindentação
"set shiftwidth=4

" Use o numero apropriado de espacos para inserir um <Tab>. Os
" espacos sao utilizados em indentacoes com os comandos '<' e '>'
" e quando 'autoindent' esta ligado. Para inserir uma tabulacao
" real quando 'expandtab' esta ligado, use Ctrl-V <Tab>
"set expandtab

" Quando ligado, <Tab> na frente de uma linha insere espacos em branco
" de acordo com 'shiftwidth'. 'tabstop' eh usado em outros locais.
" <BS> excluira 'shiftwidth' espacos no inicio da linha


""""""""""""""""""""""""""""""""""""""""""
"                                        "
"         Mapeamento de teclas           "
"                                        "
""""""""""""""""""""""""""""""""""""""""""

" Define o leader (prefixo de comando) para ,
let mapleader=","
let g:mapleader=","

" ,p alterna o modo paste
" parece que é melhor que pastetoggle
nmap <leader>p :set paste!<BAR>set paste?<CR>

" cd. muda para o diretorio do arquivo atual
cmap cd. lcd %:p:h

" Faz com que blocos selecionados sejam reselecionados após identações
vnoremap < <gv
vnoremap > >gv

" nova aba
map <C-t><C-t> :tabnew<CR>

" fecha aba
map <C-t><C-w> :tabclose<CR> 

" abre o console de erro
map <leader>cc :botright cope<CR> 

" [3] evita problemas apos usar shift :
:command WQ wq
:command Wq wq
:command W w
:command Q q

" [3] Ao inves de usar : use ; que nao precisa do shift
nnoremap ; :

""""""""""""""""""""""""""""""""""""""""""
"                                        "
"                 Funções                "
"                                        "
""""""""""""""""""""""""""""""""""""""""""

" Auto completa o texto utilizando a tecla TAB
" http://my.opera.com/smarcell/blog/2013/03/06/vim-autocompletar-com-tab
function! AutoCompletar(direcao)
	let posicao = col(".") - 1
	if ! posicao || getline(".")[posicao - 1] !~ '\k'
		return "\<Tab>"
	elseif a:direcao == "avancar"
		return "\<C-n>"
	else
		return "\<C-p>"
	endif
endfunction 
inoremap <Tab> <C-R>=AutoCompletar("avancar")<CR>
inoremap <S-Tab> <C-R>=AutoCompletar("voltar")<CR> 

function! DiretorioAtual()
	let dirAtual = substitute(getcwd(), $HOME, "~", "")
	return dirAtual
endfunction

" Faz com que o vim reconheca que algo vai ser colado e mude
" automaticamente para o modo paste e de insercao.
" Quando terminar de colar, vim saira automaticamente do modo paste.
" http://stackoverflow.com/questions/5585129/pasting-code-into-terminal-window-into-vim-on-mac-os-x/7053522#7053522
if &term =~ "xterm.*"
	let &t_ti = &t_ti . "\e[?2004h"
	let &t_te = "\e[?2004l" . &t_te
	function! XTermPasteBegin(ret)
		set pastetoggle=<Esc>[201~
		set paste
		return a:ret
	endfunction
	map <expr> <Esc>[200~ XTermPasteBegin("i")
	imap <expr> <Esc>[200~ XTermPasteBegin("")
	cmap <Esc>[200~ <nop>
	cmap <Esc>[201~ <nop>
endif


""""""""""""""""""""""""""""""""""""""""""
"                                        "
"              Referências               "
"                                        "
""""""""""""""""""""""""""""""""""""""""""
"
" [0] /etc/vimrc de algum ubuntu < 13.04
" [1] https://wiki.archlinux.org/index.php/Vim/.vimrc
" [2] https://github.com/InFog/meuvim/blob/master/vimrc
" [3] https://coderwall.com/p/nckasg
" [4] http://stackoverflow.com/questions/4325682/vim-colorschemes-not-changing-background-color
"

"EOF
