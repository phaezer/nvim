local registry = require('core.plugins.registry')()

---@module 'Core'
return {
  util = require 'core.util',
  keymap = require 'core.keymap',
  plugin = registry, ---@type Registry
}
