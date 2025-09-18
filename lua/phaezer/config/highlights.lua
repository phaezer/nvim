local colors = require 'phaezer.core.colors'
local util = require 'phaezer.core.util'
local set_hl = vim.api.nvim_set_hl

local M = {}

M.rainbow = {
  count = vim.g.hl_rainbow_count or 6,
  names = {
    indent = {},
    delimiters = {},
  },
}

local rb = M.rainbow

-- populate the names
for i = 1, M.rainbow.count do
  table.insert(rb.names.indent, 'RainbowIndent' .. i)
  table.insert(rb.names.delimiters, 'RainbowDelimiter' .. i)
end

---@alias rainbowHighlightOpts {base: string | nil, bg: string | nil, fg: string | nil, bg_alpha: number | nil, fg_alpha: number | nil}

---sets rainbow highlight groups for indents, delimiters, headlines, etc.
---@param opts rainbowHighlightOpts
function M.rainbow.set_hl_groups(opts)
  local _opts = vim.tbl_deep_extend('force', {
    base = '#0058ff',
    bg = '#000000',
    fg = '#ffffff',
    bg_alpha = 0.2,
    fg_alpha = 0.2,
  }, opts, vim.g.hl_rainbow or {})

  local rb_colors = colors.generate_rainbow_from_hex(M.rainbow.count, _opts.base)

  for i, v in ipairs(rb_colors) do
    local dim = colors.blend(v, _opts.bg_alpha, _opts.bg)
    local bright = colors.blend(v, _opts.fg_alpha, _opts.fg)

    set_hl(0, 'RainbowIndent' .. i, { fg = dim, bold = false })
    set_hl(0, 'RainbowDelimiter' .. i, { fg = bright, bold = false })
    set_hl(0, 'Headline' .. i, { fg = bright })
    set_hl(0, '@OrgTSHeadlineLevel' .. i, { fg = bright })
    -- markview hls start at 0
    set_hl(0, 'MarkviewPalette' .. i - 1, { bg = bright, fg = _opts.bg })
    set_hl(0, 'MarkviewPalette' .. i - 1 .. 'Sign', { fg = bright })
    set_hl(0, 'MarkviewPalette' .. i - 1 .. 'Fg', { fg = bright })
    set_hl(0, 'MarkviewPalette' .. i - 1 .. 'Bg', { fg = dim })
  end
  -- set markview hls
  -- SEE: https://github.com/OXY2DEV/markview.nvim/wiki#-highlight-groups

  local mv_rb = colors.generate_rainbow_from_hex(7, _opts.base)
  for i, v in ipairs(mv_rb) do
    -- markview hls start at 0
    local idx = i - 1
    local dim = colors.blend(v, _opts.bg_alpha, _opts.bg)
    local bright = colors.blend(v, _opts.fg_alpha, _opts.fg)
    set_hl(0, 'MarkviewPalette' .. idx, { bg = bright, fg = _opts.bg })
    set_hl(0, 'MarkviewPalette' .. idx .. 'Sign', { fg = bright })
    set_hl(0, 'MarkviewPalette' .. idx .. 'Fg', { fg = bright })
    set_hl(0, 'MarkviewPalette' .. idx .. 'Bg', { fg = dim })
  end
end

---sets a highlight group only if value isn't nil
---@param group string
---@param v table | nil
local function maybe_set_hl(group, v)
  if v ~= nil then
    set_hl(0, group, v)
  end
end

---patch a theme to include additional highlight groups
---@param pattern string | string[]
---@param opts {rainbow: rainbowHighlightOpts, groups: table} | function
function M.patch_theme(pattern, opts)
  vim.api.nvim_create_autocmd('ColorScheme', {
    pattern = pattern,
    callback = function()
      if type(opts) == 'function' then
        opts = opts()
      end
      -- rainbow highlights
      M.rainbow.set_hl_groups(opts.rainbow)
      for group, value in pairs(opts.groups) do
        maybe_set_hl(group, value)
      end
    end,
  })
end

-- add colorscheme tweaks
vim.api.nvim_create_autocmd('ColorScheme', {
  callback = function()
    local normal_bg = util.color('Normal', 'bg') or '#000000'
    local normal_fg = util.color('Normal', 'fg') or '#ffffff'
    for _, v in pairs {
      'DiagnosticVirtualTextHint',
      'DiagnosticVirtualTextWarn',
      'DiagnosticVirtualTextError',
      'DiagnosticVirtualTextInfo',
    } do
      set_hl(0, v, { fg = util.color(v), bg = 'NONE' })
    end

    for _, v in pairs {
      'DiagnosticUnderlineWarn',
      'DiagnosticUnderlineError',
    } do
      set_hl(0, v, {
        fg = 'NONE',
        bg = 'NONE',
        sp = util.color(v, 'sp'),
        undercurl = true,
        cterm = { undercurl = true },
      })
    end

    for _, v in pairs {
      'DiagnosticUnderlineOk',
      'DiagnosticUnderlineHint',
      'DiagnosticUnderlineInfo',
    } do
      set_hl(0, v, {
        fg = 'NONE',
        bg = 'NONE',
        sp = colors.blend(util.color(v, 'sp'), 0.75, normal_bg),
        underdotted = true,
        cterm = { underdotted = true },
      })
    end

    set_hl(0, 'DiagnosticUnnecessary', {
      sp = colors.blend(normal_fg, 0.1, normal_bg),
      underline = true,
      cterm = { underline = true },
    })

    -- set the gitsigns inline highlights
    set_hl(0, 'GitSignsDeleteInline', { bg = util.color 'DiffDelete' })
    set_hl(0, 'GitSignsAddInline', { bg = util.color 'DiffAdd' })
    set_hl(0, 'GitSignsChangeInline', { bg = util.color 'DiffChange' })

    -- set the visual whitespace hl
    set_hl(0, 'VisualWhitespace', { fg = util.color('Comment', 'fg'), bg = 'NONE' })
  end,
})

return M
