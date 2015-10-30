#! /bin/bash

if [ ! -d ~/config/fish ]; then
    mkdir -p ~/config/fish
fi

if [ -f ~/.config/fish/config.fish ]; then
    echo "config.fish already exist"
    exit
fi

echo "Link config.fish to ~/.config/fish/"
ln -s `pwd`/fish/config.fish ~/.config/fish/config.fish


