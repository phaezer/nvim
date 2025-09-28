-- Tiny Code Action
-- NOTE: provides a simple way to run and visualize code actions.
return {
  'rachartier/tiny-code-action.nvim',
  lazy = true,
  event = 'LspAttach',
  dependencies = {
    'folke/snacks.nvim',
  },
  opts = {
    picker = 'snacks',
    signs = {
      quickfix = { '󱐌', { link = 'DiagnosticWarning' } },
      others = { '', { link = 'DiagnosticWarning' } },
      refactor = { '', { link = 'DiagnosticInfo' } },
      ['refactor.move'] = { '󰪹', { link = 'DiagnosticInfo' } },
      ['refactor.extract'] = { '', { link = 'DiagnosticError' } },
      ['source.organizeImports'] = { '', { link = 'DiagnosticWarning' } },
      ['source.fixAll'] = { '󰃢', { link = 'DiagnosticError' } },
      ['source'] = { '', { link = 'DiagnosticError' } },
      ['rename'] = { '', { link = 'DiagnosticWarning' } },
      ['codeAction'] = { '', { link = 'DiagnosticWarning' } },
    },
  },
  init = function()
    local open = function() require('tiny-code-action').code_action() end
    local map = require('phaezer.core.keys').map
    map {
      plugin = 'tiny-code-action',
      prefix = '<leader>',
      { 'a', open, desc = 'Code Action' },
      { '.', open, desc = 'Code Action' },
    }
  end,
}
