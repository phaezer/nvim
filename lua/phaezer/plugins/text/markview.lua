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
        icon_provider = 'devicons',
      },
    }
    -- setup the checkboxes module
    -- SRC: https://github.com/OXY2DEV/markview.nvim/blob/main/lua/markview/extras/checkboxes.lua
    require('markview.extras.checkboxes').setup()

    -- headings module
    require('markview.extras.headings').setup()
  end,
  init = function()
    vim.api.nvim_create_autocmd('FileType', {
      pattern = { 'markdown', 'md', 'mdx' },
      callback = function()
        require('phaezer.core.keys').map {
          mode = 'n',
          buffer = true,
          plugin = 'MarkView',
          prefix = '<leader>;',
          { 'r', '<cmd>Markview Toggle<cr>', desc = 'toggle render' },
          { 'y', '<cmd>Markview hybridToggle<cr>', desc = 'toggle hybrid render' },
          { 'c', '<cmd>Checkbox interactive<cr>', desc = 'checkbox state change' },
          { 'h', '<cmd>Headings increase<cr>', desc = 'heading lvl ' },
          { 'l', '<cmd>Headings increase<cr>', desc = 'heading lvl ' },
        }
      end,
    })
  end,
}
