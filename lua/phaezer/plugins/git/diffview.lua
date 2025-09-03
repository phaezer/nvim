local icons = require 'phaezer.core.icons'
-- Diffview
-- NOTE: a git diff viewer for Neovim
return {
  'sindrets/diffview.nvim',
  lazy = true,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  cmd = {
    'DiffviewOpen',
    'DiffviewClose',
    'DiffviewToggleFiles',
    'DiffviewFocusFiles',
  },
  opts = {
    enhanced_diff_hl = true, -- Enable enhanced highlighting for diffs
    use_icons = true, -- Use icons in the diff view
    icons = { -- Only applies when use_icons is true.
      folder_closed = icons.gui.FolderClosed,
      folder_open = icons.gui.FolderOpen,
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
    -- TODO: replace with vim user input
    local keys = require 'phaezer.core.keys'
    -- Set keymaps for Diffview
    for i = 1, 9 do
      keys.map {
        { '<leader>gdh' .. i, '<cmd>DiffviewOpen HEAD~' .. i .. '<cr>', desc = 'diff head~' .. i },
      }
    end
  end,
  keys = {
    { '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = 'git diff  diffview' },
    { '<leader>gdf', '<cmd>DiffviewFileHistory<cr>', desc = 'file history  diffview' },
    { '<leader>gdg', '<cmd>DiffviewToggleFiles<cr>', desc = 'toggle files  diffview' },
    { '<leader>gdp', '<cmd>DiffviewFocusFilesPanel<cr>', desc = 'focus files panel  diffview' },
    {
      '<leader>gds',
      '<cmd>DiffviewToggleStageEntry<cr>',
      desc = 'toggle stage entry  diffview',
    },
  },
}
