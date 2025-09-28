local hl = require 'phaezer.config.highlights'

-- cSpell:words darianmorat gruvdark
return {
  'darianmorat/gruvdark.nvim',
  lazy = false,
  priority = 1000,
  opts = {
    transparent = false,
  },
  init = function()
    local palettes = require('gruvdark.colors').palettes
    local palette_map = {
      gruvdark = palettes.gruvdark,
      ['gruvdark-light'] = palettes.gruvdark_light
    }
    for name, plt in pairs(palettes) do
      hl.patch_theme(name, function()
        local dart = {
          visible = { fg = plt.grey, bg = plt.bg0 },
          current = { fg = plt.fg, bg = plt.bg2 },
          label = { fg = plt.blue, bold = true },
          modified_label = { fg = plt.orange, bold = true },
        }

        local git = {
          added = { fg = plt.diff_add },
          conflict = { fg = plt.red },
          modified = { fg = plt.diff_change },
          deleted = { fg = plt.diff_delete },
          untracked = { fg = plt.grey },
          ignored = { fg = plt.grey },
          renamed = { fg = plt.orange },
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
    end
  end,
}
