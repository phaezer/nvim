--- AutoCommands for Neovim
-- DOCS: https://neovim.io/doc/user/autocmd.html

local api = vim.api
local autocmd = api.nvim_create_autocmd

-- highlight on yank
autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  callback = function()
    vim.hl.on_yank()
  end,
})

-- disable auto commenting on new lines
autocmd('BufEnter', {
  desc = 'Disable New Line Comment',
  callback = function()
    vim.opt.formatoptions:remove { 'c', 'r', 'o' }
  end,
})

-- remember last loc when opening a buffer
autocmd('BufReadPost', {
  desc = 'go to last loc when opening a buffer',
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- LSP Attach Autocmd for setting up buffer local keymaps, autocommands, etc.
autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if not client then
      return
    end
    if not client.server_capabilities then
      return
    end

    if
      client
      and client:supports_method(
        client,
        vim.lsp.protocol.Methods.textDocument_documentHighlight,
        event.buf
      )
    then
      -- Highlighting for LSP diagnostics
      local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      -- Clear highlights on cursor move
      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      local keys = require 'phaezer.core.keys'

      -- Set keymaps for LSP
      keys.map {
        {
          '<leader>vh',
          function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
          end,
          desc = 'Toggle Inlay Hints',
          buffer = event.buf,
        },
      }

      -- clear lsb buffer and highlights on LSP detach
      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
        callback = function(_event)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = _event.buf }
          keys.unmap { { '<leader>lh', buffer = _event.buf } }
        end,
      })
    end
  end,
})
