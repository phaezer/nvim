return {
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      style = 'storm',
      styles = {
        comments = { italic = false },
        functions = { italic = false },
      },
    },
    init = function()
      local hl = require 'phaezer.config.highlights'
      local palettes = {
        tokyonight = 'tokyonight.colors.night',
        ['tokyonight-night'] = 'tokyonight.colors.night',
        ['tokyonight-day'] = 'tokyonight.colors.day',
        ['tokyonight-moon'] = 'tokyonight.colors.moon',
        ['tokyonight-storm'] = 'tokyonight.colors.storm',
      }
      for name, palette in pairs(palettes) do
        hl.patch_theme(name, function()
          local plt = require(palette)
          -- day palette is a fund
          if type(plt) == 'function' then plt = plt() end
          return {
            rainbow = {
              base = plt.blue,
              bg = plt.bg,
              fg = plt.fg,
              fg_alpha = 0.9,
            },
            groups = {
              -- NeoTree colors
              NeoTreeGitAdded = { fg = plt.git.add },
              NeoTreeGitConflict = { fg = plt.red },
              NeoTreeGitDeleted = { fg = plt.git.delete },
              NeoTreeGitModified = { fg = plt.git.change },
              -- Oil git colors
              OilGitAdded = { fg = plt.git.add },
              OilGitModified = { fg = plt.git.change },
              OilGitRenamed = { fg = plt.git.rename },
              OilGitUntracked = { fg = plt.git.untracked },
              OilGitIgnored = { fg = plt.git.ignored },
              -- Dart
              DartPickLabel = { fg = plt.blue, bold = true },
              DartCurrent = { bg = plt.bg_highlight },
              DartCurrentModified = { bg = plt.bg_highlight, italic = true },
              DartCurrentLabel = { fg = plt.blue, bg = plt.bg_highlight, bold = true },
              DartCurrentLabelModified = {
                fg = plt.orange,
                bg = plt.bg_highlight,
                bold = true,
              },
              DartVisible = { fg = plt.comment, bg = plt.bg },
              DartVisibleModified = { fg = plt.comment, bg = plt.bg, italic = true },
              DartVisibleLabel = { fg = plt.blue, bg = plt.bg },
              DartVisibleLabelModified = { fg = plt.orange, bg = plt.bg, bold = true },
            },
          }
        end)
      end
    end,
  },
}
