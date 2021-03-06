#! /bin/bash

if [ -d ~/.vim ]; then
    echo "~/.vim already exist"
    exit
fi

if [ -f ~/.vimrc ]; then
    echo "~/.vimrc already exist"
    exit
fi

echo "Link vim folder to ~/.vim"
ln -s `pwd`/vim ~/.vim

echo "Link vimrc to ~/.vimrc"
ln -s `pwd`/vim/vimrc ~/.vimrc

if [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    echo "Install ctags and cscope"
    sudo apt-get install ctags cscope
fi

