-- NOTE: provides inline rendering of markdown with some additional markdown
-- functions

return {
  'OXY2DEV/markview.nvim',
  lazy = false,
  priority = 49,
  dependencies = {
    'saghen/blink.cmp',
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    local presets = require 'markview.presets'
    require('markview').setup {
      markdown = {
        headings = presets.headings.glow,
      },
      preview = {
        -- add Avante
        filetypes = { 'md', 'rmd', 'quarto', 'Avante' },
        icon_provider = 'devicons',
      },
    }
    -- setup the checkboxes module
    -- SRC: https://github.com/OXY2DEV/markview.nvim/blob/main/lua/markview/extras/checkboxes.lua
    require('markview.extras.checkboxes').setup()

    -- headings module
    require('markview.extras.headings').setup()

    -- extra mappings
    local map = require('phaezer.core.keys').map
    map {
      prefix = '<leader>k',
      plugin = 'Markview',
      { 'mt', '<cmd>Markview Toggle<cr>', desc = 'toggle render' },
      { 'my', '<cmd>Markview hybridToggle<cr>', desc = 'toggle hybrid render' },
      { 'mc', '<cmd>Checkbox interactive<cr>', desc = 'checkbox state change' },
      { 'mh', '<cmd>Headings increase<cr>', desc = 'heading lvl ' },
      { 'mH', '<cmd>Headings increase<cr>', desc = 'heading lvl ' },
    }
  end,
}
