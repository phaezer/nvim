local keys = require 'phaezer.core.keys'

-- todo: finish config
return {
  'akinsho/toggleterm.nvim',
  lazy = true,
  cmd = {
    'ToggleTerm',
    'TermNew',
    'TermSelect',
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
    open_mapping = [[<c-\>]],
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
      height = math.ceil(vim.o.lines * 1.0 - 4),
      width = math.ceil(vim.o.columns * 1.0),
      winblend = 0,
    },
  },
  keys = {
    { '<leader>tf', '<cmd>ToggleTerm direction=float<cr>', desc = 'Toggle floating terminal' },
    { '<leader>tg', '<cmd>ToggleTerm direction=vertical<cr>', desc = 'Toggle horizontal Terminal' },
    { '<leader>tv', '<cmd>ToggleTerm direction=vertical<cr>', desc = 'Toggle Vertical Terminal' },
  },
}
