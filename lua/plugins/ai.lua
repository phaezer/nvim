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
            show_default_actions = true,        -- Show the default actions in the action palette?
            show_default_prompt_library = true, -- Show the default prompt library in the action palette?
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
  },

  -- wtf.nvim A Neovim plugin to help you work out what the fudge that diagnostic means and how to fix it!
  -- src: https://github.com/piersolenski/wtf.nvim
  {
    "piersolenski/wtf.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    opts = {
      openai_model_id = "gpt-4o",
      language = "english",
      search_engine = "google"
    },
    additional_instructions = [[
      Be concise and to the point. Provide examples and code snippets when appropriate. Offer multiple solutions when appropriate.
      If the provided diagnostics and code is not clear, or does not provide enough context, ask for more information.]],
    keys = {
      {
        "<leader>?a",
        function()
          require("wtf").ai()
        end,
        desc = "Debug diagnostic with AI",
        mode = { "n", "x" },
      },
      {
        "<leader>?s",
        function()
          require("wtf").search()
        end,
        desc = "Search diagnostic with Google",
      },
      {
        "<leader>?h",
        function()
          require("wtf").history()
        end,
        desc = "Populate the quickfix list with previous chat history",
      },
      {
        "<leader>?g",
        function()
          require("wtf").grep_history()
        end,
        desc = "Grep previous chat history with Telescope",
      },
    },
  }
}
