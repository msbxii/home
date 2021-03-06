USER_HOST="%{$fg_bold[magenta]%}%n%{$reset_color%} at %{$fg_bold[yellow]%}%m%{$reset_color%}"

function collapse_pwd {
	echo $(pwd | sed -e "s,^$HOME,~,")
}
END="%{$reset_color%}"

function color_pwd {
	COLOR1="%{$fg_bold[green]%}"
	TEXT="${PWD/#$HOME/~}"

	echo "${COLOR1}${TEXT}${END}"
}

function prompt_char {
	git branch > /dev/null 2> /dev/null && echo '±' && return
	hg root > /dev/null 2> /dev/null && echo '☿' && return
	echo '$'
}

git_ahead() {
	git branch > /dev/null 2>/dev/null || return
	git status | grep 'ahead of origin' && echo "%{$fg_bold[magenta]%}[ahead]%{$reset_color%}"
}

PROMPT='$USER_HOST in $(color_pwd) $(git_prompt_info) $(git_ahead)'

case $(whoami) in
	root) 
		PCHAR_COLOR='%{$fg_bold[red]%}'
;;
	*)
		PCHAR_COLOR='%{$fg_bold[cyan]%}'
;;
esac

PROMPT="
$PROMPT
${PCHAR_COLOR}"'$(prompt_char)$END '

ZSH_THEME_GIT_PROMPT_PREFIX="on %{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%}!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%}?"
ZSH_THEME_GIT_PROMPT_CLEAN=""

# vim style key bindings! my life is complete!
# bindkey -v
# bindkey -rpM viins '\e'
# on second though it gets really annoying. They're vi-style

# vim: set filetype=sh :
