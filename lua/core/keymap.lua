---@module 'Core.keymap'
local M = {}

local util = require 'core.util'

local _os_tbl = {
  mac = util.is_mac(),
  win = util.is_win(),
  linux = not util.is_mac() and not util.is_win(),
  any = true,
}

-- key modes:
-- n: normal mode
-- v: visual & select mode
-- s: select mode
-- o: operator pending mode
-- i: insert mode
-- x: visual mode
-- c: command mode
-- t: terminal mode
---@alias keymode 'n' | 'v' | 's' | 'o' | 'i' | 'x' | 'c' | 't'
---@alias key_table {[1]: string, [2]: string | function, ['mode']?: keymode, ['desc']?: string, [string]: any}

-- Map a key with
---@param keys key_table[]
function M.set(keys)
  local _os = { 'any' }

  for _, key in ipairs(keys) do
    -- default options
    local _opts = { noremap = true, silent = true }
    local _mode = 'n'

    for k, v in pairs(key) do
      -- if k is not a number, add it to the options
      if type(k) ~= 'number' then
        if k == 'mode' then
          _mode = v
        else
          _opts[k] = v
        end
      end
    end

    local _lhs = key[1]
    assert(_lhs, 'lhs is required')

    local _rhs = key[2]
    assert(_rhs, 'rhs is required')

    -- handle os
    if _opts and _opts.os then
      if type(_opts.os) == 'string' then
        _os = { _opts.os }
      else
        _os = _opts.os
      end
      _opts.os = nil -- remove os from options
    end
    -- map the keymap for the specified devices
    for _, o in ipairs(_os) do
      if _os_tbl[o] and _os_tbl[o] == true then
        vim.keymap.set(_mode, _lhs, _rhs, _opts)
        break
      end
    end
  end
end

return M
