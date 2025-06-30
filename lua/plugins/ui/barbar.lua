-- barbar is a bufferline plugin that provides a more modern and flexible bufferline.
-- src: https://github.com/romgrk/barbar.nvim

local hl_groups = {
  AlternateAdded = { fg = "#000000" },
  AlternateChanged = { fg = "#000000" },
  AlternateDeleted = { fg = "#000000" },
  AlternateInactive = { fg = "#000000" },
  AlternateVisible = { fg = "#000000" },
  AlternateModified = { fg = "#000000" },
  AlternatePinned = { fg = "#000000" },
}

return {
  'romgrk/barbar.nvim',
  lazy = false,
  dependencies = {
    'lewis6991/gitsigns.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  init = function()
    vim.g.barbar_auto_setup = false
    vim.api.nvim_set_hl()
  end,
  opts = {
    animation = true,
    icons = {
      -- Configure the base icons on the bufferline.
      -- Valid options to display the buffer index and -number are `true`, 'superscript' and 'subscript'
      buffer_index = false,
      buffer_number = 'superscript',
      button = Config.icon.ui.Close,
      -- Enables / disables diagnostic symbols
      -- diagnostics = {
      --   [vim.diagnostic.severity.ERROR] = { enabled = true, icon = Config.icon.ui.Error },
      --   [vim.diagnostic.severity.WARN] = { enabled = true, icon = Config.icon.ui.Warning },
      --   [vim.diagnostic.severity.INFO] = { enabled = true, icon = Config.icon.ui.Info },
      --   [vim.diagnostic.severity.HINT] = { enabled = true, icon = Config.icon.ui.Hint },
      -- },
      -- todo: change highlight groups
      gitsigns = {
        added = { enabled = true, icon = Config.icon.git.Added },
        changed = { enabled = true, icon = Config.icon.git.Modified },
        deleted = { enabled = true, icon = Config.icon.git.Deleted },
      },
      filetype = {
        -- Sets the icon's highlight group.
        -- If false, will use nvim-web-devicons colors
        custom_colors = false,

        -- Requires `nvim-web-devicons` if `true`
        enabled = true,
      },
      separator = { left = '│', right = '│' },

      -- If true, add an additional separator at the end of the buffer list
      separator_at_end = true,

      -- Configure the icons on the bufferline when modified or pinned.
      -- Supports all the base icon options.
      modified = { button = '󰟃' },
      pinned = { button = Config.icon.ui.Pin, filename = true },

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
  version = '^1.0.0', -- optional: only update when a new 1.x version is released
}
