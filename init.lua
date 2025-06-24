vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

Config = require("config")
_G.Config = Config

-- load vim plugins
require('vim_plug')

-- load keymaps
require('keymaps')

-- load lazy
require('lazy_init')
