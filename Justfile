# List available recipes
default:
    @just --list

link:
	# don't use folding for scripts - the .local/bin dir itself should always be owned by the machine
	stow --no-folding -t "$HOME" scripts

brew-dump:
	brew bundle dump -f

brew-check:
	brew bundle check

brew-install:
	brew bundle install
