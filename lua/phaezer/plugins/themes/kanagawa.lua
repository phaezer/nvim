local hl = require 'phaezer.config.highlights'

return {
  'rebelot/kanagawa.nvim',
  lazy = false,
  priority = 1000,
  opts = {
    theme = 'wave',
    compile = false, -- enable compiling the colorscheme
    undercurl = true,
    commentStyle = { italic = true },
    functionStyle = {},
    keywordStyle = { italic = true },
    statementStyle = { bold = true },
    typeStyle = {},
    background = {
      dark = 'wave',
      light = 'lotus',
    },
    transparent = false, -- do not set background color
    dimInactive = false, -- dim inactive window `:h hl-NormalNC`
    terminalColors = true,
    -- colors = { -- add/modify theme and palette colors
    --   palette = {},
    --   theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
    -- },
    overrides = function(colors)
      local theme = colors.theme
      -- tint diagnostic virtual text colors
      local makeDiagnosticColor = function(color)
        local c = require 'kanagawa.lib.color'
        return { fg = color, bg = c(color):blend(theme.ui.bg, 0.9):to_hex() }
      end

      return {
        DiagnosticVirtualTextHint = makeDiagnosticColor(theme.diag.hint),
        DiagnosticVirtualTextInfo = makeDiagnosticColor(theme.diag.info),
        DiagnosticVirtualTextWarn = makeDiagnosticColor(theme.diag.warning),
        DiagnosticVirtualTextError = makeDiagnosticColor(theme.diag.error),
      }
    end,
  },
  init = function()
    hl.patch_theme('kanagawa', function()
      local palette = require('kanagawa.colors').setup().palette
      return {
        rainbow = {
          -- base = '#0058ff',
          base = palette.crystalBlue,
          bg = palette.sumiInk3,
          fg = palette.fujiWhite,
          fg_alpha = 0.8,
        },
        groups = {
          BufferlineActive = { fg = palette.waveRed, bg = palette.sumiInk4, bold = true },
          BufferlineInactive = { fg = palette.fujiGray, bg = palette.sumiInk3 },
          -- NeoTree colors
          NeoTreeGitAdded = { fg = palette.springGreen },
          NeoTreeGitConflict = { fg = palette.samuraiRed },
          NeoTreeGitDeleted = { fg = palette.waveRed },
          NeoTreeGitModified = { fg = palette.crystalBlue },

          -- Oil git colors
          OilGitAdded = { fg = palette.springGreen },
          OilGitModified = { fg = palette.crystalBlue },
          OilGitRenamed = { fg = palette.crystalBlue },
          OilGitUntracked = { fg = palette.fujiGray },
          OilGitIgnored = { fg = palette.fujiGray },

          -- Dart
          DartPickLabel = { fg = palette.crystalBlue, bold = true },
          DartCurrent = { bg = palette.sumiInk4 },
          DartCurrentModified = { bg = palette.sumiInk4, italic = true },
          DartCurrentLabel = { fg = palette.waveRed, bg = palette.sumiInk4, bold = true },
          DartCurrentLabelModified = { fg = palette.waveRed, bg = palette.sumiInk4, bold = true },
          DartVisible = { fg = palette.fujiGray, bg = palette.sumiInk3 },
          DartVisibleModified = { fg = palette.fujiGray, bg = palette.sumiInk3, italic = true },
          DartVisibleLabel = { fg = palette.fujiGray, bg = palette.sumiInk3 },
          DartVisibleLabelModified = { fg = palette.waveRed, bg = palette.sumiInk3, bold = true },
        },
      }
    end)
  end,
}
