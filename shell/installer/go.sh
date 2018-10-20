#!/bin/sh

# Check Environment
Red='\033[0;31m'
Green='\033[0;32m'
NC='\033[0m' # No Color
PASS="$Green[o]$NC"
FAIL="$Red[x]$NC"

module="go"

OS_TYPE=`uname`

if [ "$OS_TYPE" = "Linux" ]; then
    # TBD
elif [ "$OS_TYPE" = "Darwin" ]; then
    brew install go
    go get -u github.com/justjanne/powerline-go
fi

echo "$PASS $module install successfully"
