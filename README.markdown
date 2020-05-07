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
    
	# .home_config can be anything in this example, just remember what you use
	git clone --recursive git://github.com/msbxii/home.git .home_config 

	# take whatever you want from that directory. ex if you want my 
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

    wget -O - https://raw.githubusercontent.com/msbxii/home/master/setup.sh | bash

__warning: dangerous.  look through the script before you run it to make sure it's not 
    going to break something on your machine.  Works best on fresh installs.__

The install script requires `git`, and attempts to automatically install it if not found.

A git repository will be created in `~/$HOME_CONFIG_REPO`, which defaults to .home_config_repo
in the script, but will use an existing value if you happen to set it before running the script.
You can set this location with

	export HOME_CONFIG_REPO=path/to/foo

The script then symlinks all the dotfiles in that repository into your home
directory. If you have existing config files, this operation will fail until
you backup and remove them.


I'm not sure if I like bash or zsh more at the moment but I'm just letting the user
choose per-machine.  I've emulated some of the git plugin functionality from zsh 
in bashrc because I really like having some status in the prompt.


