local util = require 'phaezer.core.util'

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

---key tables
---@alias KeyTable {[1]: string, [2]: string | function, ['mode']?: keymode, ['desc']?: string, ['vs_code']?: boolean, ['os']?: os_name | os_name[], [string]: any}

---set keymap
---@param mode keymode
---@param lhs string
---@param rhs string | function
---@param opts table
local function set_keymap(mode, lhs, rhs, opts)
  -- handle os
  if opts then
    if opts.os then
      if not util.is_os(opts.os) then
        return
      end
      opts.os = nil
    end
    if opts.vs_code then
      if not vim.g.vs_code then
        return
      end
      opts.vs_code = nil
    end
  end

  if opts.plugin ~= nil then
    -- append the plugin name to the description
    opts.desc = (opts.desc or '') .. '  ' .. opts.plugin
    opts.plugin = nil
  end

  vim.keymap.set(mode, lhs, rhs, opts or { noremap = true, silent = true })
end

---Map a key
---@param val {keys: KeyTable[], opts: table? } | {[number]: KeyTable, opts: table?} | KeyTable[]
M.map = function(val)
  local key_tbls, common_opts = util.tbl_extract(val, function(k, _)
    return type(k) == 'number' or k == 'keys'
  end)
  -- filter out prefix and mode
  local extra, common_opts = util.tbl_extract(common_opts, { 'prefix', 'mode' })
  for _, key_tbl in ipairs(key_tbls) do
    local key_opts = util.tbl_extract(key_tbl, function(k, _)
      return type(k) ~= 'number' and k ~= 'mode'
    end)
    local opts = vim.tbl_deep_extend('force', common_opts or {}, key_opts or {})
    local lhs = (extra.prefix or '') .. key_tbl[1] -- add prefix if exists
    assert(lhs, 'lhs is required')
    local rhs = key_tbl[2]
    assert(rhs, 'rhs is required')
    set_keymap(key_tbl.mode or extra.mode or 'n', lhs, rhs, opts)
  end
end

---Unset a keymap, if it fails, notify the user
---@param keys KeyTable[]
---@return nil
M.unmap = function(keys)
  for _, key in ipairs(keys) do
    local mode = key.mode or 'n'

    local opts = util.tbl_extract(key, function(k, _)
      return type(k) ~= 'number' and k ~= 'mode'
    end)

    local ok, err = pcall(function()
      vim.keymap.del(mode, key[1], opts)
    end)

    if not ok then
      vim.notify(
        string.format('Failed to unset keymap %s: %s', key[1], err),
        vim.log.levels.WARN,
        { title = 'Keymap Unset Error' }
      )
    end
  end
end

return M
