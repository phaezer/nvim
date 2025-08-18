---@alias os_name 'win' | 'linux' | 'mac' | 'bsd' | 'any'

local M = {
  DIR_SEP = require('package').config:sub(1, 1),
}

-- Execute a function if the OS is Windows
---@param f function The function to execute if the OS is Windows
---@return any the result of the function if vscode else nil
function M.if_vscode(f)
  if vim.g.vscode then
    return f()
  end
end

local os_map = {
  win = function()
    return vim.g.is_win
  end,
  linux = function()
    return vim.g.is_linux
  end,
  mac = function()
    return vim.g.is_mac
  end,
  bsd = function()
    return vim.g.is_bsd
  end,
  any = function()
    return true
  end,
}

--- Check if the OS is Windows
---@param os os_name | os_name[] the os(s) to check
---@return boolean true if the OS matches, false otherwise
function M.is_os(os)
  if type(os) == 'string' then
    return os_map[os]() or false
  end

  return vim.iter(os):any(function(v)
    return os_map[v]()
  end)
end

-- Execute a function if the OS matches
---@param os os_name | os_name[] the os(s) to check
---@param f function the function to execute if the OS matches
function M.if_os(os, f)
  if M.is_os(os) then
    return f()
  end
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

-- Normalize a file path
local function localize_path(path)
  if M.DIR_SEP == '\\' then
    path = path:gsub('/', '\\')
  end
  return path
end

-- read contents of a file
M.read_file = function(path)
  local localized_path = vim.fn.expand(localize_path(path))
  local file = io.open(localized_path, 'r')
  if not file then
    return nil
  end

  local content = file:read '*a'
  file:close()
  return content
end

return M
