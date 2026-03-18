#!/bin/bash
# Bootstrap script for new machine setup
# Usage: bash setup.sh

set -e

echo "==> Installing Homebrew (if needed)"
if ! command -v brew &>/dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

echo "==> Installing chezmoi"
brew install chezmoi

echo "==> Initializing dotfiles"
chezmoi init https://github.com/kentwelcome/dotfiles.git

echo "==> Installing Homebrew dependencies"
brew bundle --file="$(chezmoi source-path)/Brewfile"

echo "==> Applying dotfiles"
chezmoi apply

echo "==> Installing fisher and fish plugins"
fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher && fisher update"

echo ""
echo "Done! Next steps:"
echo "  1. Open nvim — plugins auto-install on first launch"
echo "  2. Open tmux — press prefix+I to install TPM plugins"
echo "  3. Create ~/.config/fish/local.fish for machine-specific secrets"
