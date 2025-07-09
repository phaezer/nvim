local hsluv = require 'lua.core.lib.hsluv'

local M = {}

---@alias color_tuple { [0]: number, [1]: number, [2]: number }
---@alias color_type 'hex' | 'rgb' | 'Color'

-- blend two color channel values
---@param a number color channel value (0-255)
---@param alpha number number between 0 and 1.0. If 1, returns a. If 0, returns b.
---@param b number color channel value (0-255)
---@return number blended color channel value (0-255)
M.blend_channel = function(a, alpha, b)
  local v = (alpha * a) + ((1 - alpha) * b)
  return math.floor(math.min(math.max(0, v), 255) + 0.5)
end

-- blend two colors
---@param hex_a string the first RGB color
---@param alpha number alpha value between 0 and 1 (default: 0). If
---@param hex_b string the second RGB color
---@return string hex color string
M.blend = function(hex_a, alpha, hex_b)
  local rgb_a = hsluv.hex_to_rgb(hex_a)
  local rgb_b = hsluv.hex_to_rgb(hex_b)
  local blended = {}
  for i = 1, 3 do
    blended[i] = M.blend_channel(rgb_a[i], alpha, rgb_b[i])
  end
  return hsluv.rgb_to_hex(blended)
end

-- Blend a list of colors with a base color
---@param colors table<string> list of hex color strings to blend
---@param alpha number alpha value between 0 and 1 (default: 0)
---@param base string base color to blend with
---@return table<string> list of blended hex color strings
M.blend_all = function(colors, alpha, base)
  local blended = {}
  for i, v in ipairs(colors) do
    blended[i] = M.blend(v, alpha, base)
  end
  return blended
end

-- Adjust the lightness of a color
M.adjust_lightness = function(hex, alpha)
  local tpl = hsluv.hex_to_hsluv(hex)
  tpl[3] = math.max(0, math.min(100, tpl[3] + alpha)) -- Darken the lightness by alpha
  return hsluv.hsluv_to_hex(tpl)
end

-- Adjust the saturation of a color
M.adjust_saturation = function(hex, alpha)
  local tpl = hsluv.hex_to_hsluv(hex)
  tpl[2] = math.max(0, math.min(100, tpl[2] + alpha)) -- Adjust the saturation by alpha
  return hsluv.hsluv_to_hex(tpl)
end

-- Adjust the hue of a color
M.adjust_hue = function(hex, alpha)
  local tpl = hsluv.hex_to_hsluv(hex)
  tpl[1] = (tpl[1] + alpha) % 360 -- Adjust the hue by alpha
  return hsluv.hsluv_to_hex(tpl)
end

-- Adjust the hue, saturation, and lightness of a color
---@param hex string hex color string
---@param alphas {H: number, S: number, L: number} HSL adjustment values
M.adjust_hsl = function(hex, alphas)
  local tpl = hsluv.hex_to_hsluv(hex)
  if alphas.H then -- hue
    tpl[1] = (tpl[1] + alphas.H) % 360 -- Adjust the hue by hsl.H
  end
  if alphas.S then -- saturation
    tpl[2] = math.max(0, math.min(100, tpl[2] + alphas.S)) -- Adjust the saturation by hsl.S
  end
  if alphas.L then -- lightness
    tpl[3] = math.max(0, math.min(100, tpl[3] + alphas.L)) -- Adjust the lightness by hsl.L
  end
  return hsluv.hsluv_to_hex(tpl)
end

-- Adjust the hue, saturation, and lightness of a list of colors
---@param colors table<string> list of hex color strings to adjust
---@param alphas {H: number, S: number, L: number} HSL adjustment values
---@return table<string> list of adjusted hex color strings
M.adjust_all = function(colors, alphas)
  local adjusted = {}
  for i, v in ipairs(colors) do
    adjusted[i] = M.adjust_hsl(v, alphas)
  end
  return adjusted
end

-- Generate a rainbow of colors
---@param count number of colors to generate
---@param H number hue (0-360)
---@param S number saturation (0-100)
---@param L number lightness (0-100)
---@param reverse boolean? if true, generate colors in reverse order
---@return table of hex color strings
M.generate_rainbow = function(count, H, S, L, reverse)
  H = H or 0
  S = S or 100
  L = L or 50
  local hue_step = 360 / (count + 1)
  local colors = {
    [1] = hsluv.hsluv_to_hex { H, S, L },
  }
  local step_dir = reverse and -1 or 1
  for i = 2, count do
    local hue = (H + (i * hue_step * step_dir)) % 360
    local color = hsluv.hsluv_to_hex { hue, S, L }
    colors[i] = color
  end
  return colors
end

-- Generate a rainbow of colors from a hex color
---@param count number of colors to generate
---@param hex string hex color string
---@param reverse boolean? if true, generate colors in reverse order
---@return table of hex color strings
M.generate_rainbow_from_hex = function(count, hex, reverse)
  local HSL = hsluv.hex_to_hsluv(hex)
  return M.generate_rainbow(count, HSL[1], HSL[2], HSL[3], reverse)
end

return M
