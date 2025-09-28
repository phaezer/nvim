local o = vim.o
--- Removes the ••• part.
o.fillchars = 'fold: '
o.foldmethod = 'expr'
o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

--- Disables fold text.
o.foldtext = ''

o.expandtab = true
o.tabstop = 2
o.shiftwidth = 2
o.softtabstop = 2
