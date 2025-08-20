return {
  -- ==============================================================================================
  -- LuaSnip
  -- snippet engine / provider
  -- DOCS: https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md
  {
    'L3MON4D3/LuaSnip',
    lazy = false,
    version = '2.*',
    build = (function()
      -- Build Step is needed for regex support in snippets.
      -- This step is not supported in many windows environments.
      -- Remove the below condition to re-enable on windows.
      if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then return end
      return 'make install_jsregexp'
    end)(),
    dependencies = {
      -- `friendly-snippets` contains a variety of premade snippets.
      --    See the README about individual language/framework/plugin snippets:
      --    https://github.com/rafamadriz/friendly-snippets
      {
        'rafamadriz/friendly-snippets',
        config = function() require('luasnip.loaders.from_vscode').lazy_load() end,
      },
    },
    opts = {},
  }, -- / LuaSnip

  {
    -- Blink
    -- Autocompletion provider
    -- DOCS: https://cmp.saghen.dev/
    'saghen/blink.cmp',
    lazy = true,
    event = 'VimEnter',
    version = '1.*',
    dependencies = {
      -- copilot
      'fang2hou/blink-copilot',
      'L3MON4D3/LuaSnip',
      -- 'rafamadriz/friendly-snippets',
      'L3MON4D3/LuaSnip',
      'folke/lazydev.nvim',
      'xzbdmw/colorful-menu.nvim',
    },

    opts = {
      keymap = {
        -- 'default' (recommended) for mappings similar to built-in completions
        --   <c-y> to accept ([y]es) the completion.
        --    This will auto-import if your LSP supports it.
        --    This will expand snippets if the LSP sent a snippet.
        -- 'super-tab' for tab to accept
        -- 'enter' for enter to accept
        -- 'none' for no mappings
        --
        -- For an understanding of why the 'default' preset is recommended,
        -- you will need to read `:help ins-completion`
        --
        -- All presets have the following mappings:
        -- <tab>/<s-tab>: move to right/left of your snippet expansion
        -- <c-space>: Open menu or open docs if already open
        -- <c-n>/<c-p> or <up>/<down>: Select next/previous item
        -- <c-e>: Hide menu
        -- <c-k>: Toggle signature help
        --
        -- See :h blink-cmp-config-keymap for defining your own keymap
        preset = 'super-tab',
        -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
        --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
      },

      appearance = {
        nerd_font_variant = 'mono',
      },

      completion = {
        accept = {
          auto_brackets = { enabled = true }, -- auto insert brackets
        },
        -- show the documentation after a delay
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 1000,
          treesitter_highlighting = true,
        },
        ghost_text = { enabled = true }, -- show the ghost text
        list = { -- DOCS: https://cmp.saghen.dev/configuration/completion.html#list
          selection = {
            auto_insert = true,
          },
        },
        menu = {
          -- use colorful menu
          draw = {
            columns = { { 'kind_icon' }, { 'label', gap = 1 } },
            components = {
              label = {
                text = function(ctx) return require('colorful-menu').blink_components_text(ctx) end,
                highlight = function(ctx) return require('colorful-menu').blink_components_highlight(ctx) end,
              },
            },
          },
        },
      },

      -- DOCS: https://cmp.saghen.dev/configuration/sources.html
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer', 'copilot' },
        per_filetype = {
          sql = { 'dadbod' },
          lua = { inherit_defaults = true, 'lazydev' },
        },
        providers = {
          -- copilot
          copilot = {
            name = 'copilot',
            module = 'blink-copilot',
            score_offset = 100,
            async = true,
            opts = {
              max_completions = 5,
              max_attempts = 5,
              kind_name = 'Copilot',
              -- kind_hl = false,
              debounce = 200,
              auto_refresh = {
                backward = true,
                forward = true,
              },
            },
          },
          dadbod = { module = 'vim_dadbod_completion.blink' },
          lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
        },
      },

      snippets = { preset = 'luasnip' },

      -- Blink.cmp includes an optional, recommended rust fuzzy matcher,
      -- which automatically downloads a prebuilt binary when enabled.
      --
      -- By default, we use the Lua implementation instead, but you may enable
      -- the rust implementation via `'prefer_rust_with_warning'`
      --
      -- See :h blink-cmp-config-fuzzy for more information
      fuzzy = { implementation = 'prefer_rust_with_warning' },

      -- Shows a signature help window while you type arguments for a function
      signature = { enabled = true },
    },
  },
}
