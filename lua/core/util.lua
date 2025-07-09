local lua_dir = vim.fn.stdpath 'config' .. '/lua/'

---@module 'core.util'
local M = {}

-- TODO: set global variables for the OS instead
-- Check if the OS is Windows
---@return boolean true if the OS is Windows
function M.is_win()
  return vim.uv.os_uname().sysname:find 'Windows' ~= nil
end

-- Check if the OS is Mac
---@return boolean true if the OS is Mac
function M.is_mac()
  return vim.uv.os_uname().sysname:find 'Darwin' ~= nil
end

function M.is_vs_code()
  return vim.g.vscode ~= nil
end

-- require all Lua files in a directory
---@param dir string Directory path relative to the Neovim config directory
---@return nil
---@throws if the directory does not exist
function M.require_all(dir)
  -- split dir by path separator

  local output = {}
  local base_dir = lua_dir .. dir
  local fd = vim.loop.fs_scandir(base_dir)

  for file_name in
    function()
      return vim.loop.fs_scandir_next(fd)
    end
  do
    local path = base_dir .. '/' .. file_name
    if file_name:sub(-4) == '.lua' then
      local path_no_ext = path:sub(#lua_dir + 1):sub(0, -5) -- remove the .lua extension
      local dir_parts = {}
      for part in string.gmatch(path_no_ext, '[^/]+') do
        table.insert(dir_parts, part)
      end

      local out = require(table.concat(dir_parts, '.'))
      if out then
        table.insert(output, out)
      end
    end
  end

  return output
end

-- Remove duplicates from a list
---@param list_table table<number, any>
---@return table<number, any>
function M.unique(list_table)
  local seen = {}
  local result = {}
  for _, value in ipairs(list_table) do
    if not seen[value] then
      seen[value] = true
      table.insert(result, value)
    end
  end
  return result
end

--- Check if a table is list, i.e. if the keys are numbers starting from 1
---@param tbl table The table to check
---@return boolean true if the table is like a list, false otherwise
function M.is_list(tbl)
  assert(tbl ~= nil, 'Table cannot be nil')
  assert(type(tbl) == 'table', 'Expected a table, got ' .. type(tbl))

  if #tbl == 0 then
    return false -- empty table is not considered a list
  end

  for i = 1, #tbl do
    if tbl[i] == nil then
      return false -- if any index is nil, it's not a list
    end
  end

  return true
end

---@param tbl table The table to check
---@return boolean true if the table is like a dictionary, false otherwise
function M.dict_like(tbl)
  assert(tbl ~= nil, 'Table cannot be nil')
  assert(type(tbl) == 'table', 'Expected a table, got ' .. type(tbl))

  for k, _ in pairs(tbl) do
    if type(k) ~= 'number' then
      return true -- if any key is not a number, it's dictionary-like
    end
  end

  return false
end

return M
