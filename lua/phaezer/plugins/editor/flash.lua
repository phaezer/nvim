-- Flash
-- NOTE: lets you navigate your code with search labels, enhanced character motions, and Treesitter integration.
return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  keys = {
    {
      '<leader>s',
      mode = { 'n', 'x', 'o' },
      function() require('flash').jump() end,
      desc = 'Flash',
    },
    {
      '<leader>S',
      mode = { 'n', 'x', 'o' },
      function() require('flash').treesitter() end,
      desc = 'Flash Treesitter',
    },
    {
      '<c-l>',
      mode = { 'c' },
      function() require('flash').toggle() end,
      desc = 'Toggle Flash Search',
    },
  },
  opts = {},
}
