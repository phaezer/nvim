vim.uv = vim.uv or vim.loop

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- load Core
Core = require 'core'
_G.Core = Core

-- load config
Config = require 'config'
_G.Config = Config

require('lazy').setup('plugins', Config.lazy)
