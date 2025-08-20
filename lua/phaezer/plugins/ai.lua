local ai = require 'phaezer.config.ai'

return {
  -- todo: add AI plugins here:
  -- code companion, copilot, chatgpt, etc.

  -- ==============================================================================================
  -- CoPilot
  -- SRC: https://github.com/github/copilot.vim
  -- Setup with `:Copilot setup`
  {
    'github/copilot.vim',
    cmd = 'Copilot',
    event = 'BufWinEnter',
    -- SRC: https://github.com/fang2hou/blink-copilot
    init = function() vim.g.copilot_no_maps = true end,
    config = function()
      -- Block the normal Copilot suggestions
      vim.api.nvim_create_augroup('github_copilot', { clear = true })
      vim.api.nvim_create_autocmd({ 'FileType', 'BufUnload' }, {
        group = 'github_copilot',
        callback = function(args) vim.fn['copilot#On' .. args.event]() end,
      })
      vim.fn['copilot#OnFileType']()
    end,
  }, -- / CoPilot

  -- ==============================================================================================
  -- VectorCode
  -- SRC: https://github.com/Davidyz/VectorCode
  -- DOCS: https://github.com/Davidyz/VectorCode/blob/main/docs/cli.md
  {
    'Davidyz/VectorCode',
    version = '*',
    build = 'uv tool upgrade vectorcode', -- This helps keeping the CLI up-to-date
    -- build = "pipx upgrade vectorcode", -- If you used pipx to install the CLI
    dependencies = { 'nvim-lua/plenary.nvim' },
  }, -- / VectorCode

  -- ==============================================================================================
  -- Code Companion
  -- DOCS: https://codecompanion.olimorris.dev/
  {
    'olimorris/codecompanion.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      -- history extension for code companion
      -- SRC: https://github.com/ravitemer/codecompanion-history.nvim
      'ravitemer/codecompanion-history.nvim',
      -- mcp hup extension
      'ravitemer/mcphub.nvim',
    },
    opts = {
      strategies = {
        -- Change the default chat adapter
        chat = {
          name = 'copilot',
          model = 'claude-sonnet-4-20250514',
          opts = {
            completion_provider = 'blink', -- blink|cmp|coc|default
          },
        },
        inline = {
          adapter = 'copilot',
        },
      },
      opts = {
        -- Set debug logging
        log_level = 'DEBUG',
      },
      adapters = {
        anthropic = function()
          return require('codecompanion.adapters').extend('anthropic', {
            env = {
              api_key = ai.config.anthropic.api_key or ('cmd:op read op://' .. ai.config.anthropic.api_key_path .. ' --no-newline'),
            },
            schema = {
              model = {
                default = ai.config.anthropic.default_model,
              },
            },
          })
        end,
        openai = function()
          return require('codecompanion.adapters').extend('openai', {
            env = {
              api_key = ai.config.openai.api_key or ('cmd:op read op://' .. ai.config.openai.api_key_path .. ' --no-newline'),
            },
            schema = {
              model = {
                default = ai.config.openai.default_model,
              },
            },
          })
        end,
      },
      display = {
        chat = {
          -- Change the default icons
          icons = {
            buffer_pin = ' ',
            buffer_watch = '👀 ',
          },
        },
        action_palette = {
          width = 90,
          height = 25,
          prompt = 'Prompt ', -- Prompt used for interactive LLM calls
          provider = 'snacks',
          opts = {
            show_default_actions = true, -- Show the default actions in the action palette?
            show_default_prompt_library = true, -- Show the default prompt library in the action palette?
            title = 'CodeCompanion actions', -- The title of the action palette
          },
        },
      },
    },
    prompt_library = {
      -- todo: add prompts as needed
      -- ['Document'] = {
      --   strategy = 'chat',
      --   description = 'Write documentation for me',
      --   opts = {
      --     index = 11,
      --     is_slash_cmd = false,
      --     auto_submit = false,
      --     short_name = 'docs',
      --   },
      --   context = {
      --     {
      --       type = 'file',
      --       path = {
      --         'doc/.vitepress/config.mjs',
      --         'lua/codecompanion/config.lua',
      --         'README.md',
      --       },
      --     },
      --   },
      --   prompts = {
      --     {
      --       role = 'system',
      --       content = ai.prompts.document_code.prompt(),
      --     },
      --   },
      -- },
    },
    extensions = {
      -- mcphub extension
      mcphub = {
        callback = 'mcphub.extensions.codecompanion',
        opts = {
          make_vars = true,
          make_slash_commands = true,
          show_result_in_chat = true,
        },
      },
      -- DOCS: https://github.com/ravitemer/codecompanion-history.nvim
      history = {
        enabled = true,
        opts = {
          -- Keymap to open history from chat buffer (default: gh)
          keymap = 'gh',
          -- Keymap to save the current chat manually (when auto_save is disabled)
          save_chat_keymap = 'sc',
          auto_save = true,
          expiration_days = 30, -- delete after 30 days
          -- Picker interface (auto resolved to a valid picker)
          picker = 'snacks', --- ("telescope", "snacks", "fzf-lua", or "default")
          ---Optional filter function to control which chats are shown when browsing
          chat_filter = nil, -- function(chat_data) return boolean end
          -- Customize picker keymaps (optional)
          picker_keymaps = {
            rename = { n = 'r', i = '<M-r>' },
            delete = { n = 'd', i = '<M-d>' },
            duplicate = { n = '<C-y>', i = '<C-y>' },
          },
          ---Automatically generate titles for new chats
          auto_generate_title = true,
          title_generation_opts = {
            ---Adapter for generating titles (defaults to current chat adapter)
            adapter = nil, -- "copilot"
            ---Model for generating titles (defaults to current chat model)
            model = nil, -- "gpt-4o"
            ---Number of user prompts after which to refresh the title (0 to disable)
            refresh_every_n_prompts = 0, -- e.g., 3 to refresh after every 3rd user prompt
            ---Maximum number of times to refresh the title (default: 3)
            max_refreshes = 3,
            format_title = function(original_title)
              -- this can be a custom function that applies some custom
              -- formatting to the title.
              return original_title
            end,
          },
          ---On exiting and entering neovim, loads the last chat on opening chat
          continue_last_chat = false,
          ---When chat is cleared with `gx` delete the chat from history
          delete_on_clearing_chat = false,
          ---Directory path to save the chats
          dir_to_save = vim.fn.stdpath 'data' .. '/codecompanion-history',
          ---Enable detailed logging for history extension
          enable_logging = false,

          -- Summary system
          summary = {
            -- Keymap to generate summary for current chat (default: "gcs")
            create_summary_keymap = 'gcs',
            -- Keymap to browse summaries (default: "gbs")
            browse_summaries_keymap = 'gbs',
            generation_opts = {
              adapter = nil, -- defaults to current chat adapter
              model = nil, -- defaults to current chat model
              context_size = 90000, -- max tokens that the model supports
              include_references = true, -- include slash command content
              include_tool_outputs = true, -- include tool execution results
              system_prompt = nil, -- custom system prompt (string or function)
              format_summary = nil, -- custom function to format generated summary e.g to remove <think/> tags from summary
            },
          },

          -- Memory system (requires VectorCode CLI)
          -- vectorcode SRC: https://github.com/Davidyz/VectorCode
          -- DOCS: https://github.com/Davidyz/VectorCode/blob/main/docs/cli.md
          memory = {
            -- Automatically index summaries when they are generated
            auto_create_memories_on_summary_generation = true,
            -- Path to the VectorCode executable
            vectorcode_exe = 'vectorcode',
            -- Tool configuration
            tool_opts = {
              -- Default number of memories to retrieve
              default_num = 10,
            },
            -- Enable notifications for indexing progress
            notify = true,
            -- Index all existing memories on startup
            -- (requires VectorCode 0.6.12+ for efficient incremental indexing)
            index_on_startup = true,
          },
        },
      },
    },
  }, -- / Code Companion

  -- ==============================================================================================
  -- WTF
  -- wtf.nvim A Neovim plugin to help you work out what the fudge that diagnostic means and how to fix it!
  -- SRC: https://github.com/piersolenski/wtf.nvim
  {
    'piersolenski/wtf.nvim',
    dependencies = {
      'MunifTanjim/nui.nvim',
    },

    opts = {
      openai_model_id = 'gpt-4o',
      language = 'english',
      search_engine = 'google',
      additional_instructions = [[
      Be concise and to the point. Provide examples and code snippets when appropriate. Offer multiple solutions when appropriate.
      If the provided diagnostics and code is not clear, or does not provide enough context, ask for more information.]],
    },

    keys = {
      {
        '<leader>?a',
        function() require('wtf').ai() end,
        desc = 'Debug diagnostic with AI',
        mode = { 'n', 'x' },
      },
      {
        '<leader>?s',
        function() require('wtf').search() end,
        desc = 'Search diagnostic with Google',
      },
      {
        '<leader>?h',
        function() require('wtf').history() end,
        desc = 'Populate the quickfix list with previous chat history',
      },
      {
        '<leader>?g',
        function() require('wtf').grep_history() end,
        desc = 'Grep previous chat history with Telescope',
      },
    },
  }, -- / WTF
}
