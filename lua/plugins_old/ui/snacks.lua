local colors = require 'lua.config.highlights'

return {
  -- snacks, A collection of small QoL plugins for Neovim.
  -- src: https://github.com/folke/snacks.nvim
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  config = function()
    require('snacks').setup {
      dashboard = {
        enabled = true,
        preset = require 'config.snacks.dashboard',
      },
      explorer = {
        enabled = true,
        replace_netrw = true,
      },
      bigfile = { enabled = true },
      -- SEE: https://github.com/folke/snacks.nvim/blob/main/docs/indent.md
      indent = require 'config.snacks.indent',
      input = { enabled = true },
      notifier = {
        enabled = true,
        timeout = 3000, -- 3 seconds
      },
      picker = require 'config.snacks.picker',
    }
    -- Setup some globals for debugging (lazy-loaded)
    _G.dd = function(...) Snacks.debug.inspect(...) end
    _G.bt = function() Snacks.debug.backtrace() end
    vim.print = _G.dd -- Override print to use snacks for `:=` command
  end,

  keys = {
    
  },
}
