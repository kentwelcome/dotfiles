# dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/).

## Stack

- **NeoVim** — Lua config with lazy.nvim, LSP, treesitter, telescope
- **Fish** — Shell
- **Tmux** — Terminal multiplexer with TPM + powerline

## Structure

```
Brewfile                         # Homebrew dependencies
dot_config/
├── fish/
│   ├── config.fish          → ~/.config/fish/config.fish
│   └── fish_plugins         → ~/.config/fish/fish_plugins
└── nvim/
    ├── init.lua             → ~/.config/nvim/init.lua
    └── lazy-lock.json       → ~/.config/nvim/lazy-lock.json
dot_tmux.conf                → ~/.tmux.conf
```

## Quick Setup

```bash
bash <(curl -s https://raw.githubusercontent.com/kentwelcome/dotfiles/main/setup.sh)
```

After setup:
1. Open `nvim` — plugins auto-install on first launch
2. Open `tmux` — press `prefix+I` to install TPM plugins
3. Create `~/.config/fish/local.fish` for machine-specific secrets

<details>
<summary>Manual step-by-step setup</summary>

```bash
brew install chezmoi
chezmoi init https://github.com/kentwelcome/dotfiles.git
brew bundle --file=$(chezmoi source-path)/Brewfile
chezmoi apply
fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher && fisher update"
```
</details>

### Machine-specific settings

Create `~/.config/fish/local.fish` for secrets and machine-specific config (API keys, work tools, etc.). This file is sourced automatically and should **not** be committed.

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
