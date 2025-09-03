local icons = require 'phaezer.core.icons'

return {
  -- Oil: A better file explorer for Neovim
  {
    'stevearc/oil.nvim',
    lazy = true,
    cmd = { 'Oil' },
    dependencies = { { 'echasnovski/mini.icons', version = '*', opts = {} } },
    opts = {
      columns = {
        'icon',
        -- 'permissions',
        -- 'size',
        -- 'mtime',
      },
      -- Skip the confirmation popup for simple operations (:help oil.skip_confirm_for_simple_edits)
      skip_confirm_for_simple_edits = false,
      keymaps_help = {
        border = 'rounded',
      },
      view_options = {
        show_hidden = true,
      },
      -- Configuration for the floating window in oil.open_float
      float = {
        -- Padding around the floating window
        padding = 2,
        max_width = 0.6,
        max_height = 0.6,
        border = 'rounded',
        preview_win = {
          win_options = {
            wrap = false,
          },
        },
        win_options = {
          winblend = 0,
        },
      },
      keymaps = {
        ['g?'] = { 'actions.show_help', mode = 'n' },
        ['<CR>'] = 'actions.select',
        ['<C-s>'] = { 'actions.select', opts = { vertical = true } },
        ['<C-h>'] = { 'actions.select', opts = { horizontal = true } },
        ['<C-t>'] = { 'actions.select', opts = { tab = true } },
        ['<C-p>'] = 'actions.preview',
        ['<C-c>'] = { 'actions.close', mode = 'n' },
        ['<C-y>'] = { 'actions.yank_entry', mode = 'n' },
        ['<C-l>'] = 'actions.refresh',
        ['-'] = { 'actions.parent', mode = 'n' },
        ['_'] = { 'actions.open_cwd', mode = 'n' },
        ['.'] = { 'actions.cd', mode = 'n' },
        [','] = { 'actions.cd', opts = { scope = 'tab' }, mode = 'n' },
        ['gs'] = { 'actions.change_sort', mode = 'n' },
        ['gx'] = 'actions.open_external',
        ['g.'] = { 'actions.toggle_hidden', mode = 'n' },
        ['g\\'] = { 'actions.toggle_trash', mode = 'n' },
        ['gd'] = {
          desc = 'Toggle file detail view',
          callback = function()
            vim.g.oil_show_detail = not (vim.g.oil_show_detail or false)
            if vim.g.oil_show_detail then
              require('oil').set_columns { 'icon', 'permissions', 'size', 'mtime' }
            else
              require('oil').set_columns { 'icon' }
            end
          end,
        },
      },
      preview = {
        -- Width dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
        -- min_width and max_width can be a single value or a list of mixed integer/float types.
        -- max_width = {100, 0.8} means "the lesser of 100 columns or 80% of total"
        max_width = 0.9,
        -- min_width = {40, 0.4} means "the greater of 40 columns or 40% of total"
        min_width = { 40, 0.4 },
        -- optionally define an integer/float for the exact width of the preview window
        width = nil,
        -- Height dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
        -- min_height and max_height can be a single value or a list of mixed integer/float types.
        -- max_height = {80, 0.9} means "the lesser of 80 columns or 90% of total"
        max_height = 0.9,
        -- min_height = {5, 0.1} means "the greater of 5 columns or 10% of total"
        min_height = { 5, 0.1 },
        -- optionally define an integer/float for the exact height of the preview window
        height = nil,
        border = 'rounded',
        win_options = {
          winblend = 0,
        },
        -- Whether the preview window is automatically updated when the cursor is moved
        update_on_cursor_moved = true,
      },
      ssh = {
        border = 'rounded',
      },
    },
    keys = {
      { '-', '<cmd>Oil<cr>', desc = 'Open parent directory' },
      {
        '<leader>-',
        function()
          local oil = require 'oil'
          if vim.w.is_oil_win then
            oil.close()
          else
            oil.open_float(nil, { preview = { vertical = true } })
          end
        end,
        desc = 'Toggle Oil (float)',
      },
    },
    init = function() vim.g.oil_show_detail = false end,
  },
  {
    dir = vim.fn.stdpath 'config' .. '/lua/phaezer/plugins/custom/oil-git',
    name = 'oil-git',
    opts = {
      symbols = {
        added = icons.git.Added,
        modified = icons.git.Modified,
        deleted = icons.git.Removed,
        untracked = icons.git.Untracked,
        ignored = icons.git.Ignored,
      },
    },
  },
}
