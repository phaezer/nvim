-- Substitute
-- NOTE: A Neovim plugin for performing substitutions with a visual selection or a range
return {
  'gbprod/substitute.nvim',
  lazy = true,
  opts = {
    on_substitute = function() require('yanky.integration').substitute() end,
  },
  keys = {
    {
      '<leader>r',
      mode = 'n',
      function() require('substitute').operator() end,
      desc = 'Replace | Substitute',
    },
    {
      '<leader>rs',
      mode = 'n',
      function() require('substitute').line() end,
      desc = 'Replace line | Substitute',
    },
    {
      '<leader>rR',
      mode = 'n',
      function() require('substitute').eol() end,
      desc = 'Replace end of line | Substitute',
    },
    {
      '<leader>r',
      mode = 'v',
      function() require('substitute').visual() end,
      desc = 'Replace visual selection | Substitute',
    },
  },
}
