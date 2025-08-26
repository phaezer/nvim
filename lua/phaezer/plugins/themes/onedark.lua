local hl = require 'phaezer.config.highlights'

return {
  'EdenEast/nightfox.nvim',
  lazy = false,
  priority = 1000,
  opts = {
    options = {
      styles = {
        -- comments = 'italic',
        types = 'bold',
        functions = 'bold',
      },
    },
  },
  init = function()
    local palettes = require('nightfox.palette').load()
    for name, palette in pairs(palettes) do
      hl.patch_theme(name, function()
        return {
          rainbow = {
            base = palette.blue.base,
            bg = palette.bg1,
            fg = palette.fg1,
            bg_alpha = 0.2,
            fg_alpha = 0.75,
          },
          groups = {
            BufferlineActive = { fg = palette.magenta.base, bg = palette.bg2, bold = true },
            BufferlineInactive = { fg = palette.comment, bg = palette.bg0 },
            -- NeoTree colors
            NeoTreeGitAdded = { fg = palette.green.base },
            NeoTreeGitConflict = { fg = palette.orange.base },
            NeoTreeGitDeleted = { fg = palette.red.base },
            NeoTreeGitModified = { fg = palette.yellow.base },
            -- Oil git colors
            OilGitAdded = { fg = palette.green.base },
            OilGitModified = { fg = palette.yellow.base },
            OilGitRenamed = { fg = palette.cyan.base },
            OilGitUntracked = { fg = palette.magenta.base },
            OilGitIgnored = { fg = palette.comment },
            -- flash
            FlashBackdrop = { fg = palette.fg0 },
            -- Dart
            DartPickLabel = { fg = palette.magenta.base, bold = true },
            DartCurrent = { bg = palette.bg2 },
            DartCurrentModified = { bg = palette.bg2, italic = true },
            DartCurrentLabel = { fg = palette.magenta.base, bg = palette.bg2, bold = true },
            DartCurrentLabelModified = { fg = palette.orange.base, bg = palette.bg2, bold = true },
            DartVisible = { fg = palette.comment, bg = palette.bg0 },
            DartVisibleModified = { fg = palette.comment, bg = palette.bg0, italic = true },
            DartVisibleLabel = { fg = palette.magenta.base, bg = palette.bg0 },
            DartVisibleLabelModified = { fg = palette.orange.base, bg = palette.bg0, bold = true },
          },
        }
      end)
    end
  end,
}
