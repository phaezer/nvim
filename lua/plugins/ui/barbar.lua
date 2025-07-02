-- barbar is a bufferline plugin that provides a more modern and flexible bufferline.
-- src: https://github.com/romgrk/barbar.nvim

local hl_groups = {
  Alternate = {
    Added = { fg = '#000000' },
    Changed = { fg = '#000000' },
    Deleted = { fg = '#000000' },
    Inactive = { fg = '#000000' },
    Visible = { fg = '#000000' },
    Modified = { fg = '#000000' },
    Pinned = { fg = '#000000' },
  },
}

return {
  'romgrk/barbar.nvim',
  lazy = false,
  dependencies = {
    'lewis6991/gitsigns.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  version = '^1.0.0', -- optional: only update when a new 1.x version is released

  init = function()
    vim.g.barbar_auto_setup = false
  end,

  opts = {
    animation = true,
    icons = {
      -- Configure the base icons on the bufferline.
      -- Valid options to display the buffer index and -number are `true`, 'superscript' and 'subscript'
      buffer_index = false,
      buffer_number = true,
      button = '',
      -- Enables / disables diagnostic symbols
      -- diagnostics = {
      --   [vim.diagnostic.severity.ERROR] = { enabled = true, icon = Config.icon.ui.Error },
      --   [vim.diagnostic.severity.WARN] = { enabled = true, icon = Config.icon.ui.Warning },
      --   [vim.diagnostic.severity.INFO] = { enabled = true, icon = Config.icon.ui.Info },
      --   [vim.diagnostic.severity.HINT] = { enabled = true, icon = Config.icon.ui.Hint },
      -- },
      -- todo: change highlight groups
      -- gitsigns = {
      --   added = { enabled = true, icon = '' },
      --   changed = { enabled = true, icon = '' },
      --   deleted = { enabled = true, icon = '' },
      -- },
      filetype = {
        custom_colors = false,
        enabled = true,
      },
      separator = { left = '│ ', right = '│' },

      -- If true, add an additional separator at the end of the buffer list
      separator_at_end = true,

      -- Configure the icons on the bufferline when modified or pinned.
      -- Supports all the base icon options.
      modified = { button = '󰟃' },
      pinned = { button = '', filename = true },

      -- Use a preconfigured buffer appearance— can be 'default', 'powerline', or 'slanted'
      preset = 'default',

      -- Configure the icons on the bufferline based on the visibility of a buffer.
      -- Supports all the base icon options, plus `modified` and `pinned`.
      -- alternate = { filetype = { enabled = false } },
      -- current = { buffer_index = true },
      -- inactive = { button = Config.icon.ui.Date },
      -- visible = { modified = { buffer_number = false } },
    },
  },

  keys = {
    { '<A-,>', '<Cmd>BufferPrevious<CR>', desc = 'Previous buffer' },
    { '<A-.>', '<Cmd>BufferNext<CR>', desc = 'Next buffer' },
    { '<A-<>', '<Cmd>BufferMovePrevious<CR>', desc = 'Next buffer' },
    { '<A->>', '<Cmd>BufferMoveNext<CR>', desc = 'Next buffer' },

    -- select buffer
    { '<A-1>', '<Cmd>BufferGoto 1<CR>', desc = 'Go to buffer 1' },
    { '<A-2>', '<Cmd>BufferGoto 2<CR>', desc = 'Go to buffer 2' },
    { '<A-3>', '<Cmd>BufferGoto 3<CR>', desc = 'Go to buffer 3' },
    { '<A-4>', '<Cmd>BufferGoto 4<CR>', desc = 'Go to buffer 4' },
    { '<A-5>', '<Cmd>BufferGoto 5<CR>', desc = 'Go to buffer 5' },
    { '<A-6>', '<Cmd>BufferGoto 6<CR>', desc = 'Go to buffer 6' },
    { '<A-7>', '<Cmd>BufferGoto 7<CR>', desc = 'Go to buffer 7' },
    { '<A-8>', '<Cmd>BufferGoto 8<CR>', desc = 'Go to buffer 8' },
    { '<A-9>', '<Cmd>BufferGoto 9<CR>', desc = 'Go to buffer 9' },
    { '<A-0>', '<Cmd>BufferGoto 10<CR>', desc = 'Go to buffer 10' },
    -- pin / unpin
    { '<A-p>', '<Cmd>BufferPin<CR>', desc = 'Pin buffer' },
    -- close buffer
    { '<A-c>', '<Cmd>BufferClose<CR>', desc = 'Close buffer' },
  },
}
