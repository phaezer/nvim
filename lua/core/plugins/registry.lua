---@class Registry
---@field registry table<string, Plugin>
local Registry = {}

function Registry.new()
  local instance = setmetatable({}, { __index = Registry })
  instance.registry = {}
  return instance
end

-- add a plugin to the registry
---@param plugin Plugin | Plugin[]
---@return nil
---@throws if plugin name is not provided or if a plugin with the same name already exists
function Registry:add(plugin)
  -- if plugin is a table of plugins, recursively add each one
  if not plugin.type or plugin.type ~= "Plugin" then
    for _, p in ipairs(plugin) do
      self:add(p) -- recursively add if it's a table of plugins
    end
    return
  end

  assert(plugin.type == "Plugin", "Expected a Plugin instance")
  assert(not self.registry[plugin.name], "Plugin with name" .. plugin.name .. " already exists")
  self.registry[plugin.name] = plugin
end

-- get a registered plugin by name
---@param name any
---@return Plugin?
function Registry:get(name)
  return self.registry[name]
end

-- apply a configuration to a registered plugin
---@param opts table
---@throws if the plugin is not registered
---@return nil
function Registry:config(opts)
  local name = opts[1]
  assert(name and type(name) == "string", "Expected a plugin name")
  local plugin = self:get(name)

  assert(plugin, "Plugin '" .. name .. "' is not registered.")
  if not plugin then
    vim.schedule(function()
      vim.notify("Plugin '" .. name .. "' is not registered.", vim.log.levels.DEBUG)
    end)
    return
  end
  plugin:set(opts)
end

-- get all registered plugins
---@param filter fun(plugin: table): boolean?
function Registry:get_plugins(filter)
  local plugins = {}
  for _, plugin in pairs(self.registry) do
    if not filter or filter(plugin.config) then
      table.insert(plugins, plugin.config)
    end
  end
  return plugins
end

---@return Registry
return setmetatable(Registry, {
  __call = function(_)
    return Registry.new()
  end,
})
