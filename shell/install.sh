#!/bin/bash
# @Author: Kent Huang
# @Date:   2015-11-05 00:00:52
# @Last Modified by:   Kent Huang
# @Last Modified time: 2016-08-31 01:44:32

# Environment
CUR_DIR=`pwd`
INSTALLER_DIR="$CUR_DIR/installer"
OS_TYPE=`uname`

# Module
moduleList=("nvm-fish-wrapper" 
            "powerline-shell" 
            "fish"
            "tmux")

# Update all submodule
git submodule init
git submodule update

cd $INSTALLER_DIR
for m in ${moduleList[*]}; do 
    echo "Install module $m..."
    sh $INSTALLER_DIR/$m.sh
done
