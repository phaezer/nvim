return {
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      style = 'night',
      styles = {
        comments = { italic = false },
        functions = { italic = false },
      },
    },
    init = function()
      local hl = require 'phaezer.config.highlights'
      local palettes = {
        tokyonight = 'tokyonight.colors.night',
        ['tokyonight-day'] = 'tokyonight.colors.day',
        ['tokyonight-moon'] = 'tokyonight.colors.moon',
        ['tokyonight-storm'] = 'tokyonight.colors.storm',
      }
      for name, palette in pairs(palettes) do
        hl.patch_theme(name, function()
          local palette = require(palette)
          return {
            rainbow = {
              base = palette.blue,
              bg = palette.bg,
              fg = palette.fg,
            },
            groups = {
              BufferlineActive = { fg = palette.blue, bg = palette.bg_highlight, bold = true },
              BufferlineInactive = { fg = palette.comment, bg = palette.bg },
              -- NeoTree colors
              NeoTreeGitAdded = { fg = palette.git.add },
              NeoTreeGitConflict = { fg = palette.red },
              NeoTreeGitDeleted = { fg = palette.git.delete },
              NeoTreeGitModified = { fg = palette.git.change },
              -- Oil git colors
              OilGitAdded = { fg = palette.git.add },
              OilGitModified = { fg = palette.git.change },
              OilGitRenamed = { fg = palette.git.rename },
              OilGitUntracked = { fg = palette.git.untracked },
              OilGitIgnored = { fg = palette.git.ignored },
              -- Dart
              DartPickLabel = { fg = palette.blue, bold = true },
              DartCurrent = { bg = palette.bg_highlight },
              DartCurrentModified = { bg = palette.bg_highlight, italic = true },
              DartCurrentLabel = { fg = palette.blue, bg = palette.bg_highlight, bold = true },
              DartCurrentLabelModified = { fg = palette.git.change, bg = palette.bg2, bold = true },
              DartVisible = { fg = palette.comment, bg = palette.bg },
              DartVisibleModified = { fg = palette.comment, bg = palette.bg, italic = true },
              DartVisibleLabel = { fg = palette.blue, bg = palette.bg },
              DartVisibleLabelModified = { fg = palette.git.change, bg = palette.bg, bold = true },
            },
          }
        end)
      end
    end,
  },
}
