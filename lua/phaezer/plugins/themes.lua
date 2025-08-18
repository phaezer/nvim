-- local hl = require 'phaezer.config.highlights'
local colors = require 'phaezer.core.colors'
local rainbow_colors = colors.generate_rainbow_from_hex(7, '#0058ff')
local rb_hl = {
  names = { 'Rainbow0' },
}

-- populate the names
for i = 1, #rainbow_colors do
  table.insert(rb_hl.names, 'Rainbow' .. i)
end

function rb_hl.create_rainbow_hls(base, alpha)
  vim.api.nvim_set_hl(0, 'Rainbow0', { fg = base, bold = false, force = true }) -- 0 is transparent
  for i, v in ipairs(rainbow_colors) do
    vim.api.nvim_set_hl(0, 'Rainbow' .. i, { fg = colors.blend(v, alpha or 0.5, base), bold = false, force = true })
  end
end

return {
  -- ==============================================================================================
  -- Tokyonight
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    dependencies = {
      'lukas-reineke/indent-blankline.nvim',
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
      vim.cmd.colorscheme 'tokyonight'
      local function highlights()
        rb_hl.create_rainbow_hls(palette.bg, 0.3)
        vim.api.nvim_set_hl(0, 'IblScope', { fg = '#7dcfff', bold = false, force = true })
      end
      highlights()

      require('ibl').setup {
        indent = { highlight = rb_hl.names },
        scope = { highlight = 'IblScope' }, -- use mini.indentscope instead
      }

      local hooks = require 'ibl.hooks'
      hooks.register(hooks.type.HIGHLIGHT_SETUP, highlights)
    end,
  },
  -- / Tokyonight
  -- -----------------------------------------------------------------------------------------------

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
  -- -----------------------------------------------------------------------------------------------

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
  -- -----------------------------------------------------------------------------------------------
}
