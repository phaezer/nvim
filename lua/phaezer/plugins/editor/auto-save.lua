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
    local auto_save = require 'auto-save'
    auto_save.setup {
      enabled = false, -- disable by default (note: this doesn't seem to work?)
      trigger_events = { 'InsertLeave' },
      -- only save if no warn or worse diagnostics
      condition = function(buf)
        local utils = require 'auto-save.utils.data'
        -- only allow specific filetypes
        if utils.not_in(vim.fn.getbufvar(buf, '&filetype'), fts) then return false end
        -- do not auto save if we have a diagnostic warning or worse
        local ok, diagnostics =
          pcall(vim.diagnostic.get, buf, { severity = { min = vim.diagnostic.severity.WARN } })
        if ok and vim.fn.getbufvar(buf, '&modifiable') == 1 and #diagnostics < 1 then
          return true -- met condition(s), can save
        end
        return false -- can't save
      end,
    }

    -- because setting enabled = false doesn't work, disable it here
    auto_save.off()
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
