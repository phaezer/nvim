-- Rainbow delimiters
-- src: https://github.com/HiPhish/rainbow-delimiters.nvim
return {
  'HiPhish/rainbow-delimiters.nvim',
  enabled = false,
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
  },
  config = function()
    require('rainbow-delimiters.setup').setup {
      strategy = {
        [''] = 'rainbow-delimiters.strategy.global',
        vim = 'rainbow-delimiters.strategy.local',
      },
      query = {
        [''] = 'rainbow-delimiters',
        lua = 'rainbow-blocks',
      },
      priority = {
        [''] = 110,
        lua = 210,
      },
      highlight = {
        'IndentRainbowBright1',
        'IndentRainbowBright2',
        'IndentRainbowBright3',
        'IndentRainbowBright4',
        'IndentRainbowBright5',
        'IndentRainbowBright6',
        'IndentRainbowBright7',
      },
    }
  end,
}
