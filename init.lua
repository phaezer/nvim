vim.uv = vim.uv or vim.loop
vim.g.termguicolors = true

-- load Core
Core = require 'core'
_G.Core = Core

-- load config
Config = require 'config'
_G.Config = Config

local Plugin = require 'core.plugins.plugin'
local plugins = {}

-- dirs where plugins are stored
local plugin_dirs = {
  'plugins',
  'plugins/themes',
  'plugins/ai',
  'plugins/editor',
  'plugins/lsp',
  'plugins/images',
  'plugins/integrations',
  'plugins/markdown',
  'plugins/ui',
}

for _, dir in ipairs(plugin_dirs) do
  vim.list_extend(plugins, Core.util.require_all(dir))
end

-- load all plugins, recursively
for _, p in ipairs(plugins) do
  Core.plugin:add(Plugin(p))
end

-- set up the keymaps
require 'config.keymap'

-- only include plugins that are compatible with VS Code if running in VS Codes
local plugin_filter = function(plugin)
  return not Core.util.is_vs_code() or plugin.vs_code == true
end

require('lazy').setup(vim.tbl_extend(
  'force',
  Config.lazy,
  {
    spec = Core.plugin:get_plugins(plugin_filter)
  }
))
