-- NOTE:
return {
  'Wansmer/treesj',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  keys = {
    { 'gjj', '<cmd>TSJToggle<cr>', desc = 'Split/Join' },
    { 'gjk', '<cmd>TSJJoin<cr>', desc = 'Split/Join' },
    { 'gjl', '<cmd>TSJSplit<cr>', desc = 'Split/Join' },
  },
  opts = {
    use_default_keymaps = false,
    max_join_length = 1000,
  },
}
