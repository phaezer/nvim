local util = require 'core.util'

---@module 'Core.keymap'
local M = {}

-- OS types:
-- mac: macOS
-- win: Windows
-- linux: Linux
-- bsd: BSD (FreeBSD, OpenBSD, etc.)
-- any: any OS
---@alias os 'mac' | 'win' | 'linux' | 'bsd' | 'any'

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

-- key tables
---@alias key_table {[1]: string, [2]: string | function, ['mode']?: keymode, ['desc']?: string, ['vs_code']?: boolean, ['os']?: os | os[], [string]: any}

local _os_tbl = {
  mac = function()
    return vim.g.is_mac == true
  end,
  win = function()
    return vim.g.is_win == true
  end,
  linux = function()
    return vim.g.is_linux == true
  end,
  bsd = function()
    return vim.g.is_bsd == true
  end,
  any = function()
    return true
  end,
}

local function is_os(os)
  if type(os) == 'string' then
    return _os_tbl[os]() or false
  end

  assert(type(os) == 'table', 'os must be a string or a table')
  return vim.iter(os):any(function(v)
    return _os_tbl[v]()
  end)
end

-- set keymap
---@param mode keymode
---@param lhs string
---@param rhs string | function
---@param opts table
local function set_keymap(mode, lhs, rhs, opts)
  -- handle os
  if opts then
    if opts.os then
      if not is_os(opts.os) then
        return
      end
      opts.os = nil
    end
    if opts.vs_code then
      if not is_os(opts.vs_code) then
        return
      end
      opts.vs_code = nil
    end
  end

  vim.keymap.set(mode, lhs, rhs, opts)
end

-- Map a key with
---@param keys key_table | key_table[]
local function set(keys)
  if not util.is_list(keys) or type(keys[1]) ~= 'table' then
    keys = { keys }
  end

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

    set_keymap(_mode, _lhs, _rhs, _opts)
  end
end

-- Set a key map
---@param keys key_table | key_table[]
function M.set(keys)
  set(keys)
end

-- Set a keymap that is lazy loaded
-- This will create an autocommand that will load the keymap when the event is triggered
---@param keys key_table | key_table[]
---@param trigger string | string[]  the event to trigger the keymap, defaults to 'User'
function M.set_lazy(keys, trigger)
  -- lazy load the keymap
  vim.api.nvim_create_autocmd(trigger or 'User', {
    pattern = 'VeryLazy',
    callback = function()
      set(keys)
    end,
  })
end

return M
