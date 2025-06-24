vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- load vim plugins
require('vim_plug')

-- load config
require('config')

-- load keymaps
require('keymaps')

-- load lazy
require('lazy_init')
