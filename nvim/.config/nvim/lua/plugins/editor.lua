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

  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      local palette = require("rose-pine.palette")
      require("rose-pine").setup({
        variant = "moon",
        styles = {
          transparency = true,
          italics = true,
        },
        highlight_groups = {
          CursorLineNr = {
            fg = palette.foam,
          },
        },
      })
      vim.cmd([[colorscheme rose-pine-moon]])
    end,
  },

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
      colorscheme = "rose-pine",
    },
  },

  {
    "folke/snacks.nvim",
    opts = {
      scroll = {
        enabled = false,
      },
      picker = {
        sources = {
          files = {
            -- Include hidden files and specify glob patterns to include .env files
            hidden = true,
            ignored = true,
            glob = { "*.env", ".env.*" }, -- Include .env files and variants like .env.example
            exclude = { -- Exclude specific patterns
              "**/node_modules/*",
              "**/.next/*",
              "**/.turbo/*",
              ".vercel/",
              ".expo/",
              ".open-next/",
              "**/.sst/*",
              ".pio/",
              "dist/",
              "build/",
              "out/",
              "yarn.lock",
              "package-lock.json",
              "pnpm-lock.yaml",
              "npm-debug.log",
              "yarn-debug.log",
              "yarn-error.log",
              ".pnpm-debug.log",
              ".tsbuildinfo",
              -- Add other patterns as needed
            },
          },
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
        -- highlights = require("catppuccin.groups.integrations.bufferline").get({
        --   styles = { "italic", "bold" },
        --   custom = {
        --     mocha = {
        --       background = { fg = mocha.text },
        --     },
        --     latte = {
        --       background = { fg = "#000000" },
        --     },
        --   },
        -- }),
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
              filetype = "snacks_picker_list",
              text = "File Explorer",
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

  -- Lualine Configuration
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) > 0 then
        -- set an empty statusline till lualine loads
        vim.o.statusline = " "
      else
        -- hide the statusline on the starter page
        vim.o.laststatus = 0
      end
    end,
    opts = function()
      -- PERF: we don't need this lualine require madness 🤷
      local lualine_require = require("lualine_require")
      lualine_require.require = require

      local icons = LazyVim.config.icons

      vim.o.laststatus = vim.g.lualine_laststatus

      local get_top_level_folder_name = function()
        local cwd = vim.fn.getcwd()
        return vim.fn.fnamemodify(cwd, ":t")
      end

      local opts = {
        options = {
          theme = "auto", -- You can change this to your preferred theme
          component_separators = "",
          section_separators = { left = "", right = "" },
          globalstatus = vim.o.laststatus == 3,
          disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter" } },
        },
        sections = {
          lualine_a = { { "mode", separator = { left = "" }, padding = { left = 0, right = 2 } } },
          lualine_b = { "filename", "branch" },
          lualine_c = {
            "%=", -- Placeholder for center components, modify as needed
            {
              "diagnostics",
              symbols = {
                error = icons.diagnostics.Error,
                warn = icons.diagnostics.Warn,
                info = icons.diagnostics.Info,
                hint = icons.diagnostics.Hint,
              },
            },
            { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            { LazyVim.lualine.pretty_path() },
          },
          lualine_x = {
            {
              function()
                return require("noice").api.status.command.get()
              end,
              cond = function()
                return package.loaded["noice"] and require("noice").api.status.command.has()
              end,
              color = function()
                return { fg = Snacks.util.color("Statement") }
              end,
            },
            {
              function()
                return require("noice").api.status.mode.get()
              end,
              cond = function()
                return package.loaded["noice"] and require("noice").api.status.mode.has()
              end,
              color = function()
                return { fg = Snacks.util.color("Constant") }
              end,
            },
            {
              function()
                return "  " .. require("dap").status()
              end,
              cond = function()
                return package.loaded["dap"] and require("dap").status() ~= ""
              end,
              color = function()
                return { fg = Snacks.util.color("Debug") }
              end,
            },
            {
              require("lazy.status").updates,
              cond = require("lazy.status").has_updates,
              color = function()
                return { fg = Snacks.util.color("Special") }
              end,
            },
            {
              "diff",
              symbols = {
                added = icons.git.added,
                modified = icons.git.modified,
                removed = icons.git.removed,
              },
              source = function()
                local gitsigns = vim.b.gitsigns_status_dict
                if gitsigns then
                  return {
                    added = gitsigns.added,
                    modified = gitsigns.changed,
                    removed = gitsigns.removed,
                  }
                end
              end,
            },
          },
          lualine_y = {
            { "filetype", "progress" },
          },
          lualine_z = {
            { "location", separator = { right = "" }, padding = { left = 2, right = 1 } },
            {
              function()
                return " " .. os.date("%I:%M")
              end,
              separator = { right = "" },
              padding = { left = 1, right = 1 },
            },
          },
        },
        inactive_sections = {
          lualine_a = { "filename" },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = { "location" },
        },
        -- extensions = { "neo-tree", "lazy" },
        extensions = {
          {
            sections = {
              lualine_a = {
                { "mode", separator = { left = "" }, padding = { left = 0, right = 2 } },
              },
              lualine_b = { "branch" },
              lualine_c = {
                "%=", -- Placeholder for center components, modify as needed
              },
              lualine_x = {},
              lualine_y = { "filetype" },
              lualine_z = {
                {
                  function()
                    return " " .. os.date("%I:%M")
                  end,
                  separator = { right = "" },
                  padding = { left = 1, right = 1 },
                },
              },
            },
            filetypes = { "snacks_picker_list" },
          },
          "lazy",
        },
      }

      -- do not add trouble symbols if aerial is enabled
      if vim.g.trouble_lualine and LazyVim.has("trouble.nvim") then
        local trouble = require("trouble")
        local symbols = trouble.statusline
          and trouble.statusline({
            mode = "symbols",
            groups = {},
            title = false,
            filter = { range = true },
            format = "{kind_icon}{symbol.name:Normal}",
            hl_group = "lualine_c_normal",
          })
        table.insert(opts.sections.lualine_c, {
          symbols and symbols.get,
          cond = symbols and symbols.has,
        })
      end

      return opts
    end,
  },

  {
    "saghen/blink.cmp",
    opts = function(_, opts)
      -- Configure the completion menu with a border
      opts.completion = opts.completion or {}
      opts.completion.menu = opts.completion.menu or {}
      opts.completion.menu.border = "rounded" -- Adds a rounded border to the completion menu
      opts.completion.menu.winhighlight =
        "Normal:Normal,FloatBorder:FloatBorder,CursorLine:BlinkCmpMenuSelection,Search:None"

      -- Configure the documentation window with a border
      opts.completion.documentation = opts.completion.documentation or {}
      opts.completion.documentation.window = opts.completion.documentation.window or {}
      opts.completion.documentation.window.border = "rounded" -- Adds a rounded border to the documentation window
      opts.completion.documentation.window.winhighlight =
        "Normal:Normal,FloatBorder:FloatBorder,CursorLine:BlinkCmpDocCursorLine,Search:None"
    end,
  },

  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      local util = require("conform.util")

      -- Detect local or global Biome
      local function is_biome_present()
        return util.from_node_modules("biome") or vim.fn.executable("biome") == 1
      end

      -- Conditional filetype mapping
      local biome_first = is_biome_present()

      opts.formatters_by_ft = {
        python = { "black", "isort" },

        -- JS/TS-based
        typescript = biome_first and { "biome" } or { "eslint_d", "prettier" },
        javascript = biome_first and { "biome" } or { "eslint_d", "prettier" },
        typescriptreact = biome_first and { "biome" } or { "eslint_d", "prettier" },
        javascriptreact = biome_first and { "biome" } or { "eslint_d", "prettier" },

        -- Others
        json = biome_first and { "biome" } or { "prettier" },
        html = biome_first and { "biome" } or { "prettier" },
        css = biome_first and { "biome" } or { "prettier" },
        yaml = { "prettier" },
      }

      opts.formatters = vim.tbl_extend("force", opts.formatters or {}, {
        black = {
          prepend_args = { "--line-length", "79", "--skip-string-normalization" },
        },
        biome = {
          command = util.from_node_modules("biome"),
          stdin = true,
          args = { "check", "--write", "--stdin-file-path", "$FILENAME" },
          condition = function(ctx)
            -- Run only if Biome exists AND project has a config
            --  TODO: proper condition
            return is_biome_present()
              and vim.fs.find({ ".biome.json", "biome.json" }, { upward = true, path = ctx.filename })[1] ~= nil
          end,
        },
      })
    end,
  },
}
