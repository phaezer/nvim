local hl = require 'phaezer.config.highlights'

local style = 'darker'

-- cSpell:words navarasu onedark
return {
  'navarasu/onedark.nvim',
  lazy = false,
  priority = 1000,
  opts = {
    style = style,
  },
  init = function()
    local plt = require('onedark.palette')[style]
    hl.patch_theme('onedark', function()
      local dart = {
        visible = { fg = plt.comment, bg = plt.bg0 },
        current = { fg = plt.fg, bg = plt.bg2 },
        label = { fg = plt.cyan, bold = true },
        modified_label = { fg = plt.purple, bold = true },
      }

      local git = {
        added = { fg = plt.green },
        conflict = { fg = plt.orange },
        modified = { fg = plt.yellow },
        deleted = { fg = plt.red },
        untracked = { fg = plt.grey },
        ignored = { fg = plt.grey },
        renamed = { fg = plt.blue },
      }

      return {
        rainbow = {
          base = plt.blue,
          bg = plt.bg1,
          fg = plt.fg,
          bg_alpha = 0.2,
          fg_alpha = 0.75,
        },

        groups = {
          -- NeoTree colors
          NeoTreeGitAdded = git.added,
          NeoTreeGitConflict = git.conflict,
          NeoTreeGitDeleted = git.deleted,
          NeoTreeGitModified = git.modified,
          NeoTreeDotFile = git.untracked,
          -- Oil git colors
          OilGitAdded = git.added,
          OilGitModified = git.modified,
          OilGitRenamed = git.renamed,
          OilGitUntracked = git.untracked,
          OilGitIgnored = git.ignored,
          -- Dart
          DartPickLabel = dart.label,
          -- current
          DartCurrent = dart.current,
          DartCurrentModified = vim.tbl_extend('force', dart.current, { italic = true }),
          DartCurrentLabel = vim.tbl_extend('force', dart.current, dart.label),
          DartCurrentLabelModified = vim.tbl_extend('force', dart.current, dart.modified_label),
          -- visible
          DartVisible = dart.visible,
          DartVisibleModified = vim.tbl_extend('force', dart.visible, { italic = true }),
          DartVisibleLabel = vim.tbl_extend('force', dart.visible, dart.label),
          DartVisibleLabelModified = vim.tbl_extend('force', dart.visible, dart.modified_label),
          -- marked current
          DartMarkedCurrent = dart.current,
          DartMarkedCurrentLabel = vim.tbl_extend('force', dart.current, dart.label),
          DartMarkedCurrentLabelModified = vim.tbl_extend(
            'force',
            dart.current,
            dart.modified_label
          ),
          -- marked
          DartMarked = dart.visible,
          DartMarkedLabel = vim.tbl_extend('force', dart.visible, dart.label),
          DartMarkedLabelModified = vim.tbl_extend('force', dart.visible, dart.modified_label),
        },
      }
    end)
  end,
}
