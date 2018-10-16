#   Fish Shell Configuration
#   Kent Huang

# Init configuration
set fish_greeting ""

source ~/.bashrc > /dev/null

# Set Go Path
set -x GOPATH ~/goenv/

# Powerline-shell
function fish_prompt
    ~/.powerline-shell.py $status --shell bare ^/dev/null
end

# set fish_function_path $fish_function_path "/usr/local/lib/python2.7/site-packages/powerline/bindings/fish/"
# powerline-setup

# NVM Fish Wrapper
#source ~/.config/fish/nvm-wrapper/nvm.fish

# Visual Studio Code
function code
    set -x VSCODE_CWD $PWD
    open -n -b "com.microsoft.VSCode" --args $argv
end
