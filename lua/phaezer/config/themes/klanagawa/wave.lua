local hl = require 'phaezer.config.highlights'

require('kanagawa').setup {
  compile = false, -- enable compiling the colorscheme
  commentStyle = { italic = false },
  theme = 'wave',
  background = { -- map the value of 'background' option to a theme
    dark = 'wave',
    light = 'lotus',
  },
}

hl.set_blended_rainbow_indents(hl.std_rainbow_colors, '#1F1F28', '#DCD7BA', 0.2, 0.5)
