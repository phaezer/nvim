local util = require('lspconfig').util

-- LSP server configurations
-- SEE: https://github.com/neovim/nvim-lspconfig for all the available servers
local servers = {
  -- Lua
  stylua = {},
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

  -- Go
  -- gopls src: https://github.com/golang/tools/blob/master/gopls
  gopls = {
    cmd = { 'gopls' },
    filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
    settings = {
      gopls = {
        completeUnimported = true,
        usePlaceholders = true,
        analyses = {
          unusedparams = true,
        },
      },
    },
  },

  -- C
  cmake = {},
  -- ansible
  -- NOTE: requires npm package ansible-language-server
  -- SRC: https://github.com/neovim/nvim-lspconfig/blob/master/lsp/ansiblels.lua
  ansiblels = {},

  -- docker
  -- docker ls requires npm package dockerfile-language-server-nodejs
  -- SRC: https://github.com/neovim/nvim-lspconfig/blob/master/lsp/dockerls.lua
  dockerls = {},
  tofu_ls = {},

  -- shell
  -- bash ls requires npm package bash-language-server
  -- src: https://github.com/neovim/nvim-lspconfig/blob/master/lsp/bashls.lua
  bashls = {},

  -- python
  -- ruff formatter
  -- src: https://github.com/neovim/nvim-lspconfig/blob/master/lsp/ruff.lua
}

-- mason tool installer setup
-- SRC: https://github.com/mason-org/mason-tool-installer.nvim
require('mason-tool-installer').setup {
  ensure_installed = {

  }
}

-- Diagnostic Config
-- SEE: :help vim.diagnostic.Opts
vim.diagnostic.config {
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = vim.diagnostic.severity.ERROR },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = ' ',
      [vim.diagnostic.severity.WARN] = ' ',
      [vim.diagnostic.severity.INFO] = ' ',
      [vim.diagnostic.severity.HINT] = ' ',
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

-- -- mason-lspconfig setup
-- -- SRC: https://github.com/mason-org/mason-lspconfig.nvim
-- require('mason-lspconfig').setup {
--   ensure_installed = {}, -- installed with mason-tool-installer
--   automatic_installation = false,
-- }

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    if client and client:supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, ev.buf) then
      local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = ev.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = ev.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
        callback = function(_ev)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = _ev.buf }
        end,
      })
    end
  end,
})
