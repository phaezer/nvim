-- Substitute
-- NOTE: A Neovim plugin for performing substitutions with a visual selection or a range
return {
  'gbprod/substitute.nvim',
  lazy = false,
  opts = {
    on_substitute = function() require('yanky.integration').substitute() end,
  },
  keys = {
    { 's', function() require('substitute').operator() end, desc = 'Substitute' },
    { 'ss', function() require('substitute').line() end, desc = 'Substitute line' },
    { 'S', function() require('substitute').eol() end, desc = 'Substitute end of line' },
    { 'gs', function() require('substitute').visual() end, desc = 'Substitute visual selection' },
  },
}
