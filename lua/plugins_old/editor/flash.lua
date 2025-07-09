return {
  -- flash - A more intuitive way to search and navigate
  -- SRC: https://github.com/folke/flash.nvim
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {},
  -- stylua: ignore
  keys = {
    { "s",     function() require("flash").jump() end,              desc = "Flash",                mode = { "n", "x", "o" }, },
    { "S",     function() require("flash").treesitter() end,        desc = "Flash Treesitter",     mode = { "n", "x", "o" }, },
    { "r",     function() require("flash").remote() end,            desc = "Remote Flash",         mode = "o", },
    { "R",     function() require("flash").treesitter_search() end, desc = "Treesitter Search",    mode = { "o", "x" }, },
    { "<c-s>", function() require("flash").toggle() end,            desc = "Toggle Flash Search",  mode = { "c" }, },
  },
}
