-- Flash
-- NOTE: lets you navigate your code with search labels, enhanced character motions, and Treesitter integration.
return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  keys = {
    {
      'gs',
      mode = { 'n', 'x', 'o' },
      function() require('flash').jump() end,
      desc = 'flash jump',
    },
    {
      'gt',
      mode = { 'n', 'x', 'o' },
      function() require('flash').treesitter() end,
      desc = 'flash TS',
    },
  },
  opts = {
    label = {
      rainbow = {
        enabled = true,
        shade = 7,
      },
    },
    modes = {
      -- do not use with f F t T ; keys
      char = { enabled = false },
    },
  },
}
