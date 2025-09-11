-- cSpell:disable
--[[
Lua implementation of HSLuv and HPLuv color spaces
Homepage: http://www.hsluv.org/

Copyright (C) 2019 Alexei Boronine

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
associated documentation files (the "Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the
following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial
portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT
LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN
NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
]]

HSLuv = {}

local hexChars = '0123456789abcdef'

local distance_line_from_origin = function(line)
  return math.abs(line.intercept) / math.sqrt((line.slope ^ 2) + 1)
end

local length_of_ray_until_intersect = function(theta, line)
  return line.intercept / (math.sin(theta) - line.slope * math.cos(theta))
end

HSLuv.get_bounds = function(l)
  local result = {}
  local sub2
  local sub1 = ((l + 16) ^ 3) / 1560896
  if sub1 > HSLuv.epsilon then
    sub2 = sub1
  else
    sub2 = l / HSLuv.kappa
  end

  for i = 1, 3 do
    local m1 = HSLuv.m[i][1]
    local m2 = HSLuv.m[i][2]
    local m3 = HSLuv.m[i][3]

    for t = 0, 1 do
      local top1 = (284517 * m1 - 94839 * m3) * sub2
      local top2 = (838422 * m3 + 769860 * m2 + 731718 * m1) * l * sub2 - 769860 * t * l
      local bottom = (632260 * m3 - 126452 * m2) * sub2 + 126452 * t
      table.insert(result, {
        slope = top1 / bottom,
        intercept = top2 / bottom,
      })
    end
  end
  return result
end

HSLuv.max_safe_chroma_for_l = function(l)
  local bounds = HSLuv.get_bounds(l)
  local min = 1.7976931348623157e+308

  for i = 1, 6 do
    local length = distance_line_from_origin(bounds[i])
    if length >= 0 then
      min = math.min(min, length)
    end
  end
  return min
end

HSLuv.max_safe_chroma_for_lh = function(l, h)
  local hrad = h / 360 * math.pi * 2
  local bounds = HSLuv.get_bounds(l)
  local min = 1.7976931348623157e+308

  for i = 1, 6 do
    local bound = bounds[i]
    local length = length_of_ray_until_intersect(hrad, bound)
    if length >= 0 then
      min = math.min(min, length)
    end
  end
  return min
end

HSLuv.dot_product = function(a, b)
  local sum = 0
  for i = 1, 3 do
    sum = sum + a[i] * b[i]
  end
  return sum
end

HSLuv.from_linear = function(c)
  if c <= 0.0031308 then
    return 12.92 * c
  else
    return 1.055 * (c ^ 0.416666666666666685) - 0.055
  end
end

HSLuv.to_linear = function(c)
  if c > 0.04045 then
    return ((c + 0.055) / 1.055) ^ 2.4
  else
    return c / 12.92
  end
end

HSLuv.xyz_to_rgb = function(tuple)
  return {
    HSLuv.from_linear(HSLuv.dot_product(HSLuv.m[1], tuple)),
    HSLuv.from_linear(HSLuv.dot_product(HSLuv.m[2], tuple)),
    HSLuv.from_linear(HSLuv.dot_product(HSLuv.m[3], tuple)),
  }
end

HSLuv.rgb_to_xyz = function(tuple)
  local rgbl = {
    HSLuv.to_linear(tuple[1]),
    HSLuv.to_linear(tuple[2]),
    HSLuv.to_linear(tuple[3]),
  }
  return {
    HSLuv.dot_product(HSLuv.minv[1], rgbl),
    HSLuv.dot_product(HSLuv.minv[2], rgbl),
    HSLuv.dot_product(HSLuv.minv[3], rgbl),
  }
end

HSLuv.y_to_l = function(Y)
  if Y <= HSLuv.epsilon then
    return Y / HSLuv.refY * HSLuv.kappa
  else
    return 116 * ((Y / HSLuv.refY) ^ 0.333333333333333315) - 16
  end
end

HSLuv.l_to_y = function(L)
  if L <= 8 then
    return HSLuv.refY * L / HSLuv.kappa
  else
    return HSLuv.refY * (((L + 16) / 116) ^ 3)
  end
end

HSLuv.xyz_to_luv = function(tuple)
  local X = tuple[1]
  local Y = tuple[2]
  local divider = X + 15 * Y + 3 * tuple[3]
  local varU = 4 * X
  local varV = 9 * Y
  if divider ~= 0 then
    varU = varU / divider
    varV = varV / divider
  else
    varU = 0
    varV = 0
  end
  local L = HSLuv.y_to_l(Y)
  if L == 0 then
    return { 0, 0, 0 }
  end
  return { L, 13 * L * (varU - HSLuv.refU), 13 * L * (varV - HSLuv.refV) }
end

HSLuv.luv_to_xyz = function(tuple)
  local L = tuple[1]
  local U = tuple[2]
  local V = tuple[3]
  if L == 0 then
    return { 0, 0, 0 }
  end
  local varU = U / (13 * L) + HSLuv.refU
  local varV = V / (13 * L) + HSLuv.refV
  local Y = HSLuv.l_to_y(L)
  local X = 0 - (9 * Y * varU) / (((varU - 4) * varV) - varU * varV)
  return { X, Y, (9 * Y - 15 * varV * Y - varV * X) / (3 * varV) }
end

HSLuv.luv_to_lch = function(tuple)
  local L = tuple[1]
  local U = tuple[2]
  local V = tuple[3]
  local C = math.sqrt(U * U + V * V)
  local H
  if C < 0.00000001 then
    H = 0
  else
    H = math.atan2(V, U) * 180.0 / 3.1415926535897932
    if H < 0 then
      H = 360 + H
    end
  end
  return { L, C, H }
end

HSLuv.lch_to_luv = function(tuple)
  local L = tuple[1]
  local C = tuple[2]
  local Hrad = tuple[3] / 360.0 * 2 * math.pi
  return { L, math.cos(Hrad) * C, math.sin(Hrad) * C }
end

HSLuv.hsluv_to_lch = function(tuple)
  local H = tuple[1]
  local S = tuple[2]
  local L = tuple[3]
  if L > 99.9999999 then
    return { 100, 0, H }
  end
  if L < 0.00000001 then
    return { 0, 0, H }
  end
  return { L, HSLuv.max_safe_chroma_for_lh(L, H) / 100 * S, H }
end

HSLuv.lch_to_hsluv = function(tuple)
  local L = tuple[1]
  local C = tuple[2]
  local H = tuple[3]
  local max_chroma = HSLuv.max_safe_chroma_for_lh(L, H)
  if L > 99.9999999 then
    return { H, 0, 100 }
  end
  if L < 0.00000001 then
    return { H, 0, 0 }
  end

  return { H, C / max_chroma * 100, L }
end

HSLuv.hpluv_to_lch = function(tuple)
  local H = tuple[1]
  local S = tuple[2]
  local L = tuple[3]
  if L > 99.9999999 then
    return { 100, 0, H }
  end
  if L < 0.00000001 then
    return { 0, 0, H }
  end
  return { L, HSLuv.max_safe_chroma_for_l(L) / 100 * S, H }
end

HSLuv.lch_to_hpluv = function(tuple)
  local L = tuple[1]
  local C = tuple[2]
  local H = tuple[3]
  if L > 99.9999999 then
    return { H, 0, 100 }
  end
  if L < 0.00000001 then
    return { H, 0, 0 }
  end
  return { H, C / HSLuv.max_safe_chroma_for_l(L) * 100, L }
end

HSLuv.rgb_to_hex = function(tuple)
  local h = '#'
  for i = 1, 3 do
    local c = math.floor(tuple[i] * 255 + 0.5)
    local digit2 = math.fmod(c, 16)
    local x = (c - digit2) / 16
    local digit1 = math.floor(x)
    h = h .. string.sub(hexChars, digit1 + 1, digit1 + 1)
    h = h .. string.sub(hexChars, digit2 + 1, digit2 + 1)
  end
  return h
end

HSLuv.hex_to_rgb = function(hex)
  hex = string.lower(hex)
  local ret = {}
  for i = 0, 2 do
    local char1 = string.sub(hex, i * 2 + 2, i * 2 + 2)
    local char2 = string.sub(hex, i * 2 + 3, i * 2 + 3)
    local digit1 = string.find(hexChars, char1) - 1
    local digit2 = string.find(hexChars, char2) - 1
    ret[i + 1] = (digit1 * 16 + digit2) / 255.0
  end
  return ret
end

HSLuv.lch_to_rgb = function(tuple)
  return HSLuv.xyz_to_rgb(HSLuv.luv_to_xyz(HSLuv.lch_to_luv(tuple)))
end

HSLuv.rgb_to_lch = function(tuple)
  return HSLuv.luv_to_lch(HSLuv.xyz_to_luv(HSLuv.rgb_to_xyz(tuple)))
end

HSLuv.hsluv_to_rgb = function(tuple)
  return HSLuv.lch_to_rgb(HSLuv.hsluv_to_lch(tuple))
end

HSLuv.rgb_to_hsluv = function(tuple)
  return HSLuv.lch_to_hsluv(HSLuv.rgb_to_lch(tuple))
end

HSLuv.hpluv_to_rgb = function(tuple)
  return HSLuv.lch_to_rgb(HSLuv.hpluv_to_lch(tuple))
end

HSLuv.rgb_to_hpluv = function(tuple)
  return HSLuv.lch_to_hpluv(HSLuv.rgb_to_lch(tuple))
end

HSLuv.hsluv_to_hex = function(tuple)
  return HSLuv.rgb_to_hex(HSLuv.hsluv_to_rgb(tuple))
end

HSLuv.hpluv_to_hex = function(tuple)
  return HSLuv.rgb_to_hex(HSLuv.hpluv_to_rgb(tuple))
end

HSLuv.hex_to_hsluv = function(s)
  return HSLuv.rgb_to_hsluv(HSLuv.hex_to_rgb(s))
end

HSLuv.hex_to_hpluv = function(s)
  return HSLuv.rgb_to_hpluv(HSLuv.hex_to_rgb(s))
end

HSLuv.m = {
  { 3.240969941904521, -1.537383177570093, -0.498610760293 },
  { -0.96924363628087, 1.87596750150772, 0.041555057407175 },
  { 0.055630079696993, -0.20397695888897, 1.056971514242878 },
}
HSLuv.minv = {
  { 0.41239079926595, 0.35758433938387, 0.18048078840183 },
  { 0.21263900587151, 0.71516867876775, 0.072192315360733 },
  { 0.019330818715591, 0.11919477979462, 0.95053215224966 },
}
HSLuv.refY = 1.0
HSLuv.refU = 0.19783000664283
HSLuv.refV = 0.46831999493879
HSLuv.kappa = 903.2962962
HSLuv.epsilon = 0.0088564516

return HSLuv

