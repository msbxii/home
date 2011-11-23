# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
EDITOR=vim

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="eric"

function etheme {
	TF="$ZSH/themes/$ZSH_THEME.zsh-theme"
	vim $TF
}

function loadtheme {
	TF="$ZSH/themes/$ZSH_THEME.zsh-theme"
	. $TF
}
# Set to this to use case-sensitive completion
CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=( git github command_not_found )

if [ -e /etc/debian_version ]; then
	plugins+=debian
fi

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:.


# Alases { 
	alias la='ls -a'
	alias lla='ls -la'

	alias ezrc="$EDITOR ~/.zshrc"
	alias evrc="$EDITOR ~/.vimrc"
# }


# bindkey -v

