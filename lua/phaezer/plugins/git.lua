return {

  -- ==============================================================================================
  -- Fugitive
  -- provides the :Git command
  -- SRC: https://github.com/tpope/vim-fugitive
  {
    'tpope/vim-fugitive',
    lazy = true,
    cmd = { 'Git' },
  }, -- / Fugitive
  -- ----------------------------------------------------------------------------------------------

  -- =================================================================================
  -- LazyGit
  -- a simple terminal UI for git commands, written in Go with the gocui library
  -- SRC: https://github.com/jesseduffield/lazygit
  {
    'kdheepak/lazygit.nvim',
    lazy = true,
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    keys = {
      { '<leader>gg', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
    },
  }, -- / LazyGit
  -- ----------------------------------------------------------------------------------------------

  -- ==============================================================================================
  -- Git signs
  -- SRC: https://github.com/lewis6991/gitsigns.nvim
  {
    'lewis6991/gitsigns.nvim',
    lazy = true,
    -- version = 'v1.x',
    dependencies = {
      'tpope/vim-fugitive',
    },
    event = { 'BufReadPre' },
    opts = {
      signs = {
        add = { text = '┃' },
        change = { text = '┃' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
        untracked = { text = '┆' },
      },
      signs_staged = {
        add = { text = '┃' },
        change = { text = '┃' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
        untracked = { text = '┆' },
      },
      on_attach = function(bufnr)
        local gs = require 'gitsigns'

        require('phaezer.core.keys').set {
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
  }, -- / Git signs
  -- ----------------------------------------------------------------------------------------------

  -- ==============================================================================================
  -- Diffview
  -- a git diff viewer for Neovim
  -- SRC: https://github.com/sindrets/diffview.nvim
  {
    'sindrets/diffview.nvim',
    lazy = true,
    cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewToggleFiles', 'DiffviewFocusFiles' },
    opts = {
      enhanced_diff_hl = true, -- Enable enhanced highlighting for diffs
      use_icons = true, -- Use icons in the diff view
      icons = { -- Only applies when use_icons is true.
        folder_closed = '',
        folder_open = '',
      },
      signs = {
        fold_closed = '',
        fold_open = '',
        done = '✓',
      },
      file_panel = {
        win_config = {
          position = 'left', -- Position of the file panel
          width = 35, -- Width of the file panel
        },
      },
      keymaps = {
        view = {
          ['<leader>q'] = '<cmd>DiffviewClose<cr>', -- Close the diff view with <leader>q
        },
      },
    },
    config = function(opts)
      require('diffview').setup(opts)
      local keys = require 'phaezer.core.keys'
      -- Set keymaps for Diffview
      for i = 1, 9 do
        keys.set { '<leader>gdh' .. i, '<cmd>DiffviewOpen HEAD~' .. i .. '<cr>', desc = 'Diff Head~' .. i }
      end
    end,
    keys = {
      { '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = 'Open Diffview' },
      { '<leader>gdf', '<cmd>DiffviewFileHistory<cr>', desc = 'File History' },
      { '<leader>gdg', '<cmd>DiffviewToggleFiles<cr>', desc = 'Toggle Files' },
      { '<leader>gdp', '<cmd>DiffviewFocusFilesPanel<cr>', desc = 'Focus Files Panel' },
      { '<leader>gds', '<cmd>DiffviewToggleStageEntry<cr>', desc = 'Toggle Stage Entry' },
    },
  }, -- / Diffview
  -- ----------------------------------------------------------------------------------------------
}
