--cSpell:words grug
-- NOTE: Find and replace across multiple files
return {
  'MagicDuck/grug-far.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  cmd = 'GrugFar',
  opts = {},
  keys = {
    {
      '<leader>rw',
      function() require('grug-far').open { prefills = { search = vim.fn.expand '<cword>' } } end,
      desc = 'find Current word  grug-far',
      mode = { 'n', 'x' },
    },
    {
      '<leader>rf',
      function() require('grug-far').open { prefills = { paths = vim.fn.expand '%' } } end,
      desc = 'find in file  grug-far',
      mode = { 'n', 'x' },
    },
    {
      '<leader>ri',
      function() require('grug-far').open { visualSelectionUsage = 'operate-within-range' } end,
      desc = 'find within range   grug-far',
      mode = { 'n', 'x' },
    },
    {
      '<leader>rg',
      function() require('grug-far').open { transient = true } end,
      desc = 'find and replace  grug-far',
      mode = { 'n', 'x' },
    },
  },
}
