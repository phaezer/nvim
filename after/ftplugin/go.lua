vim.opt.expandtab = false -- use tabs with go
vim.opt.tabstop = 2 -- 2 spaces for tabs
vim.opt.shiftwidth = 2 -- 2 spaces for shift
vim.opt.softtabstop = 2 -- 2 spaces for softtabstop

vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"