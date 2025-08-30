-- Which Key
-- a Neovim plugin that provides a popup menu for keybindings
return {
  'folke/which-key.nvim',
  lazy = true,
  event = 'VeryLazy',
  config = function()
    local wk = require 'which-key'

    wk.setup {
      -- delay between pressing a key and opening which-key (milliseconds)
      -- this setting is independent of vim.o.timeoutlen
      delay = 250,
      icons = {
        breadcrumb = '', -- symbol used in the command line area that shows your active key combo
        separator = '', -- symbol used between a key and it's label
        group = ' ', -- symbol prepended to a group
        ellipsis = '󰇘',
        colors = false, -- use which-key colors
        mappings = true,
        keys = {
          Up = ' ',
          Down = ' ',
          Left = ' ',
          Right = ' ',
          C = '󰘴 ',
          M = '󰘵 ',
          D = '󰘳 ',
          S = '󰘶 ',
          CR = '󰌑 ',
          Esc = '󱊷 ',
          ScrollWheelDown = '󱕐 ',
          ScrollWheelUp = '󱕑 ',
          NL = '󰌑 ',
          BS = '󰁮 ',
          Space = '󱁐 ',
          Tab = '󰌒 ',
          F1 = '󱊫',
          F2 = '󱊬',
          F3 = '󱊭',
          F4 = '󱊮',
          F5 = '󱊯',
          F6 = '󱊰',
          F7 = '󱊱',
          F8 = '󱊲',
          F9 = '󱊳',
          F10 = '󱊴',
          F11 = '󱊵',
          F12 = '󱊶',
        },
      },
    }

    -- which key mappings
    wk.add {
      { '<leader>b', group = 'Buffer' },
      {
        '<leader>b',
        'b',
        group = 'Buffers',
        expand = function() return require('which-key.extras').expand.buf() end,
      },
      { '<leader>?', group = 'WTF?', icon = '󱜺' },
      { '<leader>d', group = 'Diff', mode = { 'n' } },
      { '<leader>e', group = 'Explorers', icon = '󰱼' },
      { '<leader>f', group = 'Find', icon = '' },
      { '<leader>F', group = 'GrugFar', icon = '󰛔' },
      { '<leader>g', group = 'Git', icon = '' },
      { '<leader>h', group = 'Git Hunk', mode = { 'n' } },
      { '<leader>i', group = 'Inspect', icon = '' },
      { '<leader>l', group = 'LSP', icon = '󰒋' },
      { '<leader>r', group = 'Refactor', icon = '' },
      { '<leader>t', group = 'Terminal', icon = '' },
      { '<leader>u', group = 'UI' },
      { '<leader>w', group = 'Window' },
      { '<leader>x', group = 'Trouble' },
    }
  end,
}
