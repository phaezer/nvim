return {
  {
    -- tokyonight - A clean, dark Neovim theme written in Lua, with support for
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,

    config = function()
      require('tokyonight').setup {
        styles = {
          comments = { italic = false },
        },
      }
      vim.cmd.colorscheme 'tokyonight-storm'
    end,
  },

  {
    'olimorris/onedarkpro.nvim',
    lazy = true,
    priority = 1000,
  },

  {
    'rebelot/kanagawa.nvim',
    lazy = true,
    priority = 1000,
  },
}
