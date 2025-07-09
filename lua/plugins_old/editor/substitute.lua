-- substitute - Substitute plugin
-- https://github.com/gbprod/substitute.nvim
return {
  "gbprod/substitute.nvim",
  lazy = false,
  opts = {
    on_substitute = function() require("yanky.integration").substitute() end,
  },
  keys = {
    { "s",  function() require('substitute').operator() end, desc = "Substitute" },
    { "ss", function() require('substitute').line() end,     desc = "Substitute line" },
    { "S",  function() require('substitute').eol() end,      desc = "Substitute end of line" },
    { "gs", function() require('substitute').visual() end,   desc = "Substitute visual selection" },
  }
}
