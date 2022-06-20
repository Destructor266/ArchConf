#!/bin/bash

if (( $EUID != 0 ))
then
	echo "Run as root"
	exit 1
fi


mkdir ~/Desktop
mkdir ~/Documents
mkdir ~/Downloads
mkdir ~/Pictures
mkdir ~/Videos

cp ~/ArchConf/wallpapers/* ~/Pictures

if [[ -d ~/.fonts ]]
then
	mkdir ~/.fonts
	cp ~/ArchConf/fonts/* ~/.fonts/
else
	cp ~/ArchConf/fonts/* ~/.fonts/
fi 

bash -c "$(wget https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh -O -)"

git clone https://aur.archlinux.org/paru.git ~/Downloads
cd ~/Downloads/paru
makepkg -si


pacman -S - < pkglist.txt

cp ~/ArchConf/fehbg/.fehbg ~/

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'


if [[ -d ~/.config/alacritty ]]
then
	mkdir ~/.config/alacritty
	cp ~/ArchConf/alacritty/alacritty.yml ~/.config/alacritty/
else
	cp ~/ArchConf/alacritty/alacritty.yml ~/,.config/alacritty
fi

if [[ -d ~/.config/i3 ]]
then
	mkdir ~/.config/i3
	cp ~/ArchConf/i3/config ~/.config/i3/
	cp ~/ArchConf/i3/i3status.conf ~/.config/i3/
else
	cp ~/ArchConf/i3/config ~/.config/i3/
	cp ~/ArchConf/i3/i3status.conf ~/.config/i3/
fi

if [[ -d ~/.config/nvim ]]
then
	mkdir ~/.config/nvim
	cp ~/ArchConf/nvim/init.vim ~/.config/nvim/
	nvim -c "PlugInstall"
else
	cp ~/ArchConf/nvim/init.vim ~/.config/nvim/
	nvim -c "PlugInstall"
fi

if [[ -d ~/.config/picom ]]
then
	mkdir ~/.config/nvim
	cp ~/ArchConf/picom/picom.conf ~/.config/picom/
else
	cp ~/ArchConf/picom/picom.conf ~/.config/picom/
fi
