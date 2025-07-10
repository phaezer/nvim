local keymap = require 'lua.phaezer.keymap'

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
      'folke/snacks.nvim'

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
      { '<leader>loa', function() require('otter').activate() end,   desc = 'Otter Activate' },
      { '<leader>lod', function() require('otter').deactivate() end, desc = 'Otter Deactivate' },
    },
  }
}
