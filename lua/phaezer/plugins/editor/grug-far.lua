-- Grug Far
-- NOTE: Find and replace across multiple files
return {
  'MagicDuck/grug-far.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  cmd = 'GrugFar',
  opts = {},
  keys = {
    {
      '<leader>fw',
      function() require('grug-far').open { prefills = { search = vim.fn.expand '<cword>' } } end,
      desc = 'GrugFar | Find Current Word',
      mode = { 'n', 'x' },
    },
    {
      '<leader>ff',
      function() require('grug-far').open { prefills = { paths = vim.fn.expand '%' } } end,
      desc = 'GrugFar | Find In File',
      mode = { 'n', 'x' },
    },
    {
      '<leader>fi',
      function() require('grug-far').open { visualSelectionUsage = 'operate-within-range' } end,
      desc = 'GrugFar | Find within range',
      mode = { 'n', 'x' },
    },
    {
      '<leader>fr',
      function() require('grug-far').open { transient = true } end,
      desc = 'GrugFar | Find And Replace',
      mode = { 'n', 'x' },
    },
  },
}
