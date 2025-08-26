-- NOTE: provides highlighting for nested delimiters like parentheses, brackets, and braces in different colors.
return {
  'HiPhish/rainbow-delimiters.nvim',
  lazy = false,
  config = function()
    vim.g.rainbow_delimiters = {
      strategy = {
        [''] = 'rainbow-delimiters.strategy.global',
        vim = 'rainbow-delimiters.strategy.local',
      },
      query = {
        [''] = 'rainbow-delimiters',
        -- lua = 'rainbow-blocks',
      },
      priority = {
        [''] = 110,
        lua = 210,
      },
      highlight = require('phaezer.config.highlights').rainbow.names.delimiters,
    }
  end,
}
