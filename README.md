# dotfiles

## Tools

### Required

- git
- stow
- zsh
- tmux
- neovim
- fzy
- hub
- [fish](https://fishshell.com)
	- [fisher](https://github.com/jorgebucaran/fisher)
	- [fzf.fish](https://github.com/PatrickF1/fzf.fish)
- [pfetch](https://github.com/dylanaraps/pfetch)
- [zoxide](https://github.com/ajeetdsouza/zoxide)

- ghostty
- Monaspace fonts (esp. Xenon)

### Optional

- tree
- ripgrep
- bat
- fzf

## Setup

```bash
git clone git@github.com:andrewrothman/dots.git
cd dots

stow zsh -t ~
stow fish -t ~
stow nvim -t ~
stow ghostty -t ~
stow tmux -t ~
```
