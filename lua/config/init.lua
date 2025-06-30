require 'config.vim_plug'
require 'config.autocmd'
require 'config.opt'

---@module 'config'
local M = {
  icon = require 'config.icon',
  ai = require 'config.ai',
  lazy = require 'config.lazy',
}

return M
