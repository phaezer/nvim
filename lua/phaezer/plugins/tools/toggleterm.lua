local keys = require 'phaezer.core.keys'

-- todo: finish config
return {
  'akinsho/toggleterm.nvim',
  lazy = true,
  cmd = {
    'ToggleTerm',
    'ToggleTermToggleAll',
    'ToggleTermSendCurrentLine',
    'ToggleTermSendVisualLines',
    'ToggleTermSendVisualSelection',
  },
  version = '*',
  opts = {
    size = function(term)
      if term.direction == 'horizontal' then
        return 15
      elseif term.direction == 'vertical' then
        return vim.o.columns * 0.4
      end
    end,
    open_mapping = [[<c-`>]], -- same as vscode default
    hide_numbers = true,
    shade_terminals = false,
    insert_mappings = true,
    persist_size = true,
    direction = 'float',
    close_on_exit = true,
    highlights = {
      NormalFloat = {
        link = 'Normal',
      },
      FloatBorder = {
        link = 'FloatBorder',
      },
    },
    float_opts = {
      border = 'rounded',
      height = math.ceil(vim.o.lines - 4),
      width = math.ceil(vim.o.columns - 4),
      winblend = 0,
    },
  }
}
