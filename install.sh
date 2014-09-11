#!/bin/bash
# By Tobias Sette. Public domain.

# http://stackoverflow.com/questions/4774054/reliable-way-for-a-bash-script-to-get-the-full-path-to-itself
pushd $(dirname $0) > /dev/null
SCRIPTPATH=$(pwd -P)
popd > /dev/null

# deletar arquivos já existentes? 0 = Não | 1 = Sim
DELETAR_ANTIGOS=1

# Se estiver rodando no gnome-terminal
# http://unix.stackexchange.com/questions/93376/which-terminal-type-am-i-using
#ps -p$PPID | grep -i "gnome-terminal" > /dev/null
#http://askubuntu.com/questions/210182/how-to-check-which-terminal-emulator-is-being-currently-used
#ps -h -o comm -p $(ps -h -o ppid -p $$ 2>/dev/null) | grep -i "gnome-terminal" > /dev/null
echo "Configurar o gnome-terminal?"
select gnometerminal in "Sim" "Nao"; do
	if [[ $gnometerminal == "Sim" ]]; then
		echo "Habilitando esquema de cores solarized para o gnome-terminal"
		echo
		echo "Os esquemas mais interessantes, na ordem:
		Base 16 Flat Dark
		Base 16 Eighties Dark
		Base 16 Ocean Dark
		Base 16 Monokai Dark
		Base 16 Railscasts Dark
		Base 16 Default Dar"
		echo
		echo "Outros esquemas bons:
		Base 16 Twilight Dark
		Base 16 Tomorrow Dark
		Base 16 Paraiso Dark
		Base 16 Marrakesh Dark
		Base 16 Green Screen Dark
		Base 16 Google Dark
		Base 16 Embers Dark
		Base 16 Mocha Dark
		Base 16 Atelier Heath Dark
		Base 16 Bespin Dark
		Base 16 Atelier Lakeside Dark
		Base 16 London Tube Dark"
		echo
		read -p "Presione qualquer tecla para continuar "
		echo
		bash "$SCRIPTPATH/others/gnome-terminal-colors/install.sh"
		echo
		echo
	fi
	break
done

echo "Configurar o xfce4-terminal?"
select xfceterminal in "Sim" "Nao"; do
	if [[ $xfceterminal == "Sim" ]]; then
		echo "Aplicando arquivo de configuracao para o terminal do xfce"
		[[ $DELETAR_ANTIGOS -eq 1 ]] && rm -f ~/.config/xfce4/terminal/terminalrc 2>/dev/null
		ln -s "$SCRIPTPATH/terminalrc" ~/.config/xfce4/terminal/terminalrc
		echo
		echo
	fi
	break
done

echo "Configurar o konsole?"
select konsole in "Sim" "Nao"; do
	if [[ $konsole == "Sim" ]]; then
		echo "Aplicando arquivo de configuracao para o konsole"
		[[ $DELETAR_ANTIGOS -eq 1 ]] && rm -f ~/.kde/share/apps/konsole/TomorrowNightEighties.colorscheme 2>/dev/null
		ln -s "$SCRIPTPATH/others/konsole-tomorrow-theme/TomorrowNightEighties.colorscheme" ~/.kde/share/apps/konsole/TomorrowNightEighties.colorscheme
		[[ $DELETAR_ANTIGOS -eq 1 ]] && rm -f ~/.kde/share/apps/konsole/Tobias.profile 2>/dev/null
		ln -s "$SCRIPTPATH/konsole/Tobias.profile" ~/.kde/share/apps/konsole/Tobias.profile
		[[ $DELETAR_ANTIGOS -eq 1 ]] && rm -f ~/.kde/share/config/konsolerc 2>/dev/null
		ln -s "$SCRIPTPATH/konsole/konsolerc" ~/.kde/share/config/konsolerc
		echo
		echo
	fi
	break
done

echo "Habilitando paranauês úteis no bash"
BASHRC_UTILS="source \"$SCRIPTPATH/bashrc\""
[[ ! $(grep -i "$BASHRC_UTILS" ~/.bashrc 2>/dev/null) ]] && echo "$BASHRC_UTILS" >> ~/.bashrc
[[ $DELETAR_ANTIGOS -eq 1 ]] && rm -f ~/.bash_profile ~/.dir_colors 2>/dev/null
ln -s "$SCRIPTPATH/bash_profile" ~/.bash_profile
ln -s "$SCRIPTPATH/others/dircolors-solarized/dircolors.256dark" ~/.dir_colors

echo "Criando link para configuração do agent ssh"
mkdir ~/.ssh 2>/dev/null
[[ $DELETAR_ANTIGOS -eq 1 ]] && rm -f ~/.ssh/config 2>/dev/null
ln -s "$SCRIPTPATH/ssh/config" ~/.ssh/config

echo "Configurando o vim"
[[ $DELETAR_ANTIGOS -eq 1 ]] && rm -f ~/.vimrc 2>/dev/null
ln -s "$SCRIPTPATH/vimrc" ~/.vimrc
mkdir -p ~/.vim/colors 2>/dev/null
[[ $DELETAR_ANTIGOS -eq 1 ]] && rm -f ~/.vim/colors/Tomorrow-Night.vim 2>/dev/null
ln -s "$SCRIPTPATH/others/tomorrow-theme/vim/colors/Tomorrow-Night.vim" ~/.vim/colors/Tomorrow-Night.vim

echo "Configurando o gedit"
# /usr/share/gtksourceview-{2,3}.0/styles/
mkdir -p ~/.local/share/gtksourceview-3.0/styles/ 2>/dev/null
[[ $DELETAR_ANTIGOS -eq 1 ]] && rm -f ~/.local/share/gtksourceview-3.0/styles/Tomorrow-Night-Eighties.xml 2>/dev/null
ln -s "$SCRIPTPATH/others/tomorrow-theme/GEdit/Tomorrow-Night-Eighties.xml" ~/.local/share/gtksourceview-3.0/styles/Tomorrow-Night-Eighties.xml

echo "Criando link para configuração do git"
[[ $DELETAR_ANTIGOS -eq 1 ]] && rm -f ~/.gitconfig 2>/dev/null
ln -s "$SCRIPTPATH/gitconfig" ~/.gitconfig

echo "Criando link para configuração do htop"
mkdir ~/.config/htop/ 2>/dev/null
[[ $DELETAR_ANTIGOS -eq 1 ]] && rm -f ~/.config/htop/htoprc 2>/dev/null
ln -s "$SCRIPTPATH/htoprc" ~/.config/htop/htoprc

# xfce4-settings-editor -> xfce4-keyboard-shortcuts

# cp others/tomorrow-theme/ipythonqt/tomorrownight.py /usr/lib/python2.7/dist-packages/pygments/styles/
# ipython qtconsole --style=tomorrownight --stylesheet=/home/tobias/play/generic_projects/dotfiles/others/tomorrow-theme/ipythonqt/tomorrownight.css

#EOF
