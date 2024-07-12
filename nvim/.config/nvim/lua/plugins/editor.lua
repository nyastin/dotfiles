return {
  -- Theme Configurations
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

  { "rose-pine/neovim", name = "rose-pine" },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      transparent_background = true,
    },
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-macchiato",
    },
  },

  -- Telescope Configuration
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

  -- Bufferline Configuration
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
      { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
      { "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "Delete Other Buffers" },
      { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
      { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
      { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
      { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
      { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
      { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
      { "[B", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer prev" },
      { "]B", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer next" },
    },
    config = function()
      -- Integration of Catppuccin to bufferline
      local mocha = require("catppuccin.palettes").get_palette("mocha")
      require("bufferline").setup({
        highlights = require("catppuccin.groups.integrations.bufferline").get({
          styles = { "italic", "bold" },
          custom = {
            mocha = {
              background = { fg = mocha.text },
            },
            latte = {
              background = { fg = "#000000" },
            },
          },
        }),
        options = {
          close_command = function(n)
            LazyVim.ui.bufremove(n)
          end,
          right_mouse_command = function(n)
            LazyVim.ui.bufremove(n)
          end,
          diagnostics = "nvim_lsp",
          always_show_bufferline = false,
          diagnostics_indicator = function(_, _, diag)
            local icons = LazyVim.config.icons.diagnostics
            local ret = (diag.error and icons.Error .. diag.error .. " " or "")
              .. (diag.warning and icons.Warn .. diag.warning or "")
            return vim.trim(ret)
          end,
          offsets = {
            {
              filetype = "neo-tree",
              text = "Neo-tree",
              highlight = "Directory",
              text_align = "left",
            },
          },
          get_element_icon = function(opts)
            return LazyVim.config.icons.ft[opts.filetype]
          end,
        },
      })
      -- Fix bufferline when restoring a session
      vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
        callback = function()
          vim.schedule(function()
            pcall(nvim_bufferline)
          end)
        end,
      })
    end,
  },
}
