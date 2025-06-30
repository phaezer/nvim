-- codecompanion - A code companion for neovim
-- src: https://github.com/olimorris/codecompanion.nvim
-- docs: https://codecompanion.olimorris.dev/
return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    -- mcp hup extension
    "ravitemer/mcphub.nvim"
  },
  opts = {
    strategies = {
      -- Change the default chat adapter
      chat = {
        adapter = "anthropic",
      },
      inline = {
        adapter = "copilot",
      },
    },
    display = {
      action_palette = {
        width = 95,
        height = 10,
        provider = "snacks",
        opts = {
          show_default_actions = true,          -- Show the default actions in the action palette?
          show_default_prompt_library = true,   -- Show the default prompt library in the action palette?
        },
      },
    },
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
}
