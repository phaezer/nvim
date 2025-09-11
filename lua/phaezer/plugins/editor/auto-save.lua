return {
  -- cSpell:words pocco81
  'pocco81/auto-save.nvim',
  version = '*',
  lazy = true,
  event = { 'BufEnter', 'InsertLeave' },
  config = function()
    require('auto-save').setup {
      -- only save if no warn or worse diagnostics
      condition = function(buf)
        local ok, diagnostics =
          pcall(vim.diagnostic.get, buf, { severity = { min = vim.diagnostic.severity.WARN } })
        if ok and vim.fn.getbufvar(buf, '&modifiable') == 1 and #diagnostics < 1 then
          return true -- met condition(s), can save
        end
        return false -- can't save
      end,
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
