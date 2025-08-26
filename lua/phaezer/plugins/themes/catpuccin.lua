local hl = require 'phaezer.config.highlights'

local variant = 'mocha'

return {
  'catppuccin/nvim',
  name = 'catppuccin',
  lazy = false,
  priority = 1000,
  opts = {
    flavour = variant,
    styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
      comments = { 'italic' }, -- Change the style of comments
      conditionals = { 'italic' },
      -- loops = {},
      functions = { 'bold' },
      -- keywords = {},
      -- strings = {},
      -- variables = {},
      -- numbers = {},
      -- booleans = {},
      -- properties = {},
      types = { 'bold' },
      -- operators = {},
    },
    integrations = {
      cmp = true,
      gitsigns = true,
      neotree = true,
      nvimtree = false,
      treesitter = true,
      diffview = true,
      noice = true,
      copilot = true,
      flash = true,
      grug_far = true,
      neotest = true,
      overseer = true,
      trouble = true,
      which_key = true,
      dadbod_ui = true,
      snacks = {
        enabled = true,
        indent_scope_color = '', -- catppuccin color (eg. `lavender`) Default: text
      },
    },
  },
  init = function()
    local palette = require('catppuccin.palettes.' .. variant)
    hl.patch_theme('catppuccin', function()
      return {
        rainbow = {
          base = palette.blue,
          bg = palette.base,
          fg = palette.text,
          bg_alpha = 0.2,
          fg_alpha = 0.75,
        },
        groups = {
          BufferlineActive = { fg = palette.sky, bg = palette.surface0, bold = true },
          BufferlineInactive = { fg = palette.subtext1, bg = palette.base },
          -- NeoTree colors
          NeoTreeGitAdded = { fg = palette.green },
          NeoTreeGitConflict = { fg = palette.mauve },
          NeoTreeGitDeleted = { fg = palette.red },
          NeoTreeGitModified = { fg = palette.blue },
          -- Oil git colors
          OilGitAdded = { fg = palette.green },
          OilGitModified = { fg = palette.blue },
          OilGitRenamed = { fg = palette.blue },
          OilGitUntracked = { fg = palette.subtext1 },
          OilGitIgnored = { fg = palette.subtext1 },
          -- Dart
          DartPickLabel = { fg = palette.sky, bold = true },
          DartCurrent = { bg = palette.surface0 },
          DartCurrentLabel = { fg = palette.sky, bg = palette.surface0, bold = true },
          DartVisible = { fg = palette.subtext1, bg = palette.bg },
          DartVisibleLabel = { fg = palette.muave, bg = palette.bg },
          DartCurrentModified = { bg = palette.surface0, italic = true },
          DartVisibleModified = { fg = palette.subtext1, bg = palette.base, italic = true },
          DartCurrentLabelModified = { fg = palette.muave, bg = palette.base, bold = true },
          DartVisibleLabelModified = { fg = palette.muave, bg = palette.base, bold = true },
        },
      }
    end)
  end,
}
