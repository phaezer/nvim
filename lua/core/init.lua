local registry = require('core.plugins.registry')()
local plugin = require('core.plugins.plugin')

---@module 'Core'
return {
  util = require 'core.util',
  keymap = require 'core.keymap',
  plugin = {
    registry = registry, ---@type Registry
    add = function(spec)
      return registry:add(plugin(spec))
    end,
    update = function(opts) return registry:update(opts) end,
  },
}
