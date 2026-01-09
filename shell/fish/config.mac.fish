#   Fish Shell Configuration
#   Kent Huang

# Init configuration
set fish_greeting ""

test -f ~/.config/fish/k8s.fish && source ~/.config/fish/k8s.fish > /dev/null
test -f ~/.config/fish/secrets.fish && source ~/.config/fish/secrets.fish >/dev/null

# Set Go Path
set -x GOPATH ~/goenv/
set -g -x PATH $PATH $GOPATH/bin
set -g -x PATH $PATH ~/bin

# Powerline-shell
function fish_prompt
    ~/GitHub/powerline-go/powerline-go -error $status -shell bare --modules "venv,user,ssh,cwd,perms,git,exit,root" -cwd-max-depth 3
end

function fish_right_prompt; end

# NVM Fish Wrapper
export NVM_DIR="$HOME/.nvm"

# Visual Studio Code
function code
    set -x VSCODE_CWD $PWD
    open -n -b "com.microsoft.VSCode" --args $argv
end

alias python="python3"
fish_add_path /opt/homebrew/bin
fish_prompt > /dev/null

pyenv init - fish | source
