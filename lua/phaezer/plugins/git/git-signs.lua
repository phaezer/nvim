-- Git signs
-- NOTE: adds git related signs to the gutter, as well as utilities for managing changes

local icons = require 'phaezer.core.icons'

return {
  'lewis6991/gitsigns.nvim',
  lazy = true,
  branch = 'main',
  -- version = 'v1.0.2',
  dependencies = {
    'tpope/vim-fugitive',
    'nvim-lua/plenary.nvim',
  },
  event = { 'BufReadPre' },
  opts = {
    signcolumn = true,
    current_line_blame = true,
    signs = {
      add = { text = '┃' },
      change = { text = '┃' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = icons.git.Modified },
      untracked = { text = '┆' },
    },
    signs_staged = {
      add = { text = '┃' },
      change = { text = '┃' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = icons.git.Modified },
      untracked = { text = '┆' },
    },
    preview_config = {
      -- Options passed to nvim_open_win
      border = 'single',
      style = 'minimal',
      relative = 'cursor',
      row = 0,
      col = 1,
    },
    on_attach = function(bufnr)
      local gs = require 'gitsigns'

      require('phaezer.core.keys').map {
        {
          ']c',
          function()
            if vim.wo.diff then
              vim.cmd.normal { ']c', bang = true }
            else
              gs.nav_hunk 'next'
            end
          end,
          desc = 'Jump to next git change',
        },
        {
          '[c',
          function()
            if vim.wo.diff then
              vim.cmd.normal { '[c', bang = true }
            else
              gs.nav_hunk 'prev'
            end
          end,
          desc = 'Jump to previous git change',
        },
        {
          '<leader>hs',
          function() gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' } end,
          desc = 'git stage hunk',
        },
        {
          '<leader>hr',
          function() gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' } end,
          desc = 'git reset hunk',
        },
        { '<leader>hS', gs.stage_buffer, desc = 'git stage buffer' },
        { '<leader>hu', gs.stage_hunk, desc = 'git undo stage hunk' },
        { '<leader>hR', gs.reset_buffer, desc = 'git reset buffer' },
        { '<leader>hp', gs.preview_hunk, desc = 'git preview hunk' },
        { '<leader>hb', gs.blame_line, desc = 'git blame line' },
        { '<leader>hd', gs.diffthis, desc = 'git diff against index' },
        {
          '<leader>hD',
          function() gs.diffthis '@' end,
          desc = 'git diff against last commit',
        },
        { '<leader>tb', gs.toggle_current_line_blame, desc = 'toggle git show blame line' },
        { '<leader>tD', gs.preview_hunk_inline, desc = 'toggle git show deleted' },
      }
    end,
  },
}
