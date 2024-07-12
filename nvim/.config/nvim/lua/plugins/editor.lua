return {
  -- {
  --   "folke/tokyonight.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   opts = {
  --     transparent = true,
  --     styles = {
  --       comments = { italic = false },
  --       keywords = { italic = false },
  --       sidebars = "transparent",
  --       floats = "transparent",
  --     },
  --     on_highlights = function(hl)
  --       hl.WinSeparator = {
  --         fg = "#3b4261",
  --       }
  --     end,
  --   },
  -- },

  { "rose-pine/neovim", name = "rose-pine", priority = 1000 },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "rose-pine-main",
    },
  },

  -- {
  --   "catppuccin/nvim",
  --   lazy = true,
  --   name = "catppuccin",
  --   opts = {
  --     integrations = {
  --       aerial = true,
  --       alpha = true,
  --       cmp = true,
  --       dashboard = true,
  --       flash = true,
  --       gitsigns = true,
  --       headlines = true,
  --       illuminate = true,
  --       indent_blankline = { enabled = true },
  --       leap = true,
  --       lsp_trouble = true,
  --       mason = true,
  --       markdown = true,
  --       mini = true,
  --       native_lsp = {
  --         enabled = true,
  --         underlines = {
  --           errors = { "undercurl" },
  --           hints = { "undercurl" },
  --           warnings = { "undercurl" },
  --           information = { "undercurl" },
  --         },
  --       },
  --       navic = { enabled = true, custom_bg = "lualine" },
  --       neotest = true,
  --       neotree = true,
  --       noice = true,
  --       notify = true,
  --       semantic_tokens = true,
  --       telescope = true,
  --       treesitter = true,
  --       treesitter_context = true,
  --       which_key = true,
  --     },
  --   },
  -- },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-macchiato",
    },
  },

  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      {
        "<leader>fp",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },
    },
    -- change some options
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "bottom" },
        sorting_strategy = "ascending",
        winblend = 0,
        file_ignored_patterns = {
          "node_modules",
          ".git",
          ".next",
          ".turbo",
          ".vercel",
          ".expo",
          ".open-next",
          ".sst",
          ".pio",
          "dist",
          "build",
          "out",
          "yarn.lock",
          "package-lock.json",
          "pnpm-lock.yaml",
          "npm-debug.log",
          "yarn-debug.log",
          "yarn-error.log",
          ".pnpm-debug.log",
          ".tsbuildinfo",
        },
      },
    },
  },
}
