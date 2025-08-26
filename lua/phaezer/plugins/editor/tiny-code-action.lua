-- Tiny Code Action
-- NOTE: provides a simple way to run and visualize code actions.
return {
  'rachartier/tiny-code-action.nvim',
  lazy = true,
  event = 'LspAttach',
  dependencies = {
    'folke/snacks.nvim',
  },
  opts = {},
  keys = {
    { '<leader>la', function() require('tiny-code-action').code_action() end, desc = 'Code Action' },
  },
}
