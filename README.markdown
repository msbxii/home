msbxii's home config script
===========================

This repository contains my

> + .bashrc
> + .vimrc
> + .zshrc
> + .dircolors
> + .vim/

and an installer for them.


hand-install
------------

run these commands in your home directory.
    
	git clone git://github.com/msbxii/home.git .home_config 
	# change .home_config to whatever you want

	# take whatever you want from that file. ex if you want my 
	# vim config in entirety (plugins, etc)
	cd ~ 
	ln -s .home_config/.vimrc
	ln -s .home_config/.vim

To update (follow me, yaay!)

    cd ~/.home_config
	git pull origin master

etc, quid pro quo, ad nauseum

auto-install
------------

copy & paste:

    wget -O - http://git.io/mhsetup | bash

__warning: dangerous.  look through the script before you run it to make sure it's not 
    going to break something on your machine.  Works best on fresh installs.__

The install script requires `git`, and attempts to automatically install it if not found.

A git repository will be created in `~/$HOME_CONFIG_REPO`, which is defined by
the script and not very configurable.

The script then symlinks all the dotfiles in that repository into your home
directory. If you have existing config files, this operation will fail until
you backup and remove them.


I'm not sure if I like bash or zsh more at the moment but I'm just letting the user
choose per-machine.  I've emulated some of the git plugin functionality from zsh 
in bashrc because I really like having some status in the prompt.


