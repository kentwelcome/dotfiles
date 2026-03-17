# dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/).

## Stack

- **NeoVim** — Lua config with lazy.nvim, LSP, treesitter, telescope
- **Fish** — Shell
- **Tmux** — Terminal multiplexer with TPM + powerline

## Structure

```
dot_config/
├── fish/
│   └── config.fish          → ~/.config/fish/config.fish
└── nvim/
    ├── init.lua             → ~/.config/nvim/init.lua
    └── lazy-lock.json       → ~/.config/nvim/lazy-lock.json
dot_tmux.conf                → ~/.tmux.conf
```

## Setup

```bash
# Install chezmoi
brew install chezmoi

# Initialize from this repo
chezmoi init https://github.com/kentwelcome/dotfiles.git

# Preview changes
chezmoi diff

# Apply
chezmoi apply
```

## NeoVim Plugins

| Plugin | Purpose |
|--------|---------|
| lazy.nvim | Plugin manager |
| lualine.nvim | Status line (powerline theme) |
| nvim-tree.lua | File explorer |
| telescope.nvim | Fuzzy finder |
| nvim-treesitter | Syntax highlighting |
| nvim-lspconfig + mason | LSP (Go, C/C++, TypeScript, Python, Lua) |
| nvim-cmp + LuaSnip | Completion + snippets |
| gitsigns.nvim | Git gutter signs |
| nvim-surround | Surround editing |
| nvim-autopairs | Auto-close brackets |
| toggleterm.nvim | Integrated terminal |
| which-key.nvim | Keybinding hints |

## NeoVim Keybindings

| Key | Action |
|-----|--------|
| `F3` | Toggle line numbers |
| `F7` | Toggle file tree |
| `Space+ff` | Find files |
| `Space+fg` | Live grep |
| `Space+fb` | Buffers |
| `gd` | Go to definition |
| `gr` | References |
| `K` | Hover docs |
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
