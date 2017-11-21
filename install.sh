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
		ln -s "$SCRIPTPATH/shell/xfce4-terminal/terminalrc" ~/.config/xfce4/terminal/terminalrc
		echo
		echo
	fi
	break
done

echo "Do you want to configure KDE Konsole?"
select konsole in "Sim" "Nao"; do
	if [[ $konsole == "Sim" ]]; then
			echo "Configuring KDE Konsole"
			[[ $DELETAR_ANTIGOS -eq 1 ]] && rm -f ~/.local/share/konsole/TomorrowNightEighties.colorscheme 2>/dev/null
			ln -s "$SCRIPTPATH/others/konsole-tomorrow-theme/TomorrowNightEighties.colorscheme" ~/.local/share/konsole/TomorrowNightEighties.colorscheme
			[[ $DELETAR_ANTIGOS -eq 1 ]] && rm -f ~/.local/share/konsole/Tobias.profile 2>/dev/null
			ln -s "$SCRIPTPATH/shell/konsole/Tobias.profile" ~/.local/share/konsole/Tobias.profile
			[[ $DELETAR_ANTIGOS -eq 1 ]] && rm -f ~/.config/konsolerc 2>/dev/null
			ln -s "$SCRIPTPATH/shell/konsole/konsolerc" ~/.config/konsolerc
		echo
		echo
	fi
	break
done

# O ~/.bashrc não é sobrescrito porque geralmente vem com configuracoes uteis para a distro.
echo "Configuring BASH"
BASH_GENERAL="source \"$SCRIPTPATH/shell/bash/general.sh\""
[[ ! $(grep -i "$BASH_GENERAL" ~/.bashrc 2>/dev/null) ]] && echo "$BASH_GENERAL" >> ~/.bashrc
#
SHELL_GENERAL="source \"$SCRIPTPATH/shell/general/general.sh\""
[[ ! $(grep -i "$SHELL_GENERAL" ~/.bashrc 2>/dev/null) ]] && echo "$SHELL_GENERAL" >> ~/.bashrc
#
[[ $DELETAR_ANTIGOS -eq 1 ]] && rm -f ~/.bash_profile ~/.dir_colors 2>/dev/null
ln -s "$SCRIPTPATH/shell/bash/bash_profile" ~/.bash_profile
ln -s "$SCRIPTPATH/others/dircolors-solarized/dircolors.256dark" ~/.dir_colors

echo "Configuring ZSH"
[[ $DELETAR_ANTIGOS -eq 1 ]] && rm -f ~/.zshrc 2>/dev/null
ln -s "$SCRIPTPATH/shell/zsh/zshrc" ~/.zshrc

echo "Criando link para configuração do agent ssh"
mkdir ~/.ssh 2>/dev/null
[[ $DELETAR_ANTIGOS -eq 1 ]] && rm -f ~/.ssh/config ~/.ssh/*.config 2>/dev/null
for arquivo in $(ls "$SCRIPTPATH/ssh/"); do
    ln -s $SCRIPTPATH/ssh/$arquivo ~/.ssh/$arquivo
done

echo "Configuring vim"
[[ $DELETAR_ANTIGOS -eq 1 ]] && rm -f ~/.vimrc 2>/dev/null
ln -s "$SCRIPTPATH/vim/vimrc.dev" ~/.vimrc

echo "Configuring gedit"
# /usr/share/gtksourceview-{2,3}.0/styles/
mkdir -p ~/.local/share/gtksourceview-3.0/styles/ 2>/dev/null
[[ $DELETAR_ANTIGOS -eq 1 ]] && rm -f ~/.local/share/gtksourceview-3.0/styles/Tomorrow-Night-Eighties.xml 2>/dev/null
ln -s "$SCRIPTPATH/others/tomorrow-theme/GEdit/Tomorrow-Night-Eighties.xml" ~/.local/share/gtksourceview-3.0/styles/Tomorrow-Night-Eighties.xml

echo "Criando link para configuração do git"
[[ -d ~/.config/git ]] || mkdir ~/.config/git
[[ $DELETAR_ANTIGOS -eq 1 ]] && rm -f ~/.config/git/config ~/.config/git/ignore ~/.config/git/attributes 2>/dev/null
ln -s "$SCRIPTPATH/git/config" ~/.config/git/config
ln -s "$SCRIPTPATH/git/ignore" ~/.config/git/ignore
ln -s "$SCRIPTPATH/git/attributes" ~/.config/git/attributes

echo "Criando link para configuração do htop"
mkdir ~/.config/htop/ 2>/dev/null
[[ $DELETAR_ANTIGOS -eq 1 ]] && rm -f ~/.config/htop/htoprc 2>/dev/null
ln -s "$SCRIPTPATH/htoprc" ~/.config/htop/htoprc

echo "Criando link para configuração do byobu"
mkdir ~/.byobu 2>/dev/null
[[ $DELETAR_ANTIGOS -eq 1 ]] && rm -f ~/.byobu/status 2>/dev/null
ln -s "$SCRIPTPATH/shell/byobu/status" ~/.byobu/status
#TODO fazer automaticamente o procedimento mencionado abaixo
echo "	NOTA: Para o byobu funcionar corretamente, execute xfce4-settings-editor
	va em xfce4-keyboard-shortcuts e delete os e control-fX e veja quais
	dos alt-fX vai usar. Nao delete os que estao na chave xfwm4 > default"

# cp others/tomorrow-theme/ipythonqt/tomorrownight.py /usr/lib/python2.7/dist-packages/pygments/styles/
# ipython qtconsole --style=tomorrownight --stylesheet=/home/tobias/play/generic_projects/dotfiles/others/tomorrow-theme/ipythonqt/tomorrownight.css

# https://github.com/gabrielelana/awesome-terminal-fonts#how-to-install-linux
cp -f others/fonts/awesome-terminal-fonts/build/*.ttf ~/.local/share/fonts/
mkdir -p ~/.local/share/fonts/awesome-terminal-fonts_maps
cp -f others/fonts/awesome-terminal-fonts/build/*.sh ~/.local/share/fonts/awesome-terminal-fonts_maps
mkdir -p ~/.config/fontconfig/conf.d
ln -fs "$SCRIPTPATH/others/fonts/awesome-terminal-fonts/config/10-symbols.conf" ~/.config/fontconfig/conf.d

# Instala e atualiza o cache de fontes
./others/fonts/powerline/install.sh

#EOF
