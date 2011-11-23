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



cd

git clone git://github.com/msbxii/home.git

for i in `find home -name '.*' -maxdepth 1`
do
	ln -s $i
done

rm -rf .git

