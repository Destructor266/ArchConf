#!/bin/bash

if (( $EUID != 0 ))
then
	echo "Run as root"
	exit 1
fi


mkdir ~/Desktop
mkdir ~/Documents
mkdir ~/Pictures
mkdir ~/Videos

cp ~/ArchConf/wallpapers/* ~/Pictures

if [[ -d ~/.fonts ]]
then
	mkdir ~/.fonts
	cp ~/Downloads/ArchConf/fonts/* ~/.fonts/
else
	cp ~/Downloads/ArchConf/fonts/* ~/.fonts/
fi 

pacman -S - < pkglist.txt

git clone https://aur.archlinux.org/paru.git ~/Downloads
cd ~/Downloads/paru
makepkg -si

cp ~/ArchConf/fehbg/.fehbg ~/



if [[ -d ~/.config/alacritty ]]
then
	mkdir ~/.config/alacritty
	cp ~/Downloads/ArchConf/alacritty/alacritty.yml ~/.config/alacritty/
else
	cp ~/Downloads/ArchConf/alacritty/alacritty.yml ~/,.config/alacritty
fi

if [[ -d ~/.config/i3 ]]
then
	mkdir ~/.config/i3
	cp ~/Downloads/ArchConf/i3/config ~/.config/i3/
	cp ~/Downloads/ArchConf/i3/i3status.conf ~/.config/i3/
else
	cp ~/Downloads/ArchConf/i3/config ~/.config/i3/
	cp ~/Downloads/ArchConf/i3/i3status.conf ~/.config/i3/
fi

if [[ -d ~/.config/nvim ]]
then
	mkdir ~/.config/nvim
	cp ~/Downloads/ArchConf/nvim/init.vim ~/.config/nvim/
	nvim -c "PlugInstall"
else
	cp ~/ArchConf/nvim/init.vim ~/.config/nvim/
	
fi

if [[ -d ~/.config/picom ]]
then
	mkdir ~/.config/nvim
	cp ~/Downloads/ArchConf/picom/picom.conf ~/.config/picom/
else
	cp ~/Downloads/ArchConf/picom/picom.conf ~/.config/picom/
fi


sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

nvim -c "PlugInstall"


bash -c "$(wget https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh -O -)"