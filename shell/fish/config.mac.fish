#   Fish Shell Configuration
#   Kent Huang

# Init configuration
set fish_greeting ""

# Set Go Path
set GOPATH ~/.goenv/

# Powerline-shell
function fish_prompt
    ~/.powerline-shell.py $status --shell bare ^/dev/null
end

# NVM Fish Wrapper
source ~/.config/fish/nvm-wrapper/nvm.fish
source ~/.config/fish/nvm-wrapper/nvm.fish

# Visual Studio Code
function code
    set -x VSCODE_CWD $PWD
    open -n -b "com.microsoft.VSCode" --args $argv
end
