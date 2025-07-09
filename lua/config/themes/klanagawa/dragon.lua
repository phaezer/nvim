local hl = require 'config.highlights'

require('kanagawa').setup {
  compile = false, -- enable compiling the colorscheme
  commentStyle = { italic = false },
  theme = 'dragon',
  background = { -- map the value of 'background' option to a theme
    dark = 'dragon',
    light = 'lotus',
  },
}

hl.set_blended_rainbow_indents(hl.std_rainbow_colors, '#181616', '#c5c9c5', 0.2, 0.5)
