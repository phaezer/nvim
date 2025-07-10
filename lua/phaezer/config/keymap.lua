local set = require('phaezer.lib.keys').set

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

set { 'jk', '<esc>', desc = 'Exit insert mode', mode = 'i' }

-- Remap for dealing with visual line wraps
set {
  { 'k', 'v:count == 0 ? "gk" : "k"', desc = 'Move up', expr = true },
  { 'j', 'v:count == 0 ? "gj" : "j"', desc = 'Move down', expr = true },
}

-- Keep selection while indenting
set {
  { '<', '<gv', desc = 'Indent left', mode = 'v' },
  { '>', '>gv', desc = 'Indent right', mode = 'v' },
}

set { '<esc>', '<cmd>nohlsearch<CR>', desc = 'Clear highlights on search' }
set { '<leader>q', vim.diagnostic.setloclist, desc = 'Diagnostic Quickfix list' }

-- terminal
set {
  { '<C-q>', '<C-\\><C-n>', desc = 'Exit terminal mode', mode = 't' },
  { '<esc><esc>', '<C-\\><C-n>', desc = 'Exit terminal mode', mode = 't' },
}

-- window management
set {
  { '<leader>ws', '<cmd>split<cr>', desc = 'Horizontal split' },
  { '<leader>wv', '<cmd>vsplit<cr>', desc = 'Vertical split' },
  { '<leader>wc', '<cmd>close<cr>', desc = 'Close window' },
  { '<leader>wT', '<cmd>wincmd T<cr>', desc = 'Move window to new tab' },
  { '<leader>wr', '<cmd>wincmd r<cr>', desc = 'Rotate window down/right' },
  { '<leader>wR', '<cmd>wincmd R<cr>', desc = 'Rotate window up/left' },
  { '<leader>wH', '<cmd>wincmd H<cr>', desc = 'Move window left' },
  { '<leader>wJ', '<cmd>wincmd J<cr>', desc = 'Move window down' },
  { '<leader>wK', '<cmd>wincmd K<cr>', desc = 'Move window up' },
  { '<leader>wL', '<cmd>wincmd L<cr>', desc = 'Move window right' },
  { '<leader>wk', '<cmd>resize +3<cr>', desc = 'Increase window height' },
  { '<leader>wj', '<cmd>resize -3<cr>', desc = 'Decrease window height' },
  { '<leader>wh', '<cmd>vertical resize +3<cr>', desc = 'Increase window width' },
  { '<leader>wl', '<cmd>vertical resize -3<cr>', desc = 'Decrease window width' },
  { '<leader>w=', '<cmd>wincmd =<cr>', desc = 'Windows Equalize size' },
  { '<a-h>', '<cmd>wincmd h<cr>', desc = 'Switch to window left' },
  { '<a-j>', '<cmd>wincmd j<cr>', desc = 'Switch to window down' },
  { '<a-k>', '<cmd>wincmd k<cr>', desc = 'Switch to window up' },
  { '<a-l>', '<cmd>wincmd l<cr>', desc = 'Switch to window right' },
}

-- buffer management
set {
  { '<leader>bl', '<cmd>bnext<cr>', desc = 'Next buffer' },
  { '<leader>bh', '<cmd>bprevious<cr>', desc = 'Previous buffer' },
  { '<leader>bD', '<cmd>%bd|e#|bd#<cr>', desc = 'Close all but the current buffer' },
}

-- files management
set {
  { '<leader>fN', '<cmd>enew<cr>', desc = 'New file' },
  { '<leader>fs', '<cmd>w<cr><esc>', desc = 'Save file' },
}


vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = false }),
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client:supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
      set {
        '<leader>th',
        function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }) end,
        desc = 'Toggle Inlay Hints',
        buffer = event.buf,
      }
    end
  end,
})

