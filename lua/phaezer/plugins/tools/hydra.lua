return {
  'nvimtools/hydra.nvim',
  config = function()
    local Hydra = require 'hydra'
    Hydra {
      name = 'resize window',
      mode = 'n',
      body = '<leader>ww',
      hint = false,
      -- config = { ... },
      heads = {
        { 'l', '<CMD>wincmd L<CR>', { desc = 'move 󰜴' } },
        { 'k', '<CMD>resize +5<CR>', { desc = ' height' } },
        { 'j', '<CMD>resize -5<CR>', { desc = ' height' } },
        { 'h', '<CMD>vertical resize +5<CR>', { desc = ' width' } },
        { 'l', '<CMD>vertical resize -3<CR>', { desc = ' width' } },
        { '=', '<CMD>wincmd =<CR>', { desc = ' width' } },
        { 'r', '<CMD>wincmd r<CR>', { desc = 'rotate ' } },
        { 'R', '<CMD>wincmd R<CR>', { desc = 'rotate ' } },
        { 'H', '<CMD>wincmd H<CR>', { desc = 'move 󰜱' } },
        { 'J', '<CMD>wincmd J<CR>', { desc = 'move 󰜮' } },
        { 'K', '<CMD>wincmd K<CR>', { desc = 'move 󰜷' } },
        { 'L', '<CMD>wincmd L<CR>', { desc = 'move 󰜴' } },
      },
    }
  end,
}
