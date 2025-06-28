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

      local indents = {
        -- dim
        Dim0 = { fg = "#25283B" },
        Dim1 = { fg = "#26314D" },
        Dim2 = { fg = "#483665" },
        Dim3 = { fg = "#472637" },
        Dim4 = { fg = "#3F2B23" },
        Dim5 = { fg = "#3A391F" },
        Dim6 = { fg = "#21391E" },
        Dim7 = { fg = "#1B3034" },

        -- Bright
        Bright0 = { fg = "#25283B" },
        Bright1 = { fg = "#7496F4" },
        Bright2 = { fg = "#A47BE5" },
        Bright3 = { fg = "#DA74A8" },
        Bright4 = { fg = "#E69775" },
        Bright5 = { fg = "#D4D170" },
        Bright6 = { fg = "#80DD78" },
        Bright7 = { fg = "#56C2BD" },
      }

      for k, color in pairs(indents) do
        vim.api.nvim_set_hl(0, "IndentRainbow" .. k, color)
      end
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
