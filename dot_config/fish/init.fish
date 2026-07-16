# Fish shell initialization shared across supported platforms.

set fish_greeting ""

fish_add_path -gP \
    "$HOME/.cargo/bin" \
    "$HOME/go/bin" \
    "$HOME/.local/bin" \
    "$HOME/.bun/bin"

set -l homebrew_prefix

switch (uname -s)
    case Darwin
        alias ls 'ls -G'

        # Use the command bundled with the macOS Visual Studio Code app.
        if test -x '/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code'
            function code --wraps code --description 'Open Visual Studio Code'
                '/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code' $argv
            end
        end

        if test -d /opt/homebrew
            set homebrew_prefix /opt/homebrew
        else if test -d /usr/local/Homebrew
            set homebrew_prefix /usr/local
        end

        set -gx PNPM_HOME "$HOME/Library/pnpm"

    case Linux
        alias ls 'ls --color=auto'

        if test -d /home/linuxbrew/.linuxbrew
            set homebrew_prefix /home/linuxbrew/.linuxbrew
        end

        if set -q XDG_DATA_HOME; and test -n "$XDG_DATA_HOME"
            set -gx PNPM_HOME "$XDG_DATA_HOME/pnpm"
        else
            set -gx PNPM_HOME "$HOME/.local/share/pnpm"
        end

    case '*'
        set -gx PNPM_HOME "$HOME/.local/share/pnpm"
end

if test -n "$homebrew_prefix"
    set -gx HOMEBREW_PREFIX $homebrew_prefix
    set -gx HOMEBREW_CELLAR "$homebrew_prefix/Cellar"

    if test (uname -s) = Linux
        set -gx HOMEBREW_REPOSITORY "$homebrew_prefix/Homebrew"
    else
        set -gx HOMEBREW_REPOSITORY $homebrew_prefix
    end

    fish_add_path -gPm "$homebrew_prefix/bin" "$homebrew_prefix/sbin"
    set -q MANPATH; or set -gx MANPATH ''
    set -gx MANPATH "$homebrew_prefix/share/man" $MANPATH
    set -q INFOPATH; or set -gx INFOPATH ''
    set -gx INFOPATH "$homebrew_prefix/share/info" $INFOPATH
end

if not contains -- $PNPM_HOME $PATH
    set -gx PATH $PNPM_HOME $PATH
end
