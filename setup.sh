#!/bin/sh


__install () {
	hash 'apt-get' && echo 'I need administrator priveliges to install '\
		"$1" && sudo apt-get install "$1" && return
	hash 'yum' && echo 'I need administrator priveliges to install '\
		"$1" && sudo yum install "$1" & return
	echo "I can't auto-install $1- Please install it and then run this "
	echo "script again."
	exit
}
__need () {
	hash "$1" && echo "$1 is installed... " && return
	__install "$1"
}



__need git
__need zsh


cd $HOME

git init
git remote add pub git://github.com/msbxii/home.git
git pull pub master
rm -rf .git

read -p "Install zsh (y/n): " REPLY

[ "$REPLY" = "y" ] && chsh -s zsh
