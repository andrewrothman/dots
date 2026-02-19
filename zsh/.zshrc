setopt interactivecomments

# https://github.com/jeffreytse/zsh-vi-mode
# brew install zsh-vi-mode
source /opt/homebrew/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh

PROMPT='=> zsh !%! ?%? %n [%~] $ '

alias v=nvim
alias vv='nvim .'
alias g=git
alias l='ls -l'
alias ll='ls -l'
alias la='ls -la'
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias cddk='cd $HOME/Desktop/'
alias cddl='cd $HOME/Downloads/'
alias qt="open -a 'quicktime player'"
alias httpsrv="python3 -m http.server"

function vf { nvim `fzf --select-1 -q "$1"` }

function tmp {
	# pushd $(mktemp -d /tmp/$1.XXXX)
	pushd $(mktemp -d -t tmp.$1)
}

function rsa-genkeypair() { openssl genrsa -out $1.pem 4096; openssl rsa -pubout -in $1.pem -out $1.pub.pem }
function rsa-enc() { openssl pkeyutl -encrypt -pubin -inkey $1 | base64 }
function rsa-dec() { base64 -d | openssl pkeyutl -decrypt -inkey $1 }

# opens a manpage in Preview.app
function prevman() {
	mandoc -T pdf "$(/usr/bin/man -w $@)" | open -fa Preview
}

# Customizations for acme 'win'
if [[ "$TERM_PROGRAM" == "win" ]]; then
	unsetopt zle
	unsetopt PROMPT_SP
	export NO_COLOR=1
	PS1='zsh %# '
fi



