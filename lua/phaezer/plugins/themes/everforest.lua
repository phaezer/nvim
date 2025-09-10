local opts = {
  background = 'hard',
  colours_override = function(palette) end,
}

return {
  'neanias/everforest-nvim',
  lazy = false,
  priority = 1000,
  opts = opts,
  config = function()
    local hl = require 'phaezer.config.highlights'
    hl.patch_theme('everforest', function()
      local plt = require('everforest.colours').generate_palette(opts, 'dark')
      return {
        rainbow = {
          base = plt.blue,
          bg = plt.bg1,
          fg = plt.fg,
          fg_alpha = 0.9,
        },
        groups = {
          -- NeoTree colors
          NeoTreeGitAdded = { fg = plt.green },
          NeoTreeGitConflict = { fg = plt.red },
          NeoTreeGitDeleted = { fg = plt.red },
          NeoTreeGitModified = { fg = plt.orange },
          -- Oil git colors
          OilGitAdded = { fg = plt.green },
          OilGitModified = { fg = plt.orange },
          OilGitRenamed = { fg = plt.blue },
          OilGitUntracked = { fg = plt.grey1 },
          OilGitIgnored = { fg = plt.grey2 },
          -- Dart
          DartPickLabel = { fg = plt.green, bold = true },
          DartCurrent = { bg = plt.bg2 },
          DartCurrentModified = { bg = plt.bg2, italic = true },
          DartCurrentLabel = { fg = plt.blue, bg = plt.bg2, bold = true },
          DartCurrentLabelModified = {
            fg = plt.yellow,
            bg = plt.bg2,
            bold = true,
          },
          DartVisible = { fg = plt.comment, bg = plt.bg0 },
          DartVisibleModified = { fg = plt.comment, bg = plt.bg0, italic = true },
          DartVisibleLabel = { fg = plt.blue, bg = plt.bg0 },
          DartVisibleLabelModified = { fg = plt.yellow, bg = plt.bg0, bold = true },
        },
      }
    end)
  end,
}
