# https://wiki.archlinux.org/title/XDG_Base_Directory#Support
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CONFIG_HOME=$HOME/.config
export XDG_STATE_HOME=$HOME/.local/state
export XDG_CACHE_HOME=$HOME/.cache

export MANPAGER='nvim +Man!'

PROMPT='=> zsh !%! ?%? %n [%~] $ '

alias qt="open -a 'quicktime player'"
alias httpsrv="python3 -m http.server"

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
