# List available recipes
default:
    @just --list

brew-dump:
	brew bundle dump -f

brew-check:
	brew bundle check

brew-install:
	brew bundle install
