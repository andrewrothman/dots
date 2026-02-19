# useful when optimizing zsh startup performance
# export REPORTTIME=0

# XDG Base Directory
# https://wiki.archlinux.org/title/XDG_Base_Directory#Support

export XDG_DATA_HOME=$HOME/.local/share
export XDG_CONFIG_HOME=$HOME/.config
export XDG_STATE_HOME=$HOME/.local/state
export XDG_CACHE_HOME=$HOME/.cache

if [ -z "$XDG_RUNTIME_DIR" ]; then
    # for macOS/BSD or non-systemd Linux
    export XDG_RUNTIME_DIR="/tmp/xdg-runtime-$UID"
    mkdir -p "$XDG_RUNTIME_DIR"
    chmod 700 "$XDG_RUNTIME_DIR"
fi

export EDITOR='nvim'
export VISUAL='nvim'
export MANPAGER='nvim +Man!'

# unset in cool-retro-term, suppresses a "man" warning
export LANG="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/src/dots/bin:$PATH"

eval "$(/opt/homebrew/bin/brew shellenv)"

# show node.js pending deprecation warning logs
# https://nodejs.org/docs/latest-v16.x/api/cli.html#node_pending_deprecation1
# export NODE_PENDING_DEPRECATION=1

export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

export PLAN9=/Users/ajr/src/plan9port export PLAN9
export PATH=$PATH:$PLAN9/bin:$HOME/.local/bin/acme
