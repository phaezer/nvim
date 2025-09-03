-- Visual Whitespace
-- NOTE: Display white space characters in visual mode, like VSCode's renderWhitespace: selection.
return {
  'mcauley-penney/visual-whitespace.nvim',
  lazy = true,
  event = 'BufEnter',
  opts = {
    enabled = true,
    highlight = { link = 'Visual', default = true },
    match_types = {
      space = true,
      tab = true,
      nbsp = true,
      lead = true,
      trail = true,
    },
    list_chars = {
      space = '',
      tab = '',
      nbsp = '',
      lead = '',
      trail = '',
    },
    fileformat_chars = {
      unix = '',
      mac = '',
      dos = '󰘌',
    },
    ignore = {
      filetypes = {
        'dashboard',
        'neo-tree',
        'snacks_dashboard',
        'Outline',
        'Oil',
      },
      buftypes = {
        'Terminal',
      },
    },
  },
  keys = {
    {
      '<leader>v.',
      function() require('visual-whitespace').toggle() end,
      desc = 'toggle visual whitespace',
    },
  },
}
