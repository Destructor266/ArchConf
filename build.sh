#!/bin/bash

if (($EUID != 0))
then
	echo "Run as root"
	exit 1
fi


mkdir ~/Desktop
mkdir ~/Documents
mkdir ~/Downloads
mkdir ~/Pictures
mkdir ~/Videos

if [[ -d ~/.fonts ]]
then
	mkdir ~/.fonts
	cp ~/.dotfiles/fonts/* ~/.fonts/
else
	cp ~/.dotfiles/fonts/* ~/.fonts/
fi 

git clone https://github.com/ohmybash/oh-my-bash.git ~/Downloads

git clone https://github.com/fairyglade/ly.git ~/Downloads

git clone https://github.com/junegunn/vim-plug.git ~/Downloads

git clone https://github.com/Morganamilo/paru.git ~/Downloads


if [[ -d ~/.config/alacritty ]]
then
	mkdir ~/.config/alacritty
	cp ~/.dotfiles/alacritty/alacritty.yml ~/.config/alacritty/
else
	cp ~/.dotfiles/alacritty/alacritty.yml ~/,.config/alacritty
fi


if [[ -d ~/.config/i3 ]]
then
	mkdir ~/.config/i3
	cp ~/.dotfiles/i3/config ~/.config/alacritty/
else
	cp ~/.dotfiles/alacritty/alacritty.yml ~/,.config/alacritty
fi

pacman -S - < pkglist.txt
