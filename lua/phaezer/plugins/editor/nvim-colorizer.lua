-- NOTE: adds color highlights for hex codes, RGB, etc. for colors in buffers
return {
  'norcalli/nvim-colorizer.lua',
  lazy = true,
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    '*',
    '!cmp_menu',
    '!fidget',
    '!notify',
    '!TelescopeResults',
    '!TelescopePrompt',
    '!lazy',
    '!snacks_dashboard',
  },
}
