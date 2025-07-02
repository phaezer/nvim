return {
  -- see: https://github.com/folke/snacks.nvim/blob/main/docs/indent.md
  "folke/snacks.nvim",
  opts = {
    indent = {
      enabled = true,
      indent = {
        char = "│",
        only_scope = false,
        only_current = false,
        hl = {
          "IndentRainbowDim0",
          "IndentRainbowDim1",
          "IndentRainbowDim2",
          "IndentRainbowDim3",
          "IndentRainbowDim4",
          "IndentRainbowDim5",
          "IndentRainbowDim6",
          "IndentRainbowDim7",
        }
      },
      scope = {
        enabled = true, -- enable highlighting the current scope
        priority = 200,
        char = "│",
        underline = false,    -- underline the start of the scope
        only_current = false, -- only show scope in the current window
        hl = {
          "IndentRainbowBright0",
          "IndentRainbowBright1",
          "IndentRainbowBright2",
          "IndentRainbowBright3",
          "IndentRainbowBright4",
          "IndentRainbowBright5",
          "IndentRainbowBright6",
          "IndentRainbowBright7",
        }
      },
    },
  },

  keys = {
    -- Top Pickers & Explorer
    {
      "<leader>ui",
      function()
        if Snacks.indent.enabled then
          Snacks.indent.disable()
        else
          Snacks.indent.enable()
        end
      end,
      desc = "Toggle Indents"
    }
  }
}
