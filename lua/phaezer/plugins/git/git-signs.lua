-- Git signs
-- NOTE: adds git related signs to the gutter, as well as utilities for managing changes

local icons = require 'phaezer.core.icons'
-- cSpell:words gitsigns changedelete signcolumn topdelete qflist setqflist diffthis numhl
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
      delete = { text = '󰅀' },
      topdelete = { text = '󰅃' },
      changedelete = { text = icons.git.Modified },
      untracked = { text = '⟩' },
    },
    signs_staged = {
      add = { text = '║' },
      change = { text = '║' },
      delete = { text = '󰄼' },
      topdelete = { text = '󰄿' },
      changedelete = { text = icons.git.Modified },
      untracked = { text = '⟩' },
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
      local map = require('phaezer.core.keys').map
      map {
        mode = 'n',
        buffer = bufnr,
        {
          ']c',
          function()
            if vim.wo.diff then
              vim.cmd.normal { ']c', bang = true }
            else
              gs.nav_hunk 'next'
            end
          end,
          desc = 'Jump to next git change  gitsigns',
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
          desc = 'Jump to previous git change  gitsigns',
        },
      }

      map {
        mode = 'n',
        buffer = bufnr,
        prefix = '<leader>h',
        {
          's',
          function() gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' } end,
          desc = 'git stage hunk  gitsigns',
        },
        {
          'r',
          function() gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' } end,
          desc = 'git reset hunk  gitsigns',
        },
        { 'S', gs.stage_buffer, desc = 'git stage buffer  gitsigns' },
        { 'u', gs.stage_hunk, desc = 'git undo stage hunk  gitsigns' },
        { 'R', gs.reset_buffer, desc = 'git reset buffer  gitsigns' },
        { 'p', gs.preview_hunk, desc = 'git preview hunk  gitsigns' },
        { 'b', gs.blame_line, desc = 'git blame line  gitsigns' },
        { 'd', gs.diffthis, desc = 'git diff against index  gitsigns' },
        { 'q', gs.setqflist, desc = 'to qflist  gitsigns' },
        { 'p', gs.preview_hunk_inline, desc = 'toggle git show deleted  gitsigns' },
        {
          'Q',
          function() gs.setqflist 'all' end,
          desc = 'add all to qflist  gitsigns',
        },
        {
          'D',
          function() gs.diffthis '@' end,
          desc = 'git diff against last commit',
        },
      }

      -- ui key maps
      map {
        mode = 'n',
        buffer = bufnr,
        prefix = '<leader>u',
        {
          'gb',
          gs.toggle_current_line_blame,
          desc = 'toggle git blame line  gitsigns',
        },
        { 'gn', '<cmd>Gitsigns toggle_numhl<cr>', desc = 'toggle git numhl  gitsigns' },
        {
          'gw',
          '<cmd>Gitsigns toggle_word_diff<cr>',
          desc = 'toggle git numhl  gitsigns',
        },
      }
    end,
  },
}
