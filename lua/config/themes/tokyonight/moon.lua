local hl = require 'config.highlights'
local common = require 'config.themes.tokyonight.common'
local pallette = require 'tokyonight.colors.moon'

local opts = { style = 'moon' }

require('tokyonight').setup(vim.tbl_deep_extend('force', common.opts, opts))

hl.set_blended_rainbow_indents(hl.std_rainbow_colors, pallette.bg_dark, pallette.fg, 0.2, 0.5)
