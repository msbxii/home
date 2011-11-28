#!/bin/bash



progs_to_install=( git zsh )
progs_to_maybe_install=( boxes )

__w_install() {
	hash 'apt-get' && echo 'I need administrator priveliges to install '\
		"$1" && sudo apt-get install "$1" && return
	hash 'yum' && echo 'I need administrator priveliges to install '\
		"$1" && sudo yum install "$1" & return
	echo "I can't auto-install $1- Please install it on your own."
}

__n_install() {
	hash 'apt-get' && echo 'I need administrator priveliges to install '\
		"$1" && sudo apt-get install "$1" && return
	hash 'yum' && echo 'I need administrator priveliges to install '\
		"$1" && sudo yum install "$1" & return
	echo "I can't auto-install $1- Please install it and then run this "
	echo "script again."
	exit
}
__need() {
	hash "$1" > /dev/null 2>/dev/null && echo "$1 is installed... " && return
	__n_install "$1"
}
__want() {
	hash "$1" > /dev/null 2>/dev/null && echo "$1 is installed"  && return
	__w_install "$1"
}

if [ "$1" = vim ]; then
	read -p 'fetch/compile/install vim? [y/n]: ' ANS
	if [ "$ANS" = y ]; then
		__need hg
		cd
		if [ ! -d sources ]; then
			mkdir sources
		fi
		cd sources
		if [ -d vim ]; then
			rm -rf vim
		fi
		echo "entering `pwd`"
		hg clone https://vim.googlecode.com/hg/ vim
		cd vim
		echo "entering `pwd`"
		./configure --enable-multibyte
		make
		sudo make install
	fi
	exit
fi

for i in "${progs_to_install[@]}"
do
	__need $i
done
for i in "${progs_to_maybe_install[@]}"
do
	__want $i
done
          

cd

CONFIG_GIT_REPO=.home_config_repo
############################
# grab stuff from the repo #
############################
git clone git://github.com/msbxii/home.git $CONFIG_GIT_REPO

echo "Home config repository initialized in $CONFIG_GIT_REPO."

read -p 'Would you like to add a remote push for the home repository? [y/n] ' RESP

if [ "$RESP" = "y" ] || [ x"$RESP" = x ]; then
	( cd $CONFIG_GIT_REPO
	git remote rm origin
	git remote add origin https://msbxii@github.com/msbxii/home.git
	echo 'There you go.'
	)
fi

echo 'Making symlinks'
#############################
# make symlinks to dotfiles #
#############################
#{{
for i in `find $CONFIG_GIT_REPO -maxdepth 1 -mindepth 1 -name '.*'`
do
	if [ -e `basename $i` ]
	then
		mv $i $i-pre-setup
	fi
	ln -s $i
done 
# }}

rm .git* -f
ln -s $CONFIG_GIT_REPO/.gitconfig
