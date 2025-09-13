local fts = {
  'go',
  'lua',
  'python',
  'javascript',
  'typescript',
  'js',
  'ts',
  'react',
  'rust',
}

return {
  -- cSpell:words pocco81
  'pocco81/auto-save.nvim',
  version = '*',
  lazy = true,
  event = { 'BufEnter', 'InsertLeave' },
  config = function()
    require('auto-save').setup {
      enabled = false, -- disable by default.
      trigger_events = { 'InsertLeave' },
      -- only save if no warn or worse diagnostics
      condition = function(buf)
        local utils = require 'auto-save.utils.data'
        -- only allow specific filetypes
        if utils.not_in(vim.fn.getbufvar(buf, '&filetype'), fts) then return false end
        local ok, diagnostics =
          pcall(vim.diagnostic.get, buf, { severity = { min = vim.diagnostic.severity.WARN } })
        if ok and vim.fn.getbufvar(buf, '&modifiable') == 1 and #diagnostics < 1 then
          return true -- met condition(s), can save
        end
        return false -- can't save
      end,
      callbacks = { -- functions to be executed at different intervals
        enabling = nil, -- ran when enabling auto-save
        disabling = nil, -- ran when disabling auto-save
        before_asserting_save = nil, -- ran before checking `condition`
        before_saving = function()
          ---@diagnostic disable-next-line: inject-field
          vim.b.autosaving = true
        end,
        after_saving = function()
          ---@diagnostic disable-next-line: inject-field
          vim.b.autosaving = false
        end,
      },
    }
  end,

  init = function()
    require('phaezer.core.keys').map {
      mode = 'n',
      plugin = 'auto-save',
      prefix = '<leader>k',
      { 'S', '<cmd>ASToggle<cr>', desc = 'Toggle Auto Save' },
    }
  end,
}
