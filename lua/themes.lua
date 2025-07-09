local api = vim.api
local add = MiniDeps.add
local hl_util = require 'config.highlights'

-- the selected theme to load on startup
local selected = 'tokyonight-storm'

-- tokyonight.nvim is a color scheme for Neovim
-- SRC: https://github.com/folke/tokyonight.nvim
add {
  source = 'folke/tokyonight.nvim',
  name = 'tokyonight',
  checkout = 'main',
  monitor = 'main',
}
add { source = 'rebelot/kanagawa.nvim' }
-- add { source = 'catppuccin/nvim', name = 'catppuccin' }

local theme_setup = {
  ['tokyonight-moon'] = function() require 'config.themes.tokyonight.moon' end,
  ['tokyonight-storm'] = function() require 'config.themes.tokyonight.storm' end,
  ['kanagawa-wave'] = function() require 'config.themes.klanagawa.wave' end,
  ['kanagawa-dragon'] = function() require 'config.themes.klanagawa.dragon' end,
  -- TODO: additional theme configurations (catppuccin, etc.)
  -- ['catppuccin-macchiato'] = function()
  --   require('catppuccin').setup {
  --     flavour = 'macchiato',
  --     term_colors = true,
  --   }
  --   local colors = require('catppuccin.palettes').get_pallette 'macchiato'
  --   hl_util.set_rainbow_indent(colors.base, 0.2, colors.text, 0.5)
  -- end,
  -- ['catppuccin-mocha'] = function()
  --   require('catppuccin').setup {
  --     flavour = 'mocha',
  --     term_colors = true,
  --   }
  --   local colors = require('catppuccin.palettes').get_pallette 'mocha'
  --   hl_util.set_rainbow_indent(colors.base, 0.2, colors.text, 0.5)
  -- end,
}

if theme_setup[selected] ~= nil then theme_setup[selected]() end

api.nvim_create_autocmd('ColorScheme', {
  group = api.nvim_create_augroup('theme-setup', { clear = true }),
  desc = 'update color scheme config after colorscheme is set',
  callback = function(ev) pcall(theme_setup[ev.match]) end,
})

vim.cmd('colorscheme ' .. selected)
