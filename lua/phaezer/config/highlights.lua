local colors = require 'phaezer.core.colors'

local M = {}

-- local hl = require 'phaezer.config.highlights'
M.rainbow = {
  count = 7,
  names = {
    dm = {},
    br = {},
  },
  bright_names = {},
}

-- populate the names
for i = 1, M.rainbow.count do
  table.insert(M.rainbow.names.dm, 'RainbowDim' .. i)
  table.insert(M.rainbow.names.br, 'RainbowBright' .. i)
end

function M.rainbow.set_hl_groups(base, bg, fg, bg_alpha, fg_alpha)
  local rb_colors = colors.generate_rainbow_from_hex(M.rainbow.count, base)
  for i, v in ipairs(rb_colors) do
    vim.api.nvim_set_hl(
      0,
      'RainbowDim' .. i,
      { fg = colors.blend(v, bg_alpha or 0.5, bg), bold = false }
    )
    vim.api.nvim_set_hl(
      0,
      'RainbowBright' .. i,
      { fg = colors.blend(v, fg_alpha or 0.5, fg), bold = false }
    )
  end
end

-- create default HL group
-- M.rainbow.set_hl_groups('#0058ff', '#000000', '#ffffff', 0.25, 0.5)

return M
