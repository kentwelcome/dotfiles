#!/bin/sh
# @Author: Kent Huang
# @Date:   2015-11-04 23:52:22
# @Last Modified by:   Kent Huang
# @Last Modified time: 2016-08-31 01:37:26

# Check Environment
Red='\033[0;31m'
Green='\033[0;32m'
NC='\033[0m' # No Color
PASS="$Green[o]$NC"
FAIL="$Red[x]$NC"

module="<template>"
module_dir="../$module"
cd $module_dir
module_dir=`pwd`

echo "$PASS $module install successfully"
