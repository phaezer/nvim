local colors = require 'core.colors'

local M = {}

-- local rainbow_colors = {}

local rainbow_highlight_groups = {}

local rainbow_group_prefix = 'RainBow_'

M.std_rainbow_colors = colors.generate_rainbow_from_hex(7, '#0058ff')

-- local rainbow_base_colors = util.generate_rainbow_from_hex(7, '#0058ff')

---@alias IndentRainbowKind 'dim' | 'bright'

-- get the highlight group prefixes
---@param kind IndentRainbowKind
---@return string[] names of the rainbow indent highlight groups
function M.rainbow_indent_names(kind)
  -- assert(#rainbow_colors > 0, 'rainbow_colors must not be empty')
  assert(kind == 'dim' or kind == 'bright', 'kind must be "dim" or "bright"')
  assert(rainbow_highlight_groups['indent'] ~= nil, 'rainbow indents must be set first')
  return rainbow_highlight_groups['indent'][kind] --[[@as string[] ]]
end

-- function M.set_rainbow_colors(colors)
--   assert(type(colors) == 'table', 'colors must be a table')
--   assert(#colors > 0, 'colors must not be empty')
--   rainbow_colors = colors
-- end

-- function M.set_rainbow_colors_auto(cnt, base_hex, reverse)
--   cnt = cnt or 7
--   base_hex = base_hex or '#0058ff'
--   reverse = reverse or false
--   rainbow_colors = colors.generate_rainbow_from_hex(cnt, base_hex, reverse)
-- end

-- Set the rainbow indent colors
---@param dim_colors string[]
---@param bright_colors string[]
function M.set_rainbow_indents(dim_colors, bright_colors)
  -- clear the 0th group, 0th group should be empty / transparent
  rainbow_highlight_groups['indent'] = {
    dim = { rainbow_group_prefix .. 'Dm' },
    bright = { rainbow_group_prefix .. 'Br' },
  }

  vim.api.nvim_set_hl(0, rainbow_highlight_groups.indent.dim[1] .. '0', { force = true })
  vim.api.nvim_set_hl(0, rainbow_highlight_groups.indent.bright[1] .. '0', { force = true })

  if dim_colors then
    for i, v in ipairs(dim_colors) do
      local group = rainbow_group_prefix .. 'Dm' .. i
      rainbow_highlight_groups.indent.dim[i + 1] = group
      vim.api.nvim_set_hl(0, group, { fg = v, force = true })
    end
  end

  if bright_colors then
    for i, v in ipairs(bright_colors) do
      local group = rainbow_group_prefix .. 'Br' .. i
      rainbow_highlight_groups.indent.bright[i + 1] = group
      vim.api.nvim_set_hl(0, group, { fg = v, force = true })
    end
  end
end

---@param rainbow_colors string[] list of hex color strings
---@param bg string background color hex string
---@param fg string foreground color hex string
---@param bg_alpha number? alpha value for blending the background color (default: 0.5)
---@param fg_alpha number? alpha value for blending the foreground color (default: 0.5)
---@return nil
function M.set_blended_rainbow_indents(rainbow_colors, bg, fg, bg_alpha, fg_alpha)
  local rb_dm, rb_br = {}, {}
  for i, v in ipairs(rainbow_colors) do
    rb_dm[i] = colors.blend(v, bg_alpha or 0.5, bg)
    rb_br[i] = colors.blend(v, fg_alpha or 0.5, fg)
  end
  M.set_rainbow_indents(rb_dm, rb_br)
end

-- function M.set_blended_rainbow_indent(bg, bg_alpha, fg, fg_alpha)
--   assert(#rainbow_colors > 0, 'rainbow_colors must not be empty')
--   -- clear the 0th group, 0th group should be empty / transparent
--   vim.api.nvim_set_hl(0, prefixes.rainbow_indent.dim .. '0', { force = true })
--   vim.api.nvim_set_hl(0, prefixes.rainbow_indent.bright .. '0', { force = true })

--   for i, v in ipairs(rainbow_colors) do
--     vim.api.nvim_set_hl(0, prefixes.rainbow_indent.dim .. i, { fg = colors.blend(v, bg_alpha, bg), force = true })
--     vim.api.nvim_set_hl(0, prefixes.rainbow_indent.bright .. i, { fg = colors.blend(v, fg_alpha, fg), force = true })
--   end
-- end

-- function M.set_rainbow_indent(bg_alpha, fg_alpha)
--   assert(#rainbow_colors > 0, 'rainbow_colors must not be empty')

--   for i, v in ipairs(rainbow_colors) do
--     vim.api.nvim_set_hl(0, prefixes.rainbow_indent.dim .. i, { fg = colors.blend(v, bg_alpha, bg), force = true })
--     vim.api.nvim_set_hl(0, prefixes.rainbow_indent.bright .. i, { fg = colors.blend(v, fg_alpha, fg), force = true })
--   end
-- end

return M
