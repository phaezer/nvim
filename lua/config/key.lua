---@module 'Config.ke'
local M = {}

local _os_tbl = {
  mac = Util.is_mac(),
  win = Util.is_win(),
  linux = not Util.is_mac() and not Util.is_win(),
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

-- Remap for dealing with visual line wraps
M.set {
  { 'k', 'v:count == 0 ? "gk" : "k"', desc = 'Move up',   expr = true },
  { 'j', 'v:count == 0 ? "gj" : "j"', desc = 'Move down', expr = true },
}

-- Keep selection while indenting
M.set {
  { '<', '<gv', desc = 'Indent left',  mode = 'v' },
  { '>', '>gv', desc = 'Indent right', mode = 'v' },
}

-- escape remaps
M.set {
  { 'jk', '<esc>', desc = 'Exit insert mode', mode = 'i' },
}

-- Clear highlights on search when pressing <Esc> in normal mode
M.set {
  { '<esc>', '<cmd>nohlsearch<CR>', desc = 'Clear highlights on search' },
}

-- diagnostics
M.set {
  { '<leader>q', vim.diagnostic.setloclist, desc = 'Open diagnostic [Q]uickfix list' },
}

-- terminal
M.set {
  { '<C-q>',      '<C-\\><C-n>', desc = 'Exit terminal mode', mode = 't' },
  { '<esc><esc>', '<C-\\><C-n>', desc = 'Exit terminal mode', mode = 't' },
}

-- window
M.set {
  { '<leader>ws', '<cmd>split<cr>',              desc = 'Horizontal split', },
  { '<leader>wv', '<cmd>vsplit<cr>',             desc = 'Vertical split', },
  { '<leader>wc', '<cmd>close<cr>',              desc = 'Close', },
  { '<leader>wT', '<cmd>wincmd T<cr>',           desc = 'Move window to new tab', },
  { '<leader>wr', '<cmd>wincmd r<cr>',           desc = 'rotate down/right', },
  { '<leader>wR', '<cmd>wincmd R<cr>',           desc = 'rotate up/left', },
  { '<leader>wH', '<cmd>wincmd H<cr>',           desc = 'Move left', },
  { '<leader>wJ', '<cmd>wincmd J<cr>',           desc = 'Move down', },
  { '<leader>wK', '<cmd>wincmd K<cr>',           desc = 'Move up', },
  { '<leader>wL', '<cmd>wincmd L<cr>',           desc = 'Move right', },
  { '<leader>wh', '<cmd>vertical resize +3<cr>', desc = 'Left', },
  { '<leader>wl', '<cmd>vertical resize -3<cr>', desc = 'Right', },
  { '<leader>w=', '<cmd>wincmd =<cr>',           desc = 'Equalize size', },
  { '<leader>wk', '<cmd>resize +5<cr>',          desc = 'Up', },
  { '<leader>wj', '<cmd>resize -5<cr>',          desc = 'Down', },
}

-- buffers
M.set {
  { '<leader>bl', '<cmd>bnext<cr>',      desc = 'Next buffer' },
  { '<leader>bh', '<cmd>bprevious<cr>',  desc = 'Previous buffer' },
  { '<leader>bD', '<cmd>%bd|e#|bd#<cr>', desc = 'Close all but the current buffer' },
}

-- files
M.set {
  { '<leader>fN', '<cmd>enew<cr>',   desc = 'New file' },
  { '<leader>fs', '<cmd>w<cr><esc>', desc = 'Save file' },
}

-- folding
M.set {
  { '<C- >', 'zf', desc = 'Fold selection', mode = 'v' },
  { '<C- >', 'za', desc = 'Toggle fold',    mode = { 'n', 'i', 'o' } },
}



M.set {
  {
    '<leader>uc',
    desc = 'Toggle colorcolumn',
    function()
      local value = vim.inspect(vim.opt.colorcolumn:get())

      if value == '{}' then
        local value = vim.api.nvim_get_option_value('colorcolumn', {})
        if value == '' then
          vim.notify('Enable colorcolumn', 'info', 'functions.lua')
          vim.opt.colorcolumn = '80'
          vim.api.nvim_set_option_value('colorcolumn', '80', {})
        else
          vim.notify('Disable colorcolumn', 'info', 'functions.lua')
          vim.opt.colorcolumn = {}
          vim.api.nvim_set_option_value('colorcolumn', '', {})
        end
      end
    end,
  },
  {
    '<leader>ua',
    desc = 'Toggle animations',
    function()
      if vim.g.animations then
        vim.g.animations = false
      else
        vim.g.animations = true
      end
    end,
  },
}

return M
