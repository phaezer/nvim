-- Blink
-- NOTE: Autocompletion provider
-- DOCS: https://cmp.saghen.dev/
return {
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
    'jmbuhr/otter.nvim',
    'mikavilpas/blink-ripgrep.nvim',
    -- 'olimorris/codecompanion.nvim',
    {
      'Kaiser-Yang/blink-cmp-dictionary',
      dependencies = { 'nvim-lua/plenary.nvim' },
    },
    -- avante provider
    'Kaiser-Yang/blink-cmp-avante',
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
      -- integration with copilot-lsp nes edits
      -- SRC: https://github.com/copilotlsp-nvim/copilot-lsp#blink-integration
      ['<Tab>'] = {
        function(cmp)
          if vim.b[vim.api.nvim_get_current_buf()].nes_state then
            cmp.hide()
            return (
              require('copilot-lsp.nes').apply_pending_nes()
              and require('copilot-lsp.nes').walk_cursor_end_edit()
            )
          end
          if cmp.snippet_active() then
            return cmp.accept()
          else
            return cmp.select_and_accept()
          end
        end,
        'snippet_forward',
        'fallback',
      },
      ['<C-k>'] = { 'select_prev', 'fallback' },
      ['<C-j>'] = { 'select_next', 'fallback' },
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
        auto_show_delay_ms = 200,
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
            -- todo: update kind icon
            kind_icon = {
              text = function(ctx)
                local icon = ctx.kind_icon
                if vim.tbl_contains({ 'Path' }, ctx.source_name) then
                  local dev_icon, _ = require('nvim-web-devicons').get_icon(ctx.label)
                  if dev_icon then icon = dev_icon end
                else
                  icon = require('lspkind').symbolic(ctx.kind, {
                    mode = 'symbol',
                  })
                end
                return icon .. ctx.icon_gap
              end,
              highlight = function(ctx)
                local hl = ctx.kind_hl
                if vim.tbl_contains({ 'Path' }, ctx.source_name) then
                  local dev_icon, dev_hl = require('nvim-web-devicons').get_icon(ctx.label)
                  if dev_icon then hl = dev_hl end
                end
                return hl
              end,
            },
            label = {
              width = { fill = true, max = 80 },
              text = function(ctx)
                local highlights_info = require('colorful-menu').blink_highlights(ctx)
                if highlights_info ~= nil then
                  -- Or you want to add more item to label
                  return highlights_info.label
                else
                  return ctx.label
                end
              end,
              highlight = function(ctx)
                local highlights = {}
                local highlights_info = require('colorful-menu').blink_highlights(ctx)
                if highlights_info ~= nil then highlights = highlights_info.highlights end
                for _, idx in ipairs(ctx.label_matched_indices) do
                  table.insert(highlights, { idx, idx + 1, group = 'BlinkCmpLabelMatch' })
                end
                -- Do something else
                return highlights
              end,
            },
          },
        },
      },
    },

    -- DOCS: https://cmp.saghen.dev/configuration/sources.html
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer', 'copilot', 'avante', 'ripgrep' },
      per_filetype = {
        sql = { 'dadbod' },
        lua = { inherit_defaults = true, 'lazydev' },
        markdown = { inherit_defaults = true, 'dictionary' },
        -- text = { inherit_defaults = true, 'dictionary' },
        norg = { inherit_defaults = true, 'dictionary' },
      },
      providers = {
        -- copilot
        copilot = {
          name = 'copilot',
          module = 'blink-copilot',
          score_offset = 10,
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
        avante = {
          module = 'blink-cmp-avante',
          name = 'Avante',
          opts = {
            command = {
              get_kind_name = function(_) return 'Cmd' end,
            },
            mention = {
              get_kind_name = function(_) return 'Mention' end,
            },
            shortcut = {
              get_kind_name = function(_) return 'Shortcut' end,
            },
          },
        },
        ripgrep = {
          module = 'blink-ripgrep',
          name = 'Ripgrep',
          opts = {
            project_root_marker = { '.git', 'package.json', '.root', 'go.mod' },
          },
        },
        dictionary = {
          module = 'blink-cmp-dictionary',
          name = 'dictionary',
          min_keyword_length = 3,
          opts = {
            dictionary_directories = {
              vim.fn.stdpath 'config' .. '/dictionaries',
              vim.fn.stdpath 'config' .. '/spell',
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
    signature = { enabled = false }, -- this is done with noice
  },
  keys = {
    {
      '<C-.>',
      function()
        require('blink-cmp').show { providers = { 'buffer', 'lsp', 'path', 'avante', 'copilot' } }
      end,
      desc = 'Blink cmp text',
      mode = 'i',
    },
    {
      '<C-,>',
      function() require('blink-cmp').show { providers = { 'buffer', 'dictionary' } } end,
      desc = 'Blink cmp text',
      mode = 'i',
    },
    {
      '<C-l>',
      function() require('blink-cmp').show { providers = { 'lsp', 'path', 'snippets' } } end,
      desc = 'Blink cmp lsp',
      mode = 'i',
    },
    {
      '<C-;>',
      function() require('blink-cmp').show { providers = { 'avante', 'copilot' } } end,
      desc = 'blink cmp ai',
      mode = 'i',
    },
  },
}
