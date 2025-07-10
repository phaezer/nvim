local util = require 'phaezer.lib.util'

local M = {}

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
---@alias key_table {[1]: string, [2]: string | function, ['mode']?: keymode, ['desc']?: string, ['vs_code']?: boolean, ['os']?: os_name | os_name[], [string]: any}

-- set keymap
---@param mode keymode
---@param lhs string
---@param rhs string | function
---@param opts table
local function set_keymap(mode, lhs, rhs, opts)
  -- handle os
  if opts then
    if opts.os then
      if not util.is_os(opts.os) then return end
      opts.os = nil
    end
    if opts.vs_code then
      if not vim.g.vs_code then return end
      opts.vs_code = nil
    end
  end

  vim.keymap.set(mode, lhs, rhs, opts)
end

local function parse_opts(opts, default_mode, default_opts)
  local _opts, _mode = default_opts or {}, default_mode or 'n'
  for k, v in pairs(opts) do
    -- if k is not a number, add it to the options
    if type(k) ~= 'number' then
      if k == 'mode' then
        _mode = v
      else
        _opts[k] = v
      end
    end
  end
  return _opts, _mode
end

-- Map a key with
---@param keys key_table | key_table[]
M.set = function(keys)
  if not util.is_list(keys) or type(keys[1]) ~= 'table' then keys = { keys } end

  for _, key in ipairs(keys) do
    -- parse options
    local _opts, _mode = parse_opts(key, 'n', { noremap = true, silent = true })

    local _lhs = key[1]
    assert(_lhs, 'lhs is required')

    local _rhs = key[2]
    assert(_rhs, 'rhs is required')

    set_keymap(_mode, _lhs, _rhs, _opts)
  end
end

-- Unset a keymap, if it fails, notify the user
---@param keys key_table | key_table[]
---@param log_lvl? string the log level to use for notifications (default: 'WARN')
---@return nil
M.unset = function(keys, log_lvl)
  if not util.is_list(keys) or type(keys[1]) ~= 'table' then keys = { keys } end
  for _, key in ipairs(keys) do
    local _, mode = parse_opts(key, 'n')
    local ok, err = pcall(function() vim.keymap.del(mode, key[1]) end)
    if not ok then
      vim.notify(string.format('Failed to unset keymap %s: %s', key[1], err), log_lvl or vim.log.levels.WARN, { title = 'Keymap Unset Error' })
    end
  end
end

return M
