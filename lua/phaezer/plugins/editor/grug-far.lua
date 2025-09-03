-- Grug Far
-- NOTE: Find and replace across multiple files
return {
  'MagicDuck/grug-far.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  cmd = 'GrugFar',
  opts = {},
  keys = {
    {
      '<leader>/w',
      function() require('grug-far').open { prefills = { search = vim.fn.expand '<cword>' } } end,
      desc = 'find Current word  grug-far',
      mode = { 'n', 'x' },
    },
    {
      '<leader>/f',
      function() require('grug-far').open { prefills = { paths = vim.fn.expand '%' } } end,
      desc = 'find in file  grug-far',
      mode = { 'n', 'x' },
    },
    {
      '<leader>/i',
      function() require('grug-far').open { visualSelectionUsage = 'operate-within-range' } end,
      desc = 'find within range   grug-far',
      mode = { 'n', 'x' },
    },
    {
      '<leader>/r',
      function() require('grug-far').open { transient = true } end,
      desc = 'find and replace  grug-far',
      mode = { 'n', 'x' },
    },
  },
}
