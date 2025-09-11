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
    require('phaezer.core.keys').map {
      plugin = 'tiny-code-action',
      { '<leader>kk', open, desc = 'Code Action' },
    }
  end,
}
