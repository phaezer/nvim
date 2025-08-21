-- local api = vim.api
local hl = require 'phaezer.config.highlights'
-- local rb = hl.rainbow
-- local function colorscheme_cmd(pattern, callback)
--   api.nvim_create_autocmd('ColorScheme', {
--     pattern = pattern,
--     callback = callback,
--   })
-- end

return {
  -- ==============================================================================================
  -- Tokyonight
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      style = 'moon',
      styles = {
        comments = { italic = false },
        functions = { italic = false },
      },
    },
    init = function()
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
            },
          }
        end)
      end
    end,
  },
  -- / Tokyonight

  -- ==============================================================================================
  -- kanagawa
  {
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
        local palette = require('kanagawa.colors').palette
        return {
          rainbow = {
            -- base = '#0058ff',
            bg = palette.sumiInk3,
            fg = palette.fujiWhite,
          },
          groups = {
            BufferlineActive = { fg = palette.waveRed, bg = palette.sumiInk4, bold = true },
            BufferlineInactive = { fg = palette.fujiGray, bg = palette.sumiInk3 },
            -- NeoTree colors
            NeoTreeGitAdded = { fg = palette.springGreen },
            NeoTreeGitConflict = { fg = palette.samuraiRed },
            NeoTreeGitDeleted = { fg = palette.waveRed },
            NeoTreeGitModified = { fg = palette.crystalBlue },
          },
        }
      end)
    end,
  }, -- / kanagawa

  -- ==============================================================================================
  -- rose-pine
  {
    'rose-pine/neovim',
    enabled = false,
    name = 'rose-pine',
    lazy = false,
    priority = 1000,
    opts = {
      variant = 'moon',
    },
  }, -- / rose-pine
}
