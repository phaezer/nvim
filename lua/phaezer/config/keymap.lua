---@diagnostic disable: inject-field
local map = require('phaezer.core.keys').map

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

map {
  mode = { 'i', 'c' },
  -- alt esc chords
  { 'jk', '<esc>', desc = 'Exit insert mode' },
  { 'kj', '<esc>', desc = 'Exit insert mode' },
}

map {
  mode = 'n',
  expr = true,
  { 'k', 'v:count == 0 ? "gk" : "k"', desc = 'Move up' },
  { 'j', 'v:count == 0 ? "gj" : "j"', desc = 'Move down' },
}

-- indent and keep selection
map {
  mode = 'v',
  { '<', '<gv', desc = 'Indent left' },
  { '>', '>gv', desc = 'Indent right' },
}

-- use h,j,k,l to nav in insert mode
map {
  mode = 'i',
  { '<A-h>', '<Left>', desc = 'Move left' },
  { '<A-j>', '<Down>', desc = 'Move down' },
  { '<A-k>', '<Up>', desc = 'Move up' },
  { '<A-l>', '<Right>', desc = 'Move right' },
}

-- move lines up and down
map { -- normal mode move current line
  mode = 'n',
  { '<A-j>', '<cmd> m+ <CR>', desc = 'Move current line down' },
  { '<A-k>', '<cmd> m-- <CR>', desc = 'Move current line up' },
}
map { -- visual mode, move selected lines
  mode = 'v',
  { '<A-j>', ":m '>+1<CR>gv=gv", desc = 'Move move selected line down' },
  { '<A-k>', ":m '<-2<CR>gv=gv", desc = 'Move move selected lines up' },
}

-- map $ and ^ to more natural keys
map {
  mode = { 'n', 'x', 'o' },
  { 'gl', '$', desc = 'Move to start of line' },
  { 'gh', '^', desc = 'Move to end of line' },
}

-- inspections
map {
  mode = 'n',
  prefix = '<leader>i',
  { 't', '<CMD>InspectTree<CR>', desc = 'Inspect TS tree' },
  { 'i', '<CMD>Inspect<CR>', desc = 'Inspect' },
}

-- window management
map {
  mode = 'n',
  prefix = '<leader>w',
  { 's', '<CMD>split<CR>', desc = 'Horizontal split' },
  { 'v', '<CMD>vsplit<CR>', desc = 'Vertical split' },
  { 'c', '<CMD>close<CR>', desc = 'Close window' },
  { 'T', '<CMD>wincmd T<CR>', desc = 'Move window to new tab' },
  { 'r', '<CMD>wincmd r<CR>', desc = 'Rotate window down/right' },
  { 'R', '<CMD>wincmd R<CR>', desc = 'Rotate window up/left' },
  { 'H', '<CMD>wincmd H<CR>', desc = 'Move window left' },
  { 'J', '<CMD>wincmd J<CR>', desc = 'Move window down' },
  { 'K', '<CMD>wincmd K<CR>', desc = 'Move window up' },
  { 'L', '<CMD>wincmd L<CR>', desc = 'Move window right' },
  { 'k', '<CMD>resize +5<CR>', desc = 'Increase window height' },
  { 'j', '<CMD>resize -5<CR>', desc = 'Decrease window height' },
  { 'h', '<CMD>vertical resize +5<CR>', desc = 'Increase window width' },
  { 'l', '<CMD>vertical resize -3<CR>', desc = 'Decrease window width' },
  { '=', '<CMD>wincmd =<CR>', desc = 'Windows Equalize size' },
}

-- remap window switching keys
map {
  mode = 'n',
  { '<C-h>', '<CMD>wincmd h<CR>', desc = 'GoTo to window left' },
  { '<C-j>', '<CMD>wincmd j<CR>', desc = 'GoTo to window down' },
  { '<C-k>', '<CMD>wincmd k<CR>', desc = 'GoTo to window up' },
  { '<C-l>', '<CMD>wincmd l<CR>', desc = 'GoTo to window right' },
}

-- buffer management
map {
  mode = 'n',
  prefix = '<leader>b',
  { 'l', '<CMD>bnext<CR>', desc = 'Next buffer' },
  { 'h', '<CMD>bprevious<CR>', desc = 'Previous buffer' },
  { 'd', '<CMD>%bd|e#|bd#<CR>', desc = 'Close all but the current buffer' },
  { 'N', '<CMD>enew<CR>', desc = 'New buffer' },
}

-- file ops
map {
  mode = 'n',
  prefix = '<leader>f',
  { 'r', vim.cmd.checktime, desc = 'Refresh files' },
}

-- terminal
map {
  mode = 't',
  {
    '<C-q>',
    vim.api.nvim_replace_termcodes('<C-\\><C-N>', true, true, true),
    desc = 'Exit terminal mode',
  },
}

local esc = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)

-- comments
map {
  prefix = '<A-/>',
  {
    '',
    function()
      require('Comment.api').toggle.linewise.current()
    end,
    desc = 'Comment line',
    mode = { 'i', 'n' },
  },
  {
    '',
    function()
      vim.api.nvim_feedkeys(esc, 'nx', false)
      require('Comment.api').locked 'toggle.linewise'(vim.fn.visualmode())
    end,
    desc = 'Comment line',
    mode = 'x',
  },
}
map {
  prefix = 'ic',
  { '', require('vim._comment').textobject, desc = 'Uncomment commented lines', mode = 'o' },
  {
    '',
    function()
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<esc>', true, true, true), 'nx', false)
      require('vim._comment').textobject()
    end,
    desc = 'Select commented lines',
    mode = 'x',
  },
}

-- UI management
map {
  mode = 'n',
  prefix = '<leader>u',
  {
    'u',
    function()
      if vim.opt.cursorline._value == true then
        vim.opt.cursorline = false
      else
        vim.opt.cursorline = true
      end
    end,
    desc = 'Toggle CursorLine',
  },
  {
    'U',
    function()
      if vim.opt.cursorcolumn._value == true then
        vim.opt.cursorcolumn = false
      else
        vim.opt.cursorcolumn = true
      end
    end,
    desc = 'Toggle CursorColumn',
  },
  {
    'i',
    function()
      vim.lsp.inlay_hint.endable(not vim.lsp.inlay_hint.is_enabled { 0 }, { 0 })
    end,
    desc = 'Toggle LSP inlay hints',
  },
  { 't', '<CMD>TSToggle highlight<CR>', desc = 'Toggle TS highlights' },
  { 'm', '<CMD>Markview toggle<CR>', desc = 'Toggle preview of buffer | Markview' },
}

map {
  mode = 'n',
  prefix = '<leader>l',
  {
    'i',
    function()
      vim.lsp.inlay_hint.endable(not vim.lsp.inlay_hint.is_enabled { 0 }, { 0 })
    end,
    desc = 'Toggle LSP inlay hints',
  },
  {
    'd',
    function()
      vim.diagnostic.enabled(not vim.diagnosic.is_enabled())
    end,
    desc = 'Toggle diagnostics',
  },
}

-- misc. normal mode maps
map {
  mode = 'n',
  { 's', '<Nop>', desc = 'stop deleting characters when using surrounds' },
  { '<esc>', '<CMD>nohlsearch<CR>', desc = 'Clear highlights on search' },
  { '<leader>q', vim.diagnostic.setloclist, desc = 'Diagnostic Quickfix list' },

  -- cut/copy/paste
  { 'x', '"_x', desc = 'Single x no register' },
  { '<leader>d', '"_d', desc = 'Delete no register' },

  -- undo/redo
  { '<S-u>', '<CMD>undo<CR>', desc = 'Undo' },
  { '<M-u>', '<CMD>earlier 1f<CR>', desc = 'Undo to last saved' },
  { '<M-r>', '<CMD>later 1f<CR>', desc = 'Undo to last saved' },

  -- macro key remap
  { 'q', '<Nop>' },
  { 'Q', 'q', desc = 'Record macro' },
  { '<C-Q>', 'Q', desc = 'Replay macro' },

  -- buffer management
  { '<C-s>', '<CMD>w<CR>', desc = 'Write Buffer' },

  -- move up and down half a screen and then center
  { '<C-u>', '<C-u>zz', desc = 'Go up half screen' },
  { '<C-u>', '<C-u>zz', desc = 'Go up half screen' },
}
