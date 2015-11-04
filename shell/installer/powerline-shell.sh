#!/bin/sh
# @Author: Kent Huang
# @Date:   2015-11-04 23:52:22
# @Last Modified by:   Kent Huang
# @Last Modified time: 2015-11-05 02:02:45

# Check Environment
Red='\033[0;31m'
Green='\033[0;32m'
NC='\033[0m' # No Color
PASS="$Green[o]$NC"
FAIL="$Red[x]$NC"

module="powerline-shell"
module_dir="../$module"
cd $module_dir
module_dir=`pwd`

if [ -f ~/.powerline-shell.py ]; then
    echo "$PASS ~/.powerline-shell.py already exist"
    exit
fi

cp config.py.dist config.py

python $module_dir/install.py

ln -s $module_dir/powerline-shell.py ~/.powerline-shell.py

echo "$PASS $module install successfully"
