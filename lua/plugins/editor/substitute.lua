-- substitute - Substitute plugin
-- https://github.com/gbprod/substitute.nvim
return {
  "gbprod/substitute.nvim",
  lazy = false,
  opts = {
    on_substitute = function() require("yanky.integration").substitute() end,
  },
}
