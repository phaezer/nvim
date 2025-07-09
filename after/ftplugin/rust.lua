local bufnr = vim.api.nvim_get_current_buf()
local keymap = require 'core.keymap'

keymap.set {
  {
    "<leader>a",
    function()
      vim.cmd.RustLsp('codeAction') -- supports rust-analyzer's grouping
    end,
    buffer = bufnr
  },
  {
    "K", -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
    function()
      vim.cmd.RustLsp({ 'hover', 'actions' })
    end,
    buffer = bufnr
  }
}

vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2

vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"