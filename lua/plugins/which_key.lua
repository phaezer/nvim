-- see: https://github.com/folke/which-key.nvim
return {
  -- which-key - Useful plugin to show you pending keybinds.
  'folke/which-key.nvim',
  lazy = false,
  event = 'VimEnter',
  opts = {
    -- delay between pressing a key and opening which-key (milliseconds)
    -- this setting is independent of vim.o.timeoutlen
    delay = 0,
    icons = {
      breadcrumb = '»', -- symbol used in the command line area that shows your active key combo
      separator = "➜", -- symbol used between a key and it's label
      group = "󰘴", -- symbol prepended to a group
      ellipsis = "󰇘",
      colors = false, -- use which-key colors
      mappings = true,
      keys = {
        Up = " ",
        Down = " ",
        Left = " ",
        Right = " ",
        C = "󰘴 ",
        M = "󰘵 ",
        D = "󰘳 ",
        S = "󰘶 ",
        CR = "󰌑 ",
        Esc = "󱊷 ",
        ScrollWheelDown = "󱕐 ",
        ScrollWheelUp = "󱕑 ",
        NL = "󰌑 ",
        BS = "󰁮",
        Space = "󱁐 ",
        Tab = "󰌒 ",
        F1 = "󱊫",
        F2 = "󱊬",
        F3 = "󱊭",
        F4 = "󱊮",
        F5 = "󱊯",
        F6 = "󱊰",
        F7 = "󱊱",
        F8 = "󱊲",
        F9 = "󱊳",
        F10 = "󱊴",
        F11 = "󱊵",
        F12 = "󱊶",
      }
    },

    -- Document existing key chains
    spec = {
      { '<leader>f', group = 'Files' },
      { '<leader>s', group = 'Search' },
      { '<leader>r', group = 'Refactor' },
      { '<leader>t', group = 'Toggle' },
      { '<leader>g', group = 'Git' },
      { '<leader>x', group = 'Trouble' },
      { '<leader>u', group = 'UI' },
      { '<leader>w', group = 'Window' },
      { '<leader>h', group = 'Git Hunk', mode = { 'n' } },
      { '<leader>b', group = 'Buffer' },
      { '<leader>t', group = 'Otter' },
      { '<leader>?', group = 'WTF' },
    },
  },
}
