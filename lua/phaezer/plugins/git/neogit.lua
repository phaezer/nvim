-- NOTE: adds a neovim UI for git
return {
  'NeogitOrg/neogit',
  cmd = { 'Neogit ' },
  dependencies = {
    'nvim-lua/plenary.nvim', -- required
    'sindrets/diffview.nvim',
    'folke/snacks.nvim',
  },
  opts = {
    kind = 'split', -- opens neogit in a split
    signs = {
      -- { CLOSED, OPENED }
      section = { '', '' },
      item = { '', '' },
      hunk = { '', '' },
    },
    integrations = { diffview = true }, -- adds integration with diffview.nvim
  },
  keys = {
    { '<leader>gg', '<cmd>Neogit<cr>', desc = 'Neogit', mode = 'n' },
  },
}
