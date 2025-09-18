local map = require('phaezer.core.keys').map

-- SRC: https://www.reddit.com/r/neovim/comments/1hm3cv2/comment/m3rdfqg/
-- cSpell:disable
-- Diff current file with saved version
vim.api.nvim_create_user_command('DiffWithSaved', function()
  -- Get start buffer
  local start = vim.api.nvim_get_current_buf()
  local filetype = vim.api.nvim_get_option_value('filetype', { buf = start })
  -- `vnew` - Create empty vertical split window
  -- `set buftype=nofile` - Buffer is not related to a file, will not be written
  -- `read ++edit #` - Read the current file into the new buffer
  -- `0d_` - Remove an extra empty start row
  -- `diffthis` - Set diff mode to a new vertical split
  vim.cmd 'vnew | set buftype=nofile | read ++edit # | 0d_ | diffthis'
  -- Get scratch buffer
  local scratch = vim.api.nvim_get_current_buf()
  -- Set filetype of scratch buffer to be the same as start
  vim.api.nvim_set_option_value('filetype', filetype, { buf = scratch })
  -- `wincmd p` - Go to the start window
  -- `diffthis` - Set diff mode to a start window
  vim.cmd 'wincmd p | diffthis'
  -- Map `q` for both buffers to exit diff view and delete scratch buffer
  for _, buf in ipairs { scratch, start } do
    map {
      {
        '<leader>ga',
        function()
          vim.cmd 'windo diffoff'
          vim.api.nvim_buf_delete(scratch, { force = true })
          vim.keymap.del('n', 'q', { buffer = start })
        end,
        buffer = buf,
        desc = 'diff buffer with saved',
      },
    }
  end
end, {})
