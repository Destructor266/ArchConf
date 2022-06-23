#!/bin/bash

# if (( $EUID != 0 ))
# then
# 	echo "Run as root"
# 	exit 1
# fi


mkdir $HOME/Desktop
mkdir $HOME/Documents
mkdir $HOME/Pictures
mkdir $HOME/Videos

cp $PWD/Downloads/ArchConf/wallpapers/* $HOME/Pictures

if ! [[ -d $PWD/.fonts ]]
then
	mkdir $PWD/.fonts
	cp $PWD/Downloads/ArchConf/fonts/* $HOME/.fonts/
else
	cp $PWD/Downloads/ArchConf/fonts/* $HOME/.fonts/
fi 

sudo pacman -S --needed base-devel

git clone https://aur.archlinux.org/paru.git $HOME/Downloads/paru
cd $PWD/Downloads/paru
makepkg -si

sudo pacman -S - < $HOME/Downloads/ArchConf/pkglist.txt

cp $PWD/Downloads/ArchConf/fehbg/.fehbg $HOME

cd $PWD/.config

if ! [[ -d $PWD/.config/alacritty ]]
then
	mkdir $PWD/.config/alacritty
	cp $PWD/Downloads/ArchConf/alacritty/alacritty.yml $HOME/.config/alacritty/
else
	cp $PWD/Downloads/ArchConf/alacritty/alacritty.yml $HOME/.config/alacritty
fi

if ! [[ -d $PWD/.config/i3 ]]
then
	mkdir $PWD/.config/i3
	cp $PWD/Downloads/ArchConf/i3/config $HOME/.config/i3/
	cp $PWD/Downloads/ArchConf/i3/i3status.conf $HOME/.config/i3/
else
	cp $PWD/Downloads/ArchConf/i3/config $HOME/.config/i3/
	cp $PWD/Downloads/ArchConf/i3/i3status.conf $HOME/.config/i3/
fi

if ! [[ -d $PWD/.config/nvim ]]
then
	mkdir $PWD/.config/nvim
	cp $PWD/Downloads/ArchConf/nvim/init.vim $HOME/.config/nvim/
	nvim -c "PlugInstall"
else
	cp $PWD/ArchConf/nvim/init.vim $HOME/.config/nvim/
	
fi

if ! [[ -d $PWD/.config/picom ]]
then
	mkdir $PWD/.config/nvim
	cp $PWD/Downloads/ArchConf/picom/picom.conf $HOME/.config/picom/
else
	cp $PWD/Downloads/ArchConf/picom/picom.conf $HOME/.config/picom/
fi


sh -c 'curl -fLo "${XDG_DATA_HOME:-$PWD/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

nvim -c "PlugInstall"


bash -c "$(wget https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh -O -)"