-- lua/plugins/better_escape.lua
return {
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup({
        mapping = { "jk", "jj" },
        timeout = vim.o.timeoutlen,
        clear_empty_lines = false,
        keys = "<Esc>",
        -- keys = function()
        --   return vim.api.nvim_win_get_cursor(0)[2] > 1 and '<esc>l' or '<esc>'
        -- end,
      })
    end,
  },
}
