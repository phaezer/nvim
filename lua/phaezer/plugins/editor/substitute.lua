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
      desc = 'replace  substitute',
    },
    {
      '<leader>rs',
      mode = 'n',
      function() require('substitute').line() end,
      desc = 'replace line  substitute',
    },
    {
      '<leader>rR',
      mode = 'n',
      function() require('substitute').eol() end,
      desc = 'replace end of line  substitute',
    },
    {
      '<leader>r',
      mode = 'v',
      function() require('substitute').visual() end,
      desc = 'replace visual selection  substitute',
    },
  },
}
