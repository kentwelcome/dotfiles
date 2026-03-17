# CLAUDE.md - Dotfiles Repository Guide

Personal dotfiles for Kent Huang, managed with [chezmoi](https://www.chezmoi.io/).

## Stack

- **NeoVim** — Lua config with lazy.nvim
- **Fish** — Shell
- **Tmux** — Terminal multiplexer with TPM

## Repository Structure

```
dotfiles/
├── dot_config/
│   ├── fish/
│   │   └── config.fish          → ~/.config/fish/config.fish
│   └── nvim/
│       ├── init.lua             → ~/.config/nvim/init.lua
│       └── lazy-lock.json       → ~/.config/nvim/lazy-lock.json
├── dot_tmux.conf                → ~/.tmux.conf
├── .chezmoiignore
├── .editorconfig
└── .gitignore
```

Chezmoi naming: `dot_` prefix maps to `.` (e.g., `dot_config/` → `~/.config/`).

## Branch Strategy

- `main` — Default branch for all work and PRs
- Legacy device branches (`master`, `MacBookPro`, `MacBookAir`, `MacMini`) are archived

## Key Configuration Files

| File | Description |
|------|-------------|
| `dot_config/nvim/init.lua` | NeoVim config with LSP, treesitter, telescope, nvim-cmp |
| `dot_config/fish/config.fish` | Fish shell configuration |
| `dot_tmux.conf` | Tmux with vim-style navigation + TPM |

## Installation

```bash
brew install chezmoi
chezmoi init https://github.com/kentwelcome/dotfiles.git
chezmoi diff    # preview
chezmoi apply   # apply
```

After applying:
- Open `nvim` — lazy.nvim auto-installs plugins on first launch
- Open `tmux` — press `prefix + I` to install TPM plugins

## Common Tasks

### Adding NeoVim Plugins

1. Edit `dot_config/nvim/init.lua`, add plugin to the `require("lazy").setup({...})` block
2. Run `chezmoi apply` then open `nvim` — lazy.nvim auto-installs

### Updating Configs

```bash
chezmoi edit ~/.config/nvim/init.lua   # edit via chezmoi
chezmoi apply                           # apply changes
chezmoi cd                              # cd into source dir for git operations
```

### Adding Tmux Plugins

1. Add `set -g @plugin 'author/plugin'` to `dot_tmux.conf`
2. Run `chezmoi apply` then `prefix + I` in tmux

## NeoVim Keybindings

| Key | Action |
|-----|--------|
| `F3` | Toggle line numbers |
| `F7` | Toggle file tree (nvim-tree) |
| `Space+ff` | Find files (telescope) |
| `Space+fg` | Live grep (telescope) |
| `Space+fb` | Buffers (telescope) |
| `gd` / `gr` / `K` | Go-to-definition / references / hover (LSP) |
| `Space+rn` | Rename symbol |
| `Space+ca` | Code action |
| `Ctrl+\` | Toggle terminal |

## Tmux Keybindings

| Key | Action |
|-----|--------|
| `Ctrl+A` | Prefix (screen-compatible) |
| `prefix+s` | Split vertical |
| `prefix+v` | Split horizontal |
| `prefix+h/j/k/l` | Navigate panes (vim-style) |
| `prefix+</>/+/-` | Resize panes |
| `prefix+I` | Install TPM plugins |
| `prefix+U` | Update TPM plugins |

## Conventions

- NeoVim plugins: lazy.nvim (Lua-native, lazy-loaded)
- Tmux plugins: TPM (no git submodules)
- Symlinks: chezmoi (no manual deploy scripts)
- Indent: 4 spaces default, 2 spaces for Lua/JSON/YAML (see `.editorconfig`)
