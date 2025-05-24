# dotfiles

```bash
mkdir -p $HOME/src
git clone git@github.com:andrewrothman/dots.git $HOME/src/dots
cd $HOME/src/dots

stow zsh -t ~
stow nvim -t ~
stow tmux -t ~
stow git -t ~
stow ghostty -t ~
stow fish -t ~
```

## Required

- [fish](https://fishshell.com)
	- [fisher](https://github.com/jorgebucaran/fisher)
	- [fzf.fish](https://github.com/PatrickF1/fzf.fish)
