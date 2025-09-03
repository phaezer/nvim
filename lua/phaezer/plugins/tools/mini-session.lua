-- NOTE: Session management (read, write, delete)

return {
  'nvim-mini/mini.sessions',
  lazy = false,
  version = '*',
  opts = {
    directory = 'sessions',
  },
  init = function()
    -- TODO: add additional keys
    local map = require('phaezer.core.keys').map
    map {
      {
        '<leader>fsr',
        function() require('mini.sessions').select 'read' end,
        desc = 'sessions',
      },
    }
  end,
}
