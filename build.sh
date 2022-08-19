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
mkdir $HOME/Downloads

echo "Directorys created"

cp $PWD/wallpapers/* $HOME/Pictures

echo "Wallpapers Copied"

if ! [[ -d $HOME/.fonts ]]
then
	mkdir $HOME/.fonts
	cp $PWD/fonts/* $HOME/.fonts/
	echo "Fonts copied"
else
	cp $PWD/fonts/* $HOME/.fonts/
	echo "Fonts copied"
fi 

#sudo pacman -S --needed base-devel

git clone https://aur.archlinux.org/paru.git $HOME/Downloads/paru
cd $HOME/Downloads/paru
makepkg -si

echo "Paru Installed"

pacman -S --needed - < $(cat $HOME/ArchConf/pkglist.txt)

echo "Packages Installed"

cp $PWD/fehbg/.fehbg $HOME

echo "fehbg conf copied"

cd $PWD/.config

if ! [[ -d $HOME/.config/alacritty ]]
then
	mkdir $HOME/.config/alacritty
	cp $HOME/ArchConf/alacritty/alacritty.yml $HOME/.config/alacritty/
else
	cp $HOME/ArchConf/alacritty/alacritty.yml $HOME/.config/alacritty
fi

if ! [[ -d $HOME/.config/i3 ]]
then
	mkdir $HOME/.config/i3
	cp $HOME/ArchConf/i3/config $HOME/.config/i3/
	cp $HOME/ArchConf/i3/i3status.conf $HOME/.config/i3/
else
	cp $HOME/ArchConf/i3/config $HOME/.config/i3/
	cp $HOME/ArchConf/i3/i3status.conf $HOME/.config/i3/
fi

if ! [[ -d $HOME/.config/nvim ]]
then
	mkdir $HOME/.config/nvim
	cp $HOME/ArchConf/nvim/init.vim $HOME/.config/nvim/
	#nvim -c "PlugInstall"
else
	cp $HOME/ArchConf/nvim/init.vim $HOME/.config/nvim/
	
fi

if ! [[ -d $HOME/.config/picom ]]
then
	mkdir $HOME/.config/nvim
	cp $HOME/ArchConf/picom/picom.conf $HOME/.config/picom/
else
	cp $HOME/ArchConf/picom/picom.conf $HOME/.config/picom/
fi

echo "conf files copied"

sh -c 'curl -fLo "${XDG_DATA_HOME:-$PWD/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

nvim -c "PlugInstall"


bash -c "$(wget https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh -O -)"
