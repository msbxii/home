#!/bin/bash

progs_to_install=(git zsh)

__install() {
	hash 'apt-get' && echo 'I need administrator priveliges to install '\
		"$1" && sudo apt-get install "$1" && return
	hash 'yum' && echo 'I need administrator priveliges to install '\
		"$1" && sudo yum install "$1" & return
	echo "I can't auto-install $1- Please install it and then run this "
	echo "script again."
	exit
}
__need() {
	hash "$1" && echo "$1 is installed... " && return
	__install "$1"
}

for i in $progs_to_install
do
	__need $i
done
          

cd

CONFIG_GIT_REPO=.home_config_repo
############################
# grab stuff from the repo #
############################
git clone git://github.com/msbxii/home.git $CONFIG_GIT_REPO


#############################
# make symlinks to dotfiles #
#############################
for i in `find $CONFIG_GIT_REPO -name '.*' -maxdepth 1`
	#{{
do
	ln -s $i
done 
# }}

rm -rf .git

echo "Home config repository initialized in $CONFIG_GIT_REPO."

read -p 'Would you like to add a remote push for the home repository? [y/n] ' RESP

if [ "$RESP" = "y" ] || [ x"$RESP" = x ]; then
	cd $CONFIG_GIT_REPO
	git remote rm origin
	git remote add origin https://msbxii@github.com/msbxii/home.git
	cd
	echo 'There you go.'
fi
