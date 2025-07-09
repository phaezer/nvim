-- Adds git related signs to the gutter, as well as utilities for managing changes
-- NOTE: gitsigns is already included in init.lua but contains only the base
-- config. This will add also the recommended keymaps.

return {
  'lewis6991/gitsigns.nvim',
  lazy = false,
  opts = {
    on_attach = function(bufnr)
      local gitsigns = require 'gitsigns'

      require('core.keymap').set {
        {
          ']c',
          function()
            if vim.wo.diff then
              vim.cmd.normal { ']c', bang = true }
            else
              gitsigns.nav_hunk 'next'
            end
          end,
          desc = 'Jump to next git change'
        },
        {
          '[c',
          function()
            if vim.wo.diff then
              vim.cmd.normal { '[c', bang = true }
            else
              gitsigns.nav_hunk 'prev'
            end
          end,
          desc = 'Jump to previous git change'
        },
        {
          '<leader>hs',
          function()
            gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
          end,
          desc = 'git stage hunk'
        },
        {
          '<leader>hr',
          function()
            gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
          end,
          desc = 'git reset hunk'
        },
        { '<leader>hS', gitsigns.stage_buffer, desc = 'git stage buffer' },
        { '<leader>hu', gitsigns.stage_hunk,   desc = 'git undo stage hunk' },
        { '<leader>hR', gitsigns.reset_buffer, desc = 'git reset buffer' },
        { '<leader>hp', gitsigns.preview_hunk, desc = 'git preview hunk' },
        { '<leader>hb', gitsigns.blame_line,   desc = 'git blame line' },
        { '<leader>hd', gitsigns.diffthis,     desc = 'git diff against index' },
        { '<leader>hD', function()
          gitsigns.diffthis '@'
        end, desc = 'git diff against last commit' },
        { '<leader>tb', gitsigns.toggle_current_line_blame, desc = 'toggle git show blame line' },
        { '<leader>tD', gitsigns.preview_hunk_inline,       desc = 'toggle git show deleted' },
      }
    end,
  },
}
