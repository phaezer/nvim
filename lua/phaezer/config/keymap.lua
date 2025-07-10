local map = require('phaezer.keymap').set

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

map { 'jk', '<esc>', desc = 'Exit insert mode', mode = 'i' }

map { -- Remap for dealing with visual line wraps
  { 'k', 'v:count == 0 ? "gk" : "k"', desc = 'Move up', expr = true },
  { 'j', 'v:count == 0 ? "gj" : "j"', desc = 'Move down', expr = true },
}

map { -- Keep selection while indenting
  { '<', '<gv', desc = 'Indent left', mode = 'v' },
  { '>', '>gv', desc = 'Indent right', mode = 'v' },
}

map { '<esc>', '<cmd>nohlsearch<CR>', desc = 'Clear highlights on search' }
map { '<leader>q', vim.diagnostic.setloclist, desc = 'Diagnostic Quickfix list' }

map { -- terminal
  { '<C-q>', '<C-\\><C-n>', desc = 'Exit terminal mode', mode = 't' },
  { '<esc><esc>', '<C-\\><C-n>', desc = 'Exit terminal mode', mode = 't' },
}

map { -- window management
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

map { -- buffer management
  { '<leader>bl', '<cmd>bnext<cr>', desc = 'Next buffer' },
  { '<leader>bh', '<cmd>bprevious<cr>', desc = 'Previous buffer' },
  { '<leader>bD', '<cmd>%bd|e#|bd#<cr>', desc = 'Close all but the current buffer' },
}

map { -- files management
  { '<leader>fN', '<cmd>enew<cr>', desc = 'New file' },
  { '<leader>fs', '<cmd>w<cr><esc>', desc = 'Save file' },
}

-- lsp
map {
  { 'grn', vim.lsp.buf.rename, desc = 'Rename buffer' },
  { 'ga', vim.lsp.buf.code_action, desc = 'Code Action' },
  { 'gd', function() Snacks.picker.lsp_definitions() end, desc = 'Goto Definition' },
  { 'gD', function() Snacks.picker.lsp_declarations() end, desc = 'Goto Declaration' },
  { 'grr', function() Snacks.picker.lsp_references() end, desc = 'References', nowait = true },
  { 'gi', function() Snacks.picker.lsp_implementations() end, desc = 'Goto Implementation' },
  { 'gt', function() Snacks.picker.lsp_type_definitions() end, desc = 'Goto T[y]pe Definition' },
  { '<leader>ls', function() Snacks.picker.lsp_symbols() end, desc = 'LSP Symbols' },
  { '<leader>lS', function() Snacks.picker.lsp_workspace_symbols() end, desc = 'LSP Workspace Symbols' },
}

-- snacks
map {
  -- Top Pickers & Explorer
  { '<leader><space>', function() Snacks.picker.smart() end, desc = 'Smart Find Files' },
  { '<leader>,', function() Snacks.picker.buffers() end, desc = 'Buffers' },
  { '<leader>/', function() Snacks.picker.grep() end, desc = 'Grep' },
  { '<leader>:', function() Snacks.picker.command_history() end, desc = 'Command History' },
  { '<leader>n', function() Snacks.picker.notifications() end, desc = 'Notification History' },
  -- files
  { '<leader>fb', function() Snacks.picker.buffers() end, desc = 'Buffers' },
  { '<leader>fc', function() Snacks.picker.files { cwd = vim.fn.stdpath 'config' } end, desc = 'Find Config File' },
  { '<leader>ff', function() Snacks.picker.files() end, desc = 'Find Files' },
  { '<leader>fg', function() Snacks.picker.git_files() end, desc = 'Find Git Files' },
  { '<leader>fp', function() Snacks.picker.projects() end, desc = 'Projects' },
  { '<leader>fr', function() Snacks.picker.recent() end, desc = 'Recent' },

  -- git
  { '<leader>gb', function() Snacks.picker.git_branches() end, desc = 'Git Branches' },
  { '<leader>gl', function() Snacks.picker.git_log() end, desc = 'Git Log' },
  { '<leader>gL', function() Snacks.picker.git_log_line() end, desc = 'Git Log Line' },
  { '<leader>gs', function() Snacks.picker.git_status() end, desc = 'Git Status' },
  { '<leader>gS', function() Snacks.picker.git_stash() end, desc = 'Git Stash' },
  { '<leader>gd', function() Snacks.picker.git_diff() end, desc = 'Git Diff (Hunks)' },
  { '<leader>gf', function() Snacks.picker.git_log_file() end, desc = 'Git Log File' },

  -- Grep
  { '<leader>sb', function() Snacks.picker.lines() end, desc = 'Buffer Lines' },
  { '<leader>sB', function() Snacks.picker.grep_buffers() end, desc = 'Grep Open Buffers' },
  { '<leader>sg', function() Snacks.picker.grep() end, desc = 'Grep' },
  { '<leader>sw', function() Snacks.picker.grep_word() end, desc = 'Visual selection or word' },
  -- search
  { '<leader>sr"', function() Snacks.picker.registers() end, desc = 'Registers' },
  { '<leader>s/', function() Snacks.picker.search_history() end, desc = 'Search History' },
  { '<leader>sb', function() Snacks.picker.lines() end, desc = 'Buffer Lines' },
  { '<leader>sc', function() Snacks.picker.command_history() end, desc = 'Command History' },
  { '<leader>sC', function() Snacks.picker.commands() end, desc = 'Commands' },
  { '<leader>sd', function() Snacks.picker.diagnostics() end, desc = 'Diagnostics' },
  { '<leader>sD', function() Snacks.picker.diagnostics_buffer() end, desc = 'Buffer Diagnostics' },
  { '<leader>sh', function() Snacks.picker.help() end, desc = 'Help Pages' },
  { '<leader>sH', function() Snacks.picker.highlights() end, desc = 'Highlights' },
  { '<leader>si', function() Snacks.picker.icons() end, desc = 'Icons' },
  { '<leader>sj', function() Snacks.picker.jumps() end, desc = 'Jumps' },
  { '<leader>sk', function() Snacks.picker.keymaps() end, desc = 'Keymaps' },
  { '<leader>sl', function() Snacks.picker.loclist() end, desc = 'Location List' },
  { '<leader>sm', function() Snacks.picker.marks() end, desc = 'Marks' },
  { '<leader>sM', function() Snacks.picker.man() end, desc = 'Man Pages' },
  { '<leader>sp', function() Snacks.picker.lazy() end, desc = 'Search for Plugin Spec' },
  { '<leader>sq', function() Snacks.picker.qflist() end, desc = 'Quickfix List' },
  { '<leader>sR', function() Snacks.picker.resume() end, desc = 'Resume' },
  { '<leader>su', function() Snacks.picker.undo() end, desc = 'Undo History' },
  -- LSP
  { 'gd', function() Snacks.picker.lsp_definitions() end, desc = 'Goto Definition' },
  { 'gD', function() Snacks.picker.lsp_declarations() end, desc = 'Goto Declaration' },
  { 'gr', function() Snacks.picker.lsp_references() end, desc = 'References', nowait = true },
  { 'gi', function() Snacks.picker.lsp_implementations() end, desc = 'Goto Implementation' },
  { 'gt', function() Snacks.picker.lsp_type_definitions() end, desc = 'Goto T[y]pe Definition' },
  { '<leader>ss', function() Snacks.picker.lsp_symbols() end, desc = 'LSP Symbols' },
  { '<leader>sS', function() Snacks.picker.lsp_workspace_symbols() end, desc = 'LSP Workspace Symbols' },
  -- zen
  { '<leader>z', function() Snacks.zen() end, desc = 'Toggle Zen Mode' },
  { '<leader>Z', function() Snacks.zen.zoom() end, desc = 'Toggle Zoom' },
  -- buffers
  { '<leader>b.', function() Snacks.scratch() end, desc = 'Toggle Scratch Buffer' },
  { '<leader>bs', function() Snacks.scratch.select() end, desc = 'Select Scratch Buffer' },
  { '<leader>bd', function() Snacks.bufdelete() end, desc = 'Delete Buffer' },
  -- ui
  { '<leader>uC', function() Snacks.picker.colorschemes() end, desc = 'Colorschemes' },
  -- git
  { '<leader>gB', function() Snacks.gitbrowse() end, desc = 'Git Browse', mode = { 'n', 'v' } },
  { '<leader>gg', function() Snacks.lazygit() end, desc = 'Lazygit' },
  { '<leader>un', function() Snacks.notifier.hide() end, desc = 'Dismiss All Notifications' },
  { '<c-/>', function() Snacks.terminal() end, desc = 'Toggle Terminal' },
  { '<c-`>', function() Snacks.terminal() end, desc = 'which_key_ignore' },
  -- refactoring
  { '<leader>rf', function() Snacks.rename.rename_file() end, desc = 'Rename File' },
  -- navigation
  { ']]', function() Snacks.words.jump(vim.v.count1) end, desc = 'Next Reference', mode = { 'n', 't' } },
  { '[[', function() Snacks.words.jump(-vim.v.count1) end, desc = 'Prev Reference', mode = { 'n', 't' } },
}

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = false }),
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client:supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
      map {
        '<leader>th',
        function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }) end,
        desc = 'Toggle Inlay Hints',
        buffer = event.buf,
      }
    end
  end,
})

-- snack toggles
vim.api.nvim_create_autocmd('VimEnter', {
  group = vim.api.nvim_create_augroup('SnacksToggles', { clear = true }),
  -- pattern = 'VeryLazy',
  callback = function()
    -- snacks toggles
    -- SEE: https://github.com/folke/snacks.nvim/blob/main/docs/toggle.md
    Snacks.toggle.option('spell', { name = 'Spelling' }):map '<leader>us'
    Snacks.toggle.option('wrap', { name = 'Wrap' }):map '<leader>uw'
    Snacks.toggle.option('relativenumber', { name = 'Relative Number', notify = false }):map '<leader>uL'
    Snacks.toggle.option('background', { off = 'light', on = 'dark', name = 'Dark Background' }):map '<leader>ub'
    Snacks.toggle.option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }, {}):map '<leader>uc'
    -- color column toggle
    Snacks.toggle.option('colorcolumn', { off = '', on = '+1', name = 'Color Column', global = true, notify = false }):map '<leader>uv'
    -- cursor column toggle
    -- SEE: https://neovim.io/doc/user/options.html#'cursorcolumn'
    Snacks.toggle.option('cursorcolumn', { name = 'Cursor Column', global = true, notify = false }):map '<leader>uV'
    Snacks.toggle.diagnostics():map '<leader>ud'
    Snacks.toggle.line_number():map '<leader>ul'
    Snacks.toggle.treesitter():map '<leader>uT'
    Snacks.toggle.inlay_hints():map '<leader>uh'
    Snacks.toggle.indent():map '<leader>ug'
    Snacks.toggle.dim():map '<leader>uD'
  end,
})
