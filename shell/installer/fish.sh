#!/bin/sh
# @Author: Kent Huang
# @Date:   2015-11-05 01:20:50
# @Last Modified by:   Kent Huang
# @Last Modified time: 2015-11-05 02:04:50

# Check Environment
Red='\033[0;31m'
Green='\033[0;32m'
NC='\033[0m' # No Color
PASS="$Green[o]$NC"
FAIL="$Red[x]$NC"

module="fish"
module_dir="../$module"
cd $module_dir
module_dir=`pwd`

OS_TYPE=`uname`

if [ -f ~/.config/fish/config.fish ]; then
    echo "$PASS ~/.config/fish/config.fish already exist"
    exit
fi

if [ "$OS_TYPE" = "Linux" ]; then
    ln -s $module_dir/config.linux.fish ~/.config/fish/config.fish
elif [ "$OS_TYPE" = "Darwin" ]; then
    ln -s $module_dir/config.mac.fish ~/.config/fish/config.fish
fi

echo "$PASS $module install successfully"
