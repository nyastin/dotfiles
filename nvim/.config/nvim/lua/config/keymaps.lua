-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true, desc = "" }

-- Scroll down
opts.desc = "Scroll down"
keymap("n", "<C-d>", "<C-d>zz", opts)

-- Update opts for the next keymap
opts.desc = "Scroll up"
keymap("n", "<C-u>", "<C-u>zz", opts)

-- Telescope
local builtin = require("telescope.builtin")

opts.desc = "Live Grep"
keymap("n", "<C-f>", builtin.live_grep, opts)
opts.desc = "Find Files"
keymap("n", "<C-p>", builtin.find_files, opts)
opts.desc = "LSP Document Symbol"
keymap("n", "<leader>ds", builtin.lsp_document_symbols, opts)

-- TODO: HARPOON
