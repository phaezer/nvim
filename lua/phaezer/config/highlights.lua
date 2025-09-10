local colors = require 'phaezer.core.colors'
local util = require 'phaezer.core.util'

local M = {}

M.rainbow = {
  count = vim.g.hl_rainbow_count or 6,
  names = {
    indent = {},
    delimiters = {},
    headlines = {},
    org_ts_headlines = {},
  },
  prefix = {
    indent = 'RainbowIndent',
    delimiter = 'RainbowDelimiter',
    headline = 'Healine',
    org_ts_headlines = '@OrgTSHeadlineLevel',
  },
}

local rb = M.rainbow

-- populate the names
for i = 1, M.rainbow.count do
  table.insert(rb.names.indent, rb.prefix.indent .. i)
  table.insert(rb.names.delimiters, rb.prefix.delimiter .. i)
  table.insert(rb.names.headlines, rb.prefix.headline .. i)
  table.insert(rb.names.headlines, rb.prefix.org_ts_headlines .. i)
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
    vim.api.nvim_set_hl(
      0,
      rb.prefix.indent .. i,
      { fg = colors.blend(v, _opts.bg_alpha, _opts.bg), bold = false }
    )
  end
  for i, v in ipairs(rb_colors) do
    vim.api.nvim_set_hl(
      0,
      rb.prefix.delimiter .. i,
      { fg = colors.blend(v, _opts.fg_alpha, _opts.fg), bold = false }
    )
  end

  -- set hl for headlines
  for i = 1, M.rainbow.count do
    local dm = rb.prefix.indent .. i
    local br = rb.prefix.delimiter .. i
    vim.api.nvim_set_hl(0, rb.prefix.headline .. i, { fg = util.color(br), bg = util.color(dm) })
    vim.api.nvim_set_hl(
      0,
      rb.prefix.org_ts_headlines .. i,
      { fg = util.color(br), bg = util.color(dm) }
    )
  end
end

---sets a highlight group only if value isn't nil
---@param group string
---@param v table | nil
local function maybe_set_hl(group, v)
  if v ~= nil then
    vim.api.nvim_set_hl(0, group, v)
  end
end

---sets a list of hightlight groups only if values are not nil
---@param groups table
local function maybe_set_hls(groups)
  for group, value in pairs(groups) do
    maybe_set_hl(group, value)
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
      maybe_set_hls(opts.groups)
    end,
  })
end

-- add colorscheme tweaks
vim.api.nvim_create_autocmd('ColorScheme', {
  callback = function()
    for _, v in pairs {
      'DiagnosticVirtualTextHint',
      'DiagnosticVirtualTextWarn',
      'DiagnosticVirtualTextError',
      'DiagnosticVirtualTextInfo',
    } do
      vim.api.nvim_set_hl(0, v, { fg = util.color(v), bg = 'NONE' })
    end

    for _, v in pairs {
      'DiagnosticUnderlineOk',
      'DiagnosticUnderlineHint',
      'DiagnosticUnderlineWarn',
      'DiagnosticUnderlineError',
      'DiagnosticUnderlineInfo',
    } do
      vim.api.nvim_set_hl(0, v, {
        fg = 'NONE',
        bg = 'NONE',
        sp = util.color(v, 'sp'),
        undercurl = true,
        cterm = { undercurl = true },
      })
    end

    -- make sure unnecessary / unused code is underlined but keeps sytax high
    vim.api.nvim_set_hl(
      0,
      'DiagnosticUnnecessary',
      { sp = util.color 'Comment', undercurl = true, cterm = { undercurl = true } }
    )

    -- set the gitsigns inline highlights
    vim.api.nvim_set_hl(0, 'GitSignsDeleteInline', { bg = util.color 'DiffDelete' })
    vim.api.nvim_set_hl(0, 'GitSignsAddInline', { bg = util.color 'DiffAdd' })
    vim.api.nvim_set_hl(0, 'GitSignsChangeInline', { bg = util.color 'DiffChange' })

    local normal_bg = util.color('Normal', 'bg') or '#000000'
    local normal_fg = util.color('Normal', 'fg') or '#ffffff'

    -- adjust the flash hl groups
    vim.api.nvim_set_hl(0, 'FlashBackdrop', { fg = colors.blend(normal_fg, 0.7, normal_bg) })
  end,
})

-- create default HL group
-- M.rainbow.set_hl_groups('#0058ff', '#000000', '#ffffff', 0.25, 0.5)

return M
