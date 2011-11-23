msbxii's home config script
===========================

This repository contains my

     .bashrc
     .vimrc
     .zshrc
     .dircolors
     .vim/

and an installer for them.


auto-install
-------

copy & paste:

    wget -O - https://raw.github.com/msbxii/home/master/setup.sh | bash


then if you want, change your shell to `zsh` with
    
    chsh -s zsh

this can't usually be done automatically because of some 'security' or
something, I don't even know.

The install script requires `git` and `zsh`, and attempts to automatically install them. 

A git repository will be created in `~/$HOME_CONFIG_REPO`, which is defined by
the script and not very configurable.

The script then symlinks all the dotfiles in that repository into your home
directory. If you have existing config files, this operation will fail until
you backup and remove them.




