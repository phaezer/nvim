---@diagnostic disable: inject-field
-- neovide config
-- only applies when using neovide

if not vim.g.neovide then
  return
end

local g = vim.g

g.neovide_padding_right = 2
g.neovide_padding_left = 2
g.neovide_window_blurred = false

-- rendering
g.neovide_underline_stroke_scale = 0.8

-- floating windows
-- g.neovide_floating_blur_amount_x = 3.0
-- g.neovide_floating_blur_amount_y = 3.0
g.neovide_floating_shadow = true
g.neovide_floating_z_height = 20
g.neovide_light_angle_degrees = 45
g.neovide_light_radius = 5
g.neovide_floating_corner_radius = 6.0

-- input
g.neovide_hide_mouse_when_typing = true
g.neovide_input_macos_option_key_is_meta = 'only_left'

-- cursor
g.neovide_cursor_animation_length = 0.05
g.neovide_cursor_trail_size = 2
g.neovide_cursor_vfx_mode = 'pixiedust'
g.neovide_cursor_vfx_particle_lifetime = 0.75
g.neovide_cursor_vfx_particle_highlight_lifetime = 0.3
g.neovide_cursor_vfx_particle_density = 1.0
