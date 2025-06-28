--- @alias os 'mac' | 'win' | 'linux' | 'all'

---@module 'Util'
local M = {}

-- Check if the OS is Windows
---@return boolean true if the OS is Windows
function M.is_win()
  return vim.uv.os_uname().sysname:find("Windows") ~= nil
end

-- Check if the OS is Mac
---@return boolean true if the OS is Mac
function M.is_mac()
  return vim.uv.os_uname().sysname:find("Darwin") ~= nil
end

-- Get the keys of a table
---@param t table
---@return string[]
function M.table_keys(t)
  local keys = {}
  for k, _ in pairs(t) do
    table.insert(keys, k)
  end
  return keys
end

-- Pad a string with a character
---@param val string
---@param left_pad? number
---@param right_pad? number
---@param pad_char? string
---@return string
function M.pad(val, left_pad, right_pad, pad_char)
  local _pad_char = pad_char or " "
  local pad_str = string.rep(_pad_char, left_pad or 0) .. val .. string.rep(_pad_char, right_pad or 0)
  return pad_str
end

M.lualine = require "util.lualine"

return M
