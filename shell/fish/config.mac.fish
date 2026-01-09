#   Fish Shell Configuration
#   Kent Huang

# Init configuration
set fish_greeting ""

source ~/.config/fish/k8s.fish > /dev/null
source ~/.config/fish/git-together.fish > /dev/null

# Set Go Path
set -x GOPATH ~/goenv/
set -g -x PATH $PATH $GOPATH/bin
set -g -x PATH $PATH ~/.infuseai/bin

# Powerline-shell
function fish_prompt
    #~/.powerline-shell.py $status --shell bare ^/dev/null
    ~/GitHub/powerline-go/powerline-go -error $status -shell bare --modules "kube,venv,user,ssh,cwd,perms,git,node,exit,root" -cwd-max-depth 3
end

function fish_right_prompt; end

# set fish_function_path $fish_function_path "/usr/local/lib/python2.7/site-packages/powerline/bindings/fish/"
# powerline-setup

# NVM Fish Wrapper
source ~/.config/fish/nvm-wrapper/nvm.fish

# Visual Studio Code
function code
    set -x VSCODE_CWD $PWD
    open -n -b "com.microsoft.VSCode" --args $argv
end
