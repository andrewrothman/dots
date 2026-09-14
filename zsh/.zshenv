try_source() {
	[ -f "$1" ] && source "$1"
}

ZDOTDIR="$HOME/.zsh"
HISTFILE="$HOME/.zsh/history"

try_source "$HOME/.zshenv-local"
