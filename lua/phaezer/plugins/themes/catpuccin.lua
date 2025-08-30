local hl = require 'phaezer.config.highlights'

local variant = 'frappe'

return {
  'catppuccin/nvim',
  name = 'catppuccin',
  lazy = false,
  priority = 1000,
  opts = {
    flavour = variant,
    styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
      -- comments = {}, -- Change the style of comments
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
    highlight_overrides = {
      all = function(colors)
        return {
          ['@property'] = { fg = colors.sapphire },
        }
      end,
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
    local palettes = {
      catppuccin = function() return require('catppuccin.palettes.' .. variant) end,
      ['catppuccin-frappe'] = function() return require 'catppuccin.palettes.frappe' end,
      ['catppuccin-latte'] = function() return require 'catppuccin.palettes.latte' end,
      ['catppuccin-macchiato'] = function() return require 'catppuccin.palettes.macchiato' end,
      ['catppuccin-mocha'] = function() return require 'catppuccin.palettes.mocha' end,
    }

    for theme, pallete_fn in pairs(palettes) do
      hl.patch_theme(theme, function()
        local palette = pallete_fn()

        local git = {
          added = { fg = palette.green },
          confict = { fg = palette.muave },
          deleted = { fg = palette.red },
          modified = { fg = palette.blue },
          ignored = { fg = palette.subtext1 },
          untracked = { fg = palette.subtext0 },
        }

        local tabline = {
          active = { fg = palette.text, bg = palette.surface0 },
          innactive = { fg = palette.subtext1, bg = palette.base },
          label = { fg = palette.blue },
          label_modified = { fg = palette.peach },
        }

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
            NeoTreeGitAdded = git.added,
            NeoTreeGitConflict = git.confict,
            NeoTreeGitDeleted = git.deleted,
            NeoTreeGitModified = git.modified,
            -- Oil git colors
            OilGitAdded = git.added,
            OilGitModified = git.modified,
            OilGitRenamed = git.renamed,
            OilGitUntracked = git.untracked,
            OilGitIgnored = git.ignored,
            -- Dart
            DartPickLabel = { fg = tabline.label.fg, bg = tabline.active.bg, bold = true },
            DartCurrentLabel = { fg = tabline.label.fg, bg = tabline.active.bg, bold = true },
            DartVisibleLabel = { fg = tabline.label.fg, bg = tabline.innactive.bg },
            DartCurrentLabelModified = {
              fg = tabline.label_modified.fg,
              bg = tabline.active.bg,
              bold = true,
            },
            DartVisibleLabelModified = {
              fg = tabline.label_modified.fg,
              bg = tabline.innactive.bg,
              bold = true,
            },
            DartCurrent = tabline.active,
            DartVisible = tabline.innactive,
            DartCurrentModified = { fg = tabline.active.fg, bg = tabline.active.bg, italic = true },
            DartVisibleModified = {
              fg = tabline.innactive.fg,
              bg = tabline.innactive.bg,
              italic = true,
            },
          },
        }
      end)
    end
  end,
}
