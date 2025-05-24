#!/usr/bin/env bash
set -euo pipefail

REPO="https://github.com/pduchnovsky/dotfiles.git"
DIR="$HOME/.dotfiles"
BKP="$HOME/.dotfiles-backup"
BREWFILE="$HOME/Brewfile"

command -v brew &>/dev/null || {
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null || /usr/local/bin/brew shellenv 2>/dev/null || /home/linuxbrew/.linuxbrew/bin/brew shellenv)"
}

git config --global fetch.prune true
git config --global push.autoSetupRemote true
git clone --bare "$REPO" "$DIR" || true

cfg() { git --git-dir="$DIR" --work-tree="$HOME" "$@"; }

cfg checkout 2>/dev/null || {
    mkdir -p "$BKP"
    cfg checkout 2>&1 | grep -oE '\s+\..*' | while read -r f; do
        f=$(xargs <<<"$f")
        mkdir -p "$(dirname "$BKP/$f")"
        mv "$HOME/$f" "$BKP/$f"
    done
    cfg checkout
}

cfg config status.showUntrackedFiles no
[[ -f "$BREWFILE" ]] && brew bundle --file="$BREWFILE"
