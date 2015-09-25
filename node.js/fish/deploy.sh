#! /bin/sh
# Script to deploy nvm-fish-wrapper on Mac OSX 

if [ -d "~/.nvm" ]; then 
    echo "~/.nvm does exist"
    echo "Stop deploy nvm..."
elif [ ! `brew --prefix fish 2> /dev/null` ]; then
    echo "Error: Doesn't install fish shell"
else
    echo "Start deploy nvm..."
    nvm_path=`brew --prefix nvm 2> /dev/null`
    if [ $nvm_path ]; then
        echo $nvm_path
        mkdir ~/.nvm
        ln -s "$nvm_path/nvm.sh" ~/.nvm/nvm.sh
        cd ~/.config/fish/ && git clone git://github.com/passcod/nvm-fish-wrapper.git nvm-wrapper
        echo "source ~/.config/fish/nvm-wrapper/nvm.fish" >> ~/.config/fish/config.fish
        echo "End deploy nvm"
    else
        echo "Error: Doesn't install nvm by brew"
    fi
fi
