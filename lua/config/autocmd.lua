-- see: https://neovim.io/doc/user/autocmd.html

local api = vim.api

api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  callback = function()
    vim.hl.on_yank()
  end,
})

api.nvim_create_autocmd("BufEnter", {
  desc = "Disable New Line Comment",
  callback = function()
    vim.opt.formatoptions:remove({ "c", "r", "o" })
  end,
})

api.nvim_create_autocmd("BufReadPost", {
  desc = "go to last loc when opening a buffer",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})
