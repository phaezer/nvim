-- Minty
-- NOTE: Beautifully crafted color tools for Neovim
return {
  'nvzone/minty',
  lazy = true,
  cmd = { 'Shades', 'Huefy' },
  dependencies = {
    { 'nvzone/volt', lazy = true },
  },
}
