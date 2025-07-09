local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local colors = require 'lua.config.highlights'
-- tokyonight - A clean, dark Neovim theme written in Lua, with support for

vim.api.schedule(function()
  colors.hl_groups.rainbow.dim.set()
  colors.hl_groups.rainbow.bright.set()
end)

autocmd("VimEnter", {
  group = augroup('CustomHlGroups', { clear = true }),
  desc = "Set default custom hl groups",
  callback = function()
    colors.hl_groups.rainbow.dim.set()
    colors.hl_groups.rainbow.bright.set()
  end,
})

return {
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,

    config = function()
      require('tokyonight').setup {
        styles = {
          comments = { italic = false },
        },
      }
      vim.cmd.colorscheme 'tokyonight-storm'
    end,
  }
}
