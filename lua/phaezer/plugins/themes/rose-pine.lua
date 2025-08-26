local hl = require 'phaezer.config.highlights'

local variant = 'moon'

return {
  'rose-pine/neovim',
  name = 'rose-pine',
  lazy = false,
  priority = 1000,
  opts = {
    variant = variant,
  },
  init = function()
    local palette = require 'rose-pine.palette'
    hl.patch_theme('rose-pine', function()
      return {
        rainbow = {
          bg = palette.base,
          fg = palette.text,
          bg_alpha = 0.1,
        },
        groups = {
          BufferlineActive = { fg = palette.rose, bg = palette.overlay, bold = true },
          BufferlineInactive = { fg = palette.foam, bg = palette.base },
          -- NeoTree colors
          NeoTreeGitAdded = { fg = palette.pine },
          NeoTreeGitConflict = { fg = palette.iris },
          NeoTreeGitDeleted = { fg = palette.love },
          NeoTreeGitModified = { fg = palette.gold },
          -- Oil git colors
          OilGitAdded = { fg = palette.pine },
          OilGitModified = { fg = palette.gold },
          OilGitRenamed = { fg = palette.gold },
          OilGitUntracked = { fg = palette.muted },
          OilGitIgnored = { fg = palette.subtle },
        },
      }
    end)
  end,
}
