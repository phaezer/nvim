require 'config.vim_plug'
require 'config.autocmd'
require 'config.opt'

Core.keymap.set(require 'config.keys')

---@module 'config'
return {
  icon = require 'config.icon',
  ai = require 'config.ai',
  lazy = require 'config.lazy',
}
