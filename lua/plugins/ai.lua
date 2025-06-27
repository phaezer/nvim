return {
  {
    -- copilot for ai completions
    -- https://github.com/zbirenbaum/copilot.lua
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
    }
  },

  -- codecompanion - A code companion for neovim
  -- src: https://github.com/olimorris/codecompanion.nvim
  -- docs: https://codecompanion.olimorris.dev/
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      -- mcp hup extension
      "ravitemer/mcphub.nvim"
    },
    opts = {
      extensions = {
        mcphub = {
          callback = "mcphub.extensions.codecompanion",
          opts = {
            make_vars = true,
            make_slash_commands = true,
            show_result_in_chat = true
          }
        }
      }
    }
  },
}
