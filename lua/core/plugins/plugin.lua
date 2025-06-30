---@class Plugin
---@field name string
---@field config table
local Plugin = {
  type = "Plugin"
}

-- Table to hold registered plugins
local plugin_mt = {
  __index = Plugin,
  __tostring = function(self)
    return "Plugin: " .. self.name
  end,
}

-- Creates a new plugin and registers it
---@param plugin table
---@return Plugin
function Plugin.new(plugin)
  local name = plugin[1]
  assert(name and type(name) == "string", "Plugin name is required and must be a string")
  local instance = setmetatable({
    name = name,
    config = plugin or {},
  }, plugin_mt)

  return instance
end

-- Sets options for the plugin
---@param ... table
function Plugin:set(...)
  vim.tbl_deep_extend("force", self.config, ...)
end

---@return Plugin
return setmetatable({}, {
  __call = function(_, ...)
    return Plugin.new(...)
  end,
})
