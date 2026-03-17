#!/usr/bin/env bash
BASEDIR="$(cd "$(dirname "$0")" && pwd)"

# Create nvim config directory if needed
mkdir -p ~/.config

# Symlink nvim config
ln -sfn "$BASEDIR/nvim" ~/.config/nvim

echo "NeoVim config deployed to ~/.config/nvim"
echo ""
echo "Next steps:"
echo "  1. Clone Vundle into NeoVim bundle dir:"
echo "     git clone https://github.com/VundleVim/Vundle.vim.git ~/.config/nvim/bundle/vundle"
echo "  2. Open nvim and run :PluginInstall"
