-- Kent's NeoVim init.lua
-- Kent Huang <kentwelcome@gmail.com>
-- Modern IDE setup with lazy.nvim

---------------------------------------------------------------------------
-- General Settings
---------------------------------------------------------------------------
vim.opt.backspace = "2"
vim.opt.history = 50
vim.opt.ruler = true
vim.opt.autoread = true
vim.opt.number = true
vim.opt.showcmd = true
vim.opt.showmatch = true
vim.opt.showmode = true
vim.opt.cursorline = true
vim.opt.clipboard = "unnamedplus"
vim.opt.wildmenu = true
vim.opt.wildignore = { "*.o", "*.class", "*.pyc" }

-- Search
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Indentation
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.copyindent = true
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

-- No backup files
vim.opt.backup = false

-- Disable sound on errors
vim.opt.errorbells = false
vim.opt.visualbell = false

-- Appearance
vim.opt.background = "dark"
vim.opt.laststatus = 2
vim.opt.termguicolors = true

-- Shada (session history)
vim.opt.shada = "'10,\"100,:20,%,n~/.local/state/nvim/shada/main.shada"

-- Makefile uses tabs
vim.api.nvim_create_autocmd("FileType", {
  pattern = "make",
  callback = function()
    vim.opt_local.expandtab = false
  end,
})

-- C/C++ specific settings
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp", "cc" },
  callback = function()
    vim.opt_local.cindent = true
    vim.opt_local.comments = "sr:/*,mb:*,el:*/,://"
    vim.opt_local.cinoptions = ">s,e0,n0,f0,{0,}0,^-1s,:0,=s,g0,h1s,p2,t0,+2,(2,)20,*30"
  end,
})

-- Restore cursor position from previous session
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local line_count = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= line_count then
      vim.api.nvim_win_set_cursor(0, mark)
    end
  end,
})

---------------------------------------------------------------------------
-- Keybindings (preserved from vimrc)
---------------------------------------------------------------------------
vim.keymap.set("n", "<F3>", ":set nonumber!<CR>", { desc = "Toggle line numbers" })

-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

---------------------------------------------------------------------------
-- Bootstrap lazy.nvim
---------------------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

---------------------------------------------------------------------------
-- Plugins
---------------------------------------------------------------------------
require("lazy").setup({

  -- Colorscheme (ir_black)
  {
    "wesgibbs/vim-irblack",
    priority = 1000,
    config = function()
      vim.cmd("colorscheme ir_black")
      -- Use terminal background instead of pure black
      vim.api.nvim_set_hl(0, "Normal", { fg = "#f6f3e8", bg = "NONE" })
      vim.api.nvim_set_hl(0, "NonText", { fg = "#070707", bg = "NONE" })
      vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = "#070707", bg = "NONE" })
      vim.api.nvim_set_hl(0, "LineNr", { fg = "#3D3D3D", bg = "NONE" })
      vim.api.nvim_set_hl(0, "CursorLine", { bg = "#121212" })
      vim.api.nvim_set_hl(0, "Visual", { bg = "#262D51" })
    end,
  },

  -- Status line (replaces powerline/airline)
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "powerline",
          component_separators = { left = "\u{e0b1}", right = "\u{e0b3}" },
          section_separators = { left = "\u{e0b0}", right = "\u{e0b2}" },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { "filename" },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
      })
    end,
  },

  -- File explorer (replaces NERDTree/Trinity)
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<F7>", "<cmd>NvimTreeToggle<CR>", desc = "Toggle file tree" },
    },
    config = function()
      require("nvim-tree").setup({
        view = { width = 30 },
        filters = { dotfiles = false },
      })
    end,
  },

  -- Fuzzy finder (replaces bufexplorer, cscope navigation)
  {
    "nvim-telescope/telescope.nvim",
    tag = "v0.2.1",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Live grep" },
      { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Help tags" },
      { "<leader>fs", "<cmd>Telescope lsp_document_symbols<CR>", desc = "Document symbols" },
      { "<leader>fr", "<cmd>Telescope lsp_references<CR>", desc = "References" },
      { "<leader>fd", "<cmd>Telescope diagnostics<CR>", desc = "Diagnostics" },
    },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          file_ignore_patterns = { "node_modules", ".git/" },
        },
      })
      telescope.load_extension("fzf")
    end,
  },

  -- Treesitter (AST-based syntax highlighting)
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "c", "cpp", "go", "lua", "vim", "vimdoc",
          "javascript", "typescript", "python", "bash",
          "json", "yaml", "html", "css", "markdown",
        },
        highlight = { enable = true },
      })
    end,
  },

  -- LSP (replaces cscope, ctags)
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "gopls",
          "clangd",
          "ts_ls",
          "pyright",
        },
      })

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- LSP keybindings (on attach)
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(ev)
          local opts = { buffer = ev.buf }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
          vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
        end,
      })

      -- Setup servers using vim.lsp.config (NeoVim 0.11+)
      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = { globals = { "vim" } },
            },
          },
        },
        gopls = {},
        clangd = {},
        ts_ls = {},
        pyright = {},
      }
      for server, settings in pairs(servers) do
        settings.capabilities = capabilities
        vim.lsp.config(server, settings)
        vim.lsp.enable(server)
      end
    end,
  },

  -- Autocompletion (replaces neocomplcache, AutoComplPop)
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
          { name = "path" },
        }),
      })

      -- Cmdline completion
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })
    end,
  },

  -- Git signs in gutter
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "+" },
          change = { text = "~" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
        },
      })
    end,
  },

  -- Surround (same as vim-surround)
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup()
    end,
  },

  -- Autopairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup()
    end,
  },

  -- Integrated terminal
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = {
      { "<C-\\>", "<cmd>ToggleTerm<CR>", desc = "Toggle terminal" },
    },
    config = function()
      require("toggleterm").setup({
        open_mapping = [[<C-\>]],
        direction = "horizontal",
        size = 15,
      })
    end,
  },

  -- Which-key (keybinding hints)
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("which-key").setup()
    end,
  },

  -- Go development (kept from original)
  { "fatih/vim-go", ft = "go" },

  -- Fish shell syntax
  { "dag/vim-fish", ft = "fish" },

  -- EditorConfig
  { "editorconfig/editorconfig-vim" },

  -- GitHub Copilot
  {
    "github/copilot.vim",
    event = "InsertEnter",
    config = function()
      vim.g.copilot_no_tab_map = true
      -- Accept suggestion with Ctrl+J (avoid conflict with Tab completion)
      vim.keymap.set("i", "<C-j>", 'copilot#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = false,
        desc = "Copilot accept",
      })
      -- Navigate suggestions
      vim.keymap.set("i", "<C-]>", "<Plug>(copilot-next)", { desc = "Copilot next suggestion" })
      vim.keymap.set("i", "<C-[>", "<Plug>(copilot-previous)", { desc = "Copilot previous suggestion" })
      -- Dismiss suggestion
      vim.keymap.set("i", "<C-\\>", "<Plug>(copilot-dismiss)", { desc = "Copilot dismiss" })
    end,
  },

  -- Copilot Chat
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      "github/copilot.vim",
      "nvim-lua/plenary.nvim",
    },
    build = "make tiktoken",
    keys = {
      { "<leader>cc", "<cmd>CopilotChatToggle<CR>", desc = "Copilot Chat toggle" },
      { "<leader>ce", "<cmd>CopilotChatExplain<CR>", mode = "v", desc = "Copilot explain selection" },
      { "<leader>cr", "<cmd>CopilotChatReview<CR>", mode = "v", desc = "Copilot review selection" },
      { "<leader>cf", "<cmd>CopilotChatFix<CR>", mode = "v", desc = "Copilot fix selection" },
      { "<leader>ct", "<cmd>CopilotChatTests<CR>", mode = "v", desc = "Copilot generate tests" },
    },
    config = function()
      require("CopilotChat").setup({
        window = {
          layout = "vertical",
          width = 0.3,
        },
      })
    end,
  },
})
