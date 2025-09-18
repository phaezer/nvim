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

          local dart = {
            visible = { fg = plt.comment, bg = plt.bg },
            current = { fg = plt.fg, bg = plt.bg_highlight },
            label = { fg = plt.blue, bold = true },
            modified_label = { fg = plt.orange, bold = true },
          }

          local git = {
            added = { fg = plt.git.add },
            conflict = { fg = plt.git.add },
            modified = { fg = plt.git.change },
            deleted = { fg = plt.git.delete },
            untracked = { fg = plt.git.untracked },
            ignored = { fg = plt.git.ignored },
            renamed = { fg = plt.git.rename },
          }

          return {
            rainbow = {
              base = plt.blue,
              bg = plt.bg,
              fg = plt.bg,
              fg_alpha = 0.8,
            },
            groups = {
              -- cursors
              nCursor = { fg = plt.bg_dark1, bg = plt.blue },
              iCursor = { bg = plt.green, fg = plt.bg_dark1 },
              -- NeoTree colors
              NeoTreeGitAdded = git.added,
              NeoTreeGitConflict = git.conflict,
              NeoTreeGitDeleted = git.deleted,
              NeoTreeGitModified = git.modified,
              NeoTreeDotFile = { fg = plt.comment },
              -- Oil git colors
              OilGitAdded = git.added,
              OilGitModified = git.modified,
              OilGitRenamed = git.renamed,
              OilGitUntracked = git.untracked,
              OilGitIgnored = git.ignored,
              -- Dart
              DartPickLabel = { fg = plt.blue, bold = true },
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
      end
    end,
  },
}
