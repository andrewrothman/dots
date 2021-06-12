# dotfiles

## Tools

### Required

- git
- stow
- tmux
- neovim
- fzy
- hub

- alacritty
- Ioseveka Fixed

### Optional

- tree
- ripgrep
- bat
- fzf
- karabiner (for mac)

### Node.js / React.js / JavaScript / TypeScript

- n
- deno
- efm-langserver

## Setup

```bash
git clone git@github.com:andrewrothman/dots.git
cd dots

stow nvim -t ~
stow alacritty -t 
stow tmux -t ~
stow efm-langserver -t ~

# on mac
stow karabiner -t ~
```

## Manual

Add a NeoVim plugin:
```bash
git submodule add https://github.com/folke/trouble.nvim nvim/.local/share/nvim/site/pack/trouble.nvim/start/trouble.nvim
```

Update NeoVim plugin:

```bash
git submodule foreach git pull
```
