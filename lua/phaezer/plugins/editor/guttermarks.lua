-- cSpell:words dimtion guttermarks getmarklist
-- NOTE: adds visible marks to the gutter
return {
  'dimtion/guttermarks.nvim',
  event = 'VeryLazy',
  init = function()
    local map = require('phaezer.core.keys').map
    map {
      mode = 'n',
      plugin = 'guttermarks',
      {
        'dm',
        function()
          local buf = vim.api.nvim_get_current_buf()
          local line = vim.api.nvim_win_get_cursor(0)[1]
          for _, m in ipairs(vim.fn.getmarklist(buf)) do
            if m.pos[2] == line and m.mark:match "^'[a-z]" then
              vim.api.nvim_buf_del_mark(buf, m.mark:sub(2))
            end
          end
          for _, m in ipairs(vim.fn.getmarklist()) do
            if m.pos[1] == buf and m.pos[2] == line and m.mark:match "^'[A-Z]" then
              vim.api.nvim_del_mark(m.mark:sub(2))
            end
          end
          require('guttermarks').refresh()
        end,
        desc = 'delete marks on this line',
      },
    }
  end,
}
