local colors = require 'phaezer.core.colors'

local M = {}

-- local hl = require 'phaezer.config.highlights'
M.rainbow = {
  count = vim.g.hl_rainbow_count or 6,
  names = {
    dm = {},
    br = {},
  },
}

-- populate the names
for i = 1, M.rainbow.count do
  table.insert(M.rainbow.names.dm, 'RainbowDim' .. i)
  table.insert(M.rainbow.names.br, 'RainbowBright' .. i)
end

function M.rainbow.set_hl_groups(opts)
  local _opts = vim.tbl_deep_extend('force', {
    base = '#0058ff',
    bg = '#000000',
    fg = '#ffffff',
    bg_alpha = 0.5,
    fg_alpha = 0.5,
    dim = nil,
    br = nil,
  }, opts, vim.g.hl_rainbow or {})

  if _opts.dim ~= nil then
    for i, v in ipairs(_opts.dim) do
      vim.api.nvim_set_hl(0, 'RainbowDim' .. i, { fg = v })
    end
  end

  if _opts.br ~= nil then
    for i, v in ipairs(_opts.br) do
      vim.api.nvim_set_hl(0, 'RainbowBright' .. i, { fg = v })
    end
  end

  if _opts.dim == nil and _opts.bg == nil then
    return
  end

  local rb_colors = colors.generate_rainbow_from_hex(M.rainbow.count, _opts.base)

  if _opts.dim == nil then
    for i, v in ipairs(rb_colors) do
      vim.api.nvim_set_hl(
        0,
        'RainbowDim' .. i,
        { fg = colors.blend(v, _opts.bg_alpha or 0.3, _opts.bg), bold = false }
      )
    end
  end
  if _opts.br == nil then
    for i, v in ipairs(rb_colors) do
      vim.api.nvim_set_hl(
        0,
        'RainbowBright' .. i,
        { fg = colors.blend(v, _opts.fg_alpha or 0.5, _opts.fg), bold = false }
      )
    end
  end
end

local function maybe_set_hl(group, v)
  if v ~= nil then
    vim.api.nvim_set_hl(0, group, v)
  end
end

local function maybe_set_hls(groups)
  for group, value in pairs(groups) do
    maybe_set_hl(group, value)
  end
end

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

-- create default HL group
-- M.rainbow.set_hl_groups('#0058ff', '#000000', '#ffffff', 0.25, 0.5)

return M
