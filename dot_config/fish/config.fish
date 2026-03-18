# Fish Shell Configuration
# Kent Huang

# Init configuration
set fish_greeting ""

set -g -x PATH /opt/homebrew/bin $PATH ~/.cargo/bin ~/go/bin
alias ls 'ls -G'
# code - open VS Code
function code --wraps code --description 'Open VS Code'
    /Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code $argv
end

# Homebrew
eval (/opt/homebrew/bin/brew shellenv)

# Powerline-go prompt
function fish_prompt
    powerline-go -error $status --shell bare --modules "venv,user,ssh,cwd,perms,git,node,exit,root" -cwd-max-depth 3
end

# nvm
nvm use v22 > /dev/null

# pnpm
set -gx PNPM_HOME "$HOME/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end

# Default editor
set -gx EDITOR nvim
set -gx VISUAL nvim

export PAGER="less -r"

# Source local config for machine-specific settings and secrets
if test -f ~/.config/fish/local.fish
    source ~/.config/fish/local.fish
end
