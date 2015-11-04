#   Fish Shell Configuration
#   Kent Huang

# Init configuration
set fish_greeting ""

# Powerline-shell
function fish_prompt
    ~/.powerline-shell.py $status --shell bare ^/dev/null
end

# NVM Fish Wrapper
. ~/.config/fish/nvm-wrapper/nvm.fish

