return {
  -- ==============================================================================================
  -- Tokyonight
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    dependencies = {
      -- 'lukas-reineke/indent-blankline.nvim',
    },
    opts = {
      style = 'moon',
      styles = {
        comments = { italic = false },
        functions = { italic = false },
      },
    },
    config = function(_, opts)
      local palette = require('tokyonight.colors.' .. opts.style)
      require('tokyonight').setup(opts)

      local hl = require 'phaezer.config.highlights'
      hl.rainbow.set_hl_groups('#0058ff', palette.bg, palette.fg, 0.3, 0.5)
      -- local function highlights()
      --   rb_hl.create_rainbow_hls(palette.bg, 0.3)
      --   vim.api.nvim_set_hl(0, 'IblScope', { fg = '#7dcfff', bold = false, force = true })
      -- end
      -- highlights()

      -- require('ibl').setup {
      --   indent = { highlight = rb_hl.names },
      --   scope = { highlight = 'IblScope' }, -- use mini.indentscope instead
      -- }

      -- local hooks = require 'ibl.hooks'
      -- hooks.register(hooks.type.HIGHLIGHT_SETUP, highlights)
      -- vim.cmd.colorscheme 'tokyonight'
    end,
  },
  -- / Tokyonight

  -- ==============================================================================================
  -- kanagawa
  -- SRC: https://github.com/rebelot/kanagawa.nvim
  {
    'rebelot/kanagawa.nvim',
    enabled = false,
    lazy = false,
    priority = 1000,
    opts = {
      theme = 'dragon',
      compile = false, -- enable compiling the colorscheme
      undercurl = true,
      commentStyle = { italic = true },
      functionStyle = {},
      keywordStyle = { italic = true },
      statementStyle = { bold = true },
      typeStyle = {},
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
    config = function(_, opts)
      opts.background = {
        dark = opts.theme,
        light = 'lotus',
      }
      require('kanagawa').setup(opts)
    end,
  }, -- / kanagawa

  -- ==============================================================================================
  -- rose-pine
  -- SRC: https://github.com/rose-pine/neovim
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
