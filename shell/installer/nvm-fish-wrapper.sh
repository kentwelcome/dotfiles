#!/bin/sh
# @Author: Kent Huang
# @Date:   2015-11-04 23:52:17
# @Last Modified by:   Kent Huang
# @Last Modified time: 2015-11-05 02:02:41

# Check Environment
Red='\033[0;31m'
Green='\033[0;32m'
NC='\033[0m' # No Color
PASS="$Green[o]$NC"
FAIL="$Red[x]$NC"

module="nvm-fish-wrapper"
module_dir="../$module"
cd $module_dir
module_dir=`pwd`

if [ -d ~/.config/fish/nvm-wrapper ]; then
    echo "$PASS ~/.config/fish/nvm-wrapper already exist"
    exit
fi

mkdir -p ~/.config/fish/

ln -s $module_dir ~/.config/fish/nvm-wrapper

echo "$PASS $module install successfully"