local keymap = require 'core.keymap'

return {
  -- https://github.com/neovim/nvim-lspconfig
  -- nvim-lspconfig - A collection of configurations for built-in LSP client
  {
    'neovim/nvim-lspconfig',
    lazy = false,
    dependencies = {
      { 'mason-org/mason.nvim', opts = {} },
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'j-hui/fidget.nvim',    opts = {} },
      'saghen/blink.cmp',
      'nvim-telescope/telescope.nvim',
      '  "folke/snacks.nvim'
    },
    config = function()
      -- LSP server configurations
      -- see: https://github.com/neovim/nvim-lspconfig for all the available servers
      local servers = {
        stylua = {},
        clangd = {},
        cmake = {},
        gopls = {},
        pyright = {},
        -- rust_analyzer = {}, -- disabled as this is provided by rustacean
        ts_ls = {},
        -- ansible requires npm package ansible-language-server
        -- src: https://github.com/neovim/nvim-lspconfig/blob/master/lsp/ansiblels.lua
        ansiblels = {},
        eslint = {},
        -- docker ls requires npm package dockerfile-language-server-nodejs
        -- src: https://github.com/neovim/nvim-lspconfig/blob/master/lsp/dockerls.lua
        dockerls = {},
        tofu_ls = {},
        -- bash ls requires npm package bash-language-server
        -- src: https://github.com/neovim/nvim-lspconfig/blob/master/lsp/bashls.lua
        bashls = {},
        -- ruff formatter
        -- src: https://github.com/neovim/nvim-lspconfig/blob/master/lsp/ruff.lua
        ruff = {},
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      }

      -- Diagnostic Config
      -- See :help vim.diagnostic.Opts
      vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = ' ',
            [vim.diagnostic.severity.WARN] = ' ',
            [vim.diagnostic.severity.INFO] = ' ',
            [vim.diagnostic.severity.HINT] = ' ',
          },
        },
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
      }

      local capabilities = require('blink.cmp').get_lsp_capabilities()

      require('mason-tool-installer').setup { ensure_installed = vim.tbl_keys(servers) }

      require('mason-lspconfig').setup {
        ensure_installed = {},
        automatic_installation = false,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
          keymap.set({
            { 'gN',         vim.lsp.buf.rename,                                   desc = 'Rename buffer' },
            { 'ga',         vim.lsp.buf.code_action,                              desc = 'Code Action' },
            { "gd",         function() Snacks.picker.lsp_definitions() end,       desc = "Goto Definition" },
            { "gD",         function() Snacks.picker.lsp_declarations() end,      desc = "Goto Declaration" },
            { "gr",         function() Snacks.picker.lsp_references() end,        desc = "References",            nowait = true },
            { "gi",         function() Snacks.picker.lsp_implementations() end,   desc = "Goto Implementation" },
            { "gt",         function() Snacks.picker.lsp_type_definitions() end,  desc = "Goto T[y]pe Definition" },
            { "<leader>ss", function() Snacks.picker.lsp_symbols() end,           desc = "LSP Symbols" },
            { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
          })

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)

          if client and client:supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- The following code creates a keymap to toggle inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client:supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            keymap.set {
              {
                '<leader>th',
                function()
                  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
                end,
                desc = 'Toggle Inlay Hints',
                buffer = event.buf
              }
            }
          end
        end,
      })
    end,
  },

  {
    'jmbuhr/otter.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {
      {
        lsp = {
          -- `:h events` that cause the diagnostics to update. Set to:
          -- { "BufWritePost", "InsertLeave", "TextChanged" } for less performant
          -- but more instant diagnostic updates
          diagnostic_update_events = { "BufWritePost" },
          -- function to find the root dir where the otter-ls is started
          root_dir = function(_, bufnr)
            return vim.fs.root(bufnr or 0, {
              ".git",
              "_quarto.yml",
              "package.json",
            }) or vim.fn.getcwd(0)
          end,
        },
        -- options related to the otter buffers
        buffers = {
          -- if set to true, the filetype of the otterbuffers will be set.
          -- otherwise only the autocommand of lspconfig that attaches
          -- the language server will be executed without setting the filetype
          --- this setting is deprecated and will default to true in the future
          set_filetype = true,
          -- write <path>.otter.<embedded language extension> files
          write_to_disk = true,
          -- a table of preambles for each language. The key is the language and the value is a table of strings that will be written to the otter buffer starting on the first line.
          preambles = {},
          -- a table of postambles for each language. The key is the language and the value is a table of strings that will be written to the end of the otter buffer.
          postambles = {},
          -- A table of patterns to ignore for each language. The key is the language and the value is a lua match pattern to ignore.
          -- lua patterns: https://www.lua.org/pil/20.2.html
          ignore_pattern = {
            -- ipython cell magic (lines starting with %) and shell commands (lines starting with !)
            python = "^(%s*[%%!].*)",
          },
        },
        -- list of characters that should be stripped from the beginning and end of the code chunks
        strip_wrapping_quote_characters = { "'", '"', "`" },
        -- remove whitespace from the beginning of the code chunks when writing to the ottter buffers
        -- and calculate it back in when handling lsp requests
        handle_leading_whitespace = true,
        -- mapping of filetypes to extensions for those not already included in otter.tools.extensions
        -- e.g. ["bash"] = "sh"
        extensions = {
        },
        -- add event listeners for LSP events for debugging
        debug = false,
        verbose = {             -- set to false to disable all verbose messages
          no_code_found = false -- warn if otter.activate is called, but no injected code was found
        },
      }
    },
    keys = {
      { '<leader>oa', function() require('otter').activate() end,   desc = 'Otter Activate' },
      { '<leader>od', function() require('otter').deactivate() end, desc = 'Otter Deactivate' },
    },
  },

  {
    'onsails/lspkind.nvim',
    lazy = false,
    config = function()
      require('lspkind').init({
        symbol_map = {
          Array         = "󰅪",
          Boolean       = "󰨙",
          Breadcrumb    = "»",
          Bug           = "",
          Class         = "",
          Close         = "",
          Cmd           = "",
          Codeium       = "󰘦",
          Collapsed     = "",
          Color         = "",
          Config        = "",
          Constant      = "",
          Constructor   = "",
          Control       = "",
          Copilot       = "",
          Date          = "",
          Debug         = "",
          Doc           = "󱗖",
          Done          = "",
          Dots          = "󰇘",
          Enum          = "",
          EnumMember    = "",
          Error         = "",
          Event         = "",
          Expanded      = "",
          Field         = "󰽐",
          File          = "",
          FileTree      = "",
          Folder        = "",
          Function      = "󰊕",
          Group         = "+",
          Hack          = "",
          Hint          = "",
          Import        = "󰋺",
          Imports       = "󰋺",
          Info          = "",
          Init          = "",
          Interface     = "",
          Key           = "󰌋",
          Keys          = "",
          Keyword       = "",
          Lazy          = "󰒲",
          Loaded        = "",
          Loading       = "",
          Lock          = "",
          Method        = "󰊕",
          Module        = "",
          Namespace     = "󰦮",
          Neovim        = "",
          Note          = "",
          NotLoaded     = "",
          Null          = "󰟢",
          Number        = "",
          Object        = "󰅩",
          Operator      = "󰆕",
          Package       = "",
          Perf          = "",
          Pin           = "",
          Plugin        = "",
          Property      = "",
          Reference     = "",
          Require       = "",
          Runtime       = "",
          Snippet       = "󱄽",
          Source        = "",
          Star          = "",
          Start         = "",
          String        = "",
          Struct        = "",
          Supermaven    = "",
          Tag           = "",
          Task          = "",
          Telescope     = "",
          Test          = "",
          Text          = "󱀍",
          Todo          = "",
          TypeParameter = "󰗴",
          Unit          = "",
          Unlock        = "󰿇",
          Value         = "",
          Variable      = "󰫧",
          Warning       = "",
          Web           = "",
        }
      })
    end
  }
}
