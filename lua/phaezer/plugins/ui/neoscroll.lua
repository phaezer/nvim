-- NeoScroll
-- NOTE: Provides smooth scrolling animations
return {
  'karb94/neoscroll.nvim',
  lazy = false,
  opts = {
    mappings = {
      '<C-u>',
      '<C-d>',
      '<C-b>',
      '<C-f>',
      '<C-y>',
      '<C-e>',
      'zz',
      'zt',
      'zb',
    },
    hide_cursor = false,
    stop_eof = true,
    respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
    cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
    duration_multiplier = 1.0, -- Global duration multiplier
    easing = 'linear', -- Default easing function
    ignored_events = { -- Events ignored while scrolling
      'WinScrolled',
      'CursorMoved',
    },
  },
}
