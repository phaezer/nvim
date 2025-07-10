return {
  layout = {
    hidden = { 'input' },
  },
  enabled = true,
  ui_select = false,       -- don't replace `vim.ui.select` with the snacks picker
  icons = {
    diagnostics = {
      Error = ' ',
      Warn = ' ',
      Hint = ' ',
      Info = ' ',
    },
    git = {
      commit = '󰜘',
      conflict = '',
      staged = '',
      added = '',
      deleted = '',
      modified = '',
      ignored = '',
      unstaged = '',
      renamed = '',
      untracked = '',
    },
  }
}
