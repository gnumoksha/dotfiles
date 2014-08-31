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
echo "Habilitar paranauês para o gnome-terminal?"
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
		bash "$SCRIPTPATH/others/gnome-terminal-colors/install.sh"
	fi
	break
done

echo "Habilitando paranauês úteis no bash"
BASHRC_UTILS="source \"$SCRIPTPATH/bashrc_utils/init.sh\" \"$SCRIPTPATH/bashrc_utils\""
[[ ! $(grep -i "$BASHRC_UTILS" ~/.bashrc 2>/dev/null) ]] && echo "$BASHRC_UTILS" >> ~/.bashrc
[[ $DELETAR_ANTIGOS -eq 1 ]] && rm -f ~/.bash_profile ~/.dir_colors 2>/dev/null
ln -s "$SCRIPTPATH/bash_profile" ~/.bash_profile
ln -s "$SCRIPTPATH/others/dircolors-solarized/dircolors.256dark" ~/.dir_colors

echo "Criando link para configuração do agent ssh"
mkdir ~/.ssh 2>/dev/null
[[ $DELETAR_ANTIGOS -eq 1 ]] && rm -f ~/.ssh/config 2>/dev/null
ln -s "$SCRIPTPATH/ssh/config" ~/.ssh/config

echo "Criando link para configuração do vim"
[[ $DELETAR_ANTIGOS -eq 1 ]] && rm -f ~/.vimrc 2>/dev/null
ln -s "$SCRIPTPATH/vimrc" ~/.vimrc

echo "Criando link para configuração do git"
[[ $DELETAR_ANTIGOS -eq 1 ]] && rm -f ~/.gitconfig 2>/dev/null
ln -s "$SCRIPTPATH/gitconfig" ~/.gitconfig

#EOF
