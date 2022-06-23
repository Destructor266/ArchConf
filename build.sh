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

cp $PWD/wallpapers/* $HOME/Pictures

if ! [[ -d $HOME/.fonts ]]
then
	mkdir $HOME/.fonts
	cp $PWD/fonts/* $HOME/.fonts/
else
	cp $PWD/fonts/* $HOME/.fonts/
fi 

sudo pacman -S --needed base-devel

git clone https://aur.archlinux.org/paru.git $HOME/paru
cd $PWD/paru
makepkg -si

sudo pacman -S - < $HOME/ArchConf/pkglist.txt

cp $PWD/fehbg/.fehbg $HOME

cd $PWD/.config

if ! [[ -d $HOME/.config/alacritty ]]
then
	mkdir $HOME/.config/alacritty
	cp $PWD/alacritty/alacritty.yml $HOME/.config/alacritty/
else
	cp $PWD/alacritty/alacritty.yml $HOME/.config/alacritty
fi

if ! [[ -d $HOME/.config/i3 ]]
then
	mkdir $HOME/.config/i3
	cp $PWD/i3/config $HOME/.config/i3/
	cp $PWD/i3/i3status.conf $HOME/.config/i3/
else
	cp $PWD/i3/config $HOME/.config/i3/
	cp $PWD/i3/i3status.conf $HOME/.config/i3/
fi

if ! [[ -d $HOME/.config/nvim ]]
then
	mkdir $HOME/.config/nvim
	cp $PWD/nvim/init.vim $HOME/.config/nvim/
	#nvim -c "PlugInstall"
else
	cp $PWD/nvim/init.vim $HOME/.config/nvim/
	
fi

if ! [[ -d $HOME/.config/picom ]]
then
	mkdir $HOME/.config/nvim
	cp $PWD/picom/picom.conf $HOME/.config/picom/
else
	cp $PWD/picom/picom.conf $HOME/.config/picom/
fi


sh -c 'curl -fLo "${XDG_DATA_HOME:-$PWD/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

nvim -c "PlugInstall"


bash -c "$(wget https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh -O -)"