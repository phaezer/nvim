-- NOTE: provides offline gitignore rule generation
return {
  'wintermute-cell/gitignore.nvim',
  dependencies = {
    'nvim-telescope/telescope.nvim', -- optional: for multi-select
  },
  config = function()
    require 'gitignore'
    local map = require('phaezer.core.keys').map
    map {
      prefix = '<leader>g',
      plugin = 'gitignore',
      {
        'I',
        function() require('gitignore').generate() end,
        desc = 'generate ignore',
      },
    }
  end,
}
