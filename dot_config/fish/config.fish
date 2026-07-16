source "$__fish_config_dir/init.fish"

# Fish Shell Configuration
# Kent Huang

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
if type -q nvm; and nvm list v22 > /dev/null 2>&1
    nvm use v22 > /dev/null
end

# Default editor
set -gx EDITOR nvim
set -gx VISUAL nvim

export PAGER="less -r"

# Source local config for machine-specific settings and secrets
if test -f ~/.config/fish/local.fish
    source ~/.config/fish/local.fish
end
