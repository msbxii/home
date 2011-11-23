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

############################
# grab stuff from the repo #
############################
git clone git://github.com/msbxii/home.git


#############################
# make symlinks to dotfiles #
#############################
#{{
for i in `find home -name '.*' -maxdepth 1`
do
	ln -s $i
done 
# }}

# don't need ~ to be a repo
rm -rf .git

read -p 'Would you like to add a remote push for the home repository? [y/n] ' RESP

# second test is true if it's the automatic installer
if [ "$RESP" = "y" ] || [ x"$RESP" = x ]; then
	cd home
	git remote rm origin
	git remote add origin https://msbxii@github.com/msbxii/home.git
	cd
	echo 'There you go.'
fi
