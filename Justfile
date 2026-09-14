# List available recipes
default:
	@just --list

link:
	# don't use folding for scripts - the .local/bin dir itself should always be owned by the machine
	stow --no-folding -t "$HOME" scripts
	stow -t "$HOME" ghostty
	stow -t "$HOME" git
	stow -t "$HOME" helix
	stow -t "$HOME" npm
	stow -t "$HOME" nvim
	stow -t "$HOME" tmux
	stow -t "$HOME" zsh

brew-dump:
	brew bundle dump -f

brew-check:
	brew bundle check

brew-install:
	brew bundle install
