return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true,
      styles = {
        comments = { italic = false },
        keywords = { italic = false },
        sidebars = "transparent",
        floats = "transparent",
      },
      on_highlights = function(hl)
        hl.WinSeparator = {
          fg = "#3b4261",
        }
      end,
    },
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight-night",
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
