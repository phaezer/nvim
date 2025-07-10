local util = require 'lua.phaezer.util'
-- mini - Collection of various small independent plugins/modules
-- see: https://github.com/echasnovski/mini.nvim

local M = {
  'echasnovski/mini.nvim',
  lazy = false,
  version = '*',
}

function M.config()
  -- load all mini plugins
  util.require_all('plugins/mini')
end

return M
