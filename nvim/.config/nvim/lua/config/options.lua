-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Enable word wrap by default
local opt = vim.opt
opt.wrap = true

-- Implement transparent bg to autocomplete(popup) and windows(floats)
vim.o.pumblend = 0
vim.o.winblend = 0
