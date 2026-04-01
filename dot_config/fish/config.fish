# Fish Shell Configuration
# Kent Huang

# Init configuration
set fish_greeting ""

set -g -x PATH $PATH ~/.cargo/bin ~/go/bin ~/.local/bin /Users/kent/.bun/bin /opt/homebrew/bin
alias ls 'ls -G'
# code - open VS Code
function code --wraps code --description 'Open VS Code'
    /Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code $argv
end

# Homebrew
set -gx HOMEBREW_PREFIX /opt/homebrew
set -gx HOMEBREW_CELLAR /opt/homebrew/Cellar
set -gx HOMEBREW_REPOSITORY /opt/homebrew
fish_add_path -gP /opt/homebrew/bin /opt/homebrew/sbin
set -q MANPATH; or set -gx MANPATH ''
set -gx MANPATH /opt/homebrew/share/man $MANPATH
set -gx INFOPATH /opt/homebrew/share/info $INFOPATH

# Powerline-go prompt
function fish_prompt
    set -l last_status $status
    set -l modules "venv,user,ssh,cwd,perms,git,exit,root"
    if set -q APP_SANDBOX_CONTAINER_ID
        set modules "shell-var,$modules"
        set -gx SAFEHOUSE "🔒"
    else
        set -e SAFEHOUSE
    end
    powerline-go -error $last_status --shell bare --modules $modules -shell-var SAFEHOUSE -shell-var-no-warn-empty -cwd-max-depth 3
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
