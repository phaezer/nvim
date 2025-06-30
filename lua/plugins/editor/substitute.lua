-- substitute - Substitute plugin
-- https://github.com/gbprod/substitute.nvim
return {
  "gbprod/substitute.nvim",
  lazy = false,
  opts = {
    on_substitute = function() require("yanky.integration").substitute() end,
  },
  init = function()
    Core.keymap.set {
      { "s",  require('substitute').operator, desc = "Substitute" },
      { "ss", require('substitute').line,     desc = "Substitute line" },
      { "S",  require('substitute').eol,      desc = "Substitute end of line" },
      { "gs", require('substitute').visual,   desc = "Substitute visual selection" },
    }
  end,
}
