-- NOTE: adds a neovim UI for git
return {
  'NeogitOrg/neogit',
  cmd = { 'Neogit ' },
  dependencies = {
    'nvim-lua/plenary.nvim', -- required
    'sindrets/diffview.nvim',
    'folke/snacks.nvim',
  },
  keys = {
    { '<leader>gg', '<cmd>open Neogit<cr>', desc = 'Neogit', mode = 'n' },
  },
}
