#!/bin/bash

if (( $EUID != 0 ))
then
	echo "Run as root"
	exit 1
fi


mkdir $HOME/Desktop
mkdir $HOME/Documents
mkdir $HOME/Pictures
mkdir $HOME/Videos

cp $HOME/ArchConf/wallpapers/* $HOME/Pictures

if [[ -d $HOME/.fonts ]]
then
	mkdir $HOME/.fonts
	cp $HOME/Downloads/ArchConf/fonts/* $HOME/.fonts/
else
	cp $HOME/Downloads/ArchConf/fonts/* $HOME/.fonts/
fi 

git clone https://aur.archlinux.org/paru.git $HOME/Downloads
cd $HOME/Downloads/paru
makepkg -si

pacman -S - < pkglist.txt

cp $HOME/ArchConf/fehbg/.fehbg $HOME/

if [[ -d $HOME/.config/alacritty ]]
then
	mkdir $HOME/.config/alacritty
	cp $HOME/Downloads/ArchConf/alacritty/alacritty.yml $HOME/.config/alacritty/
else
	cp $HOME/Downloads/ArchConf/alacritty/alacritty.yml $HOME/,.config/alacritty
fi

if [[ -d $HOME/.config/i3 ]]
then
	mkdir $HOME/.config/i3
	cp $HOME/Downloads/ArchConf/i3/config $HOME/.config/i3/
	cp $HOME/Downloads/ArchConf/i3/i3status.conf $HOME/.config/i3/
else
	cp $HOME/Downloads/ArchConf/i3/config $HOME/.config/i3/
	cp $HOME/Downloads/ArchConf/i3/i3status.conf $HOME/.config/i3/
fi

if [[ -d $HOME/.config/nvim ]]
then
	mkdir $HOME/.config/nvim
	cp $HOME/Downloads/ArchConf/nvim/init.vim $HOME/.config/nvim/
	nvim -c "PlugInstall"
else
	cp $HOME/ArchConf/nvim/init.vim $HOME/.config/nvim/
	
fi

if [[ -d $HOME/.config/picom ]]
then
	mkdir $HOME/.config/nvim
	cp $HOME/Downloads/ArchConf/picom/picom.conf $HOME/.config/picom/
else
	cp $HOME/Downloads/ArchConf/picom/picom.conf $HOME/.config/picom/
fi


sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

nvim -c "PlugInstall"


bash -c "$(wget https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh -O -)"