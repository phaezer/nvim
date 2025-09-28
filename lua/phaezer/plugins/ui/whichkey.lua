-- Which Key
-- a Neovim plugin that provides a popup menu for keybindings
return {
  'folke/which-key.nvim',
  lazy = true,
  event = 'VeryLazy',
  config = function()
    local wk = require 'which-key'

    wk.setup {
      preset = 'helix',
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
    -- cSpell:words grug
    wk.add {
      { '<leader>a', group = 'Avante', icon = '󱙺' },
      { '<leader>b', group = 'Buffer' },
      { '<leader>e', group = 'Explorers', icon = '󰱼' },
      { '<leader>fa', group = 'FT Actions', icon = '' },
      { '<leader>g', group = 'Git', icon = '' },
      { '<leader>h', group = 'Git Hunk', icon = '' },
      { '<leader>i', group = 'Inspect', icon = '' },
      { '<leader>k', group = 'Actions', icon = '' },
      { '<leader>ko', group = 'Obsidian', icon = '󰠮' },
      { '<leader>l', group = 'LSP', icon = '' },
      { '<leader>m', group = 'Mason', icon = '󱌣' },
      { '<leader>o', group = 'OpenCode', icon = '󱙺' },
      { '<leader>r', group = 'Refactor', icon = '' },
      { '<leader>s', group = 'Search', icon = '' },
      { '<leader>t', group = 'Terminal', icon = '' },
      { '<leader>u', group = 'UI', icon = '' },
      { '<leader>w', group = 'Window' },
      { '<leader>/', group = 'GrugFar', icon = '󰛔' },
      { '<leader>x', group = 'Trouble', icon = '󰴔' },
      { '<leader>?', group = 'WTF?', icon = '󱜹' },
    }
  end,
}
