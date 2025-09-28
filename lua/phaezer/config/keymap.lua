---@diagnostic disable: inject-field
local map = require('phaezer.core.keys').map

-- cSpell:words mapleader maplocalleader gitsigns inlay hints lspselect
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

map {
  mode = { 'i', 'c' },
  -- alt esc chords
  { 'jk', '<esc>', desc = 'Exit insert mode' },
  { 'kj', '<esc>', desc = 'Exit insert mode' },
}

-- move lines up and down in normal mode
map {
  mode = 'n',
  map = {
    expr = true,
    { 'k', 'v:count == 0 ? "gk" : "k"', desc = 'move up' },
    { 'j', 'v:count == 0 ? "gj" : "j"', desc = 'move down' },
  },
}

-- indent and keep selection
map {
  mode = 'v',
  { '<', '<gv', desc = 'indent left' },
  { '>', '>gv', desc = 'indent right' },
}

-- searching
map {
  { mode = 'x', '<leader>/', '<esc>/\\%V', desc = 'search within selected' },
  { mode = 'v', '//', 'y/<C-R>"<CR>N', desc = 'search with selected' },
}

-- use h,j,k,l to nav in insert mode
map {
  mode = 'i',
  { '<A-h>', '<Left>', desc = 'move left' },
  { '<A-j>', '<Down>', desc = 'move down' },
  { '<A-k>', '<Up>', desc = 'move up' },
  { '<A-l>', '<Right>', desc = 'move right' },
}

map {
  mode = 'n',
  { '<A-j>', '<cmd> m+ <CR>', desc = 'move current line down' },
  { '<A-k>', '<cmd> m-- <CR>', desc = 'move current line up' },
}

-- visual mode, move selected lines
map {
  mode = 'v',
  { '<A-j>', ":m '>+1<CR>gv=gv", desc = 'move move selected line down' },
  { '<A-k>', ":m '<-2<CR>gv=gv", desc = 'move move selected lines up' },
}

-- map $, ^, and % to more natural keys
map {
  mode = { 'n', 'x', 'o' },
  { 'gl', '$', desc = 'move to start of line' },
  { 'gh', '^', desc = 'move to end of line' },
  { 'gb', '%', desc = 'move to matching bracket' },
}

-- inspections
map {
  mode = 'n',
  prefix = '<leader>i',
  { 't', '<CMD>InspectTree<CR>', desc = 'inspect TS tree' },
  { 'i', '<CMD>Inspect<CR>', desc = 'inspect' },
}

-- window management
-- cSpell:words wincmd vsplit
map {
  mode = 'n',
  prefix = '<leader>w',
  { 's', '<CMD>split<CR>', desc = 'split ' },
  { 'v', '<CMD>vsplit<CR>', desc = 'split |' },
  { 'q', '<CMD>close<CR>', desc = 'close' },
  { 't', '<CMD>wincmd T<CR>', desc = 'move to new tab' },
  { 'h', '<CMD>wincmd H<CR>', desc = 'move 󰜱' },
  { 'j', '<CMD>wincmd J<CR>', desc = 'move 󰜮' },
  { 'k', '<CMD>wincmd K<CR>', desc = 'move 󰜷' },
  { 'l', '<CMD>wincmd L<CR>', desc = 'move 󰜴' },
}

-- remap window switching keys
map {
  mode = 'n',
  -- switch windows
  { '<C-h>', '<cmd>wincmd h<cr>', desc = ' 󰜱' },
  { '<C-j>', '<cmd>wincmd j<cr>', desc = ' 󰜮' },
  { '<C-k>', '<cmd>wincmd k<cr>', desc = ' 󰜷' },
  { '<C-l>', '<cmd>wincmd l<cr>', desc = ' 󰜴' },
}

-- buffer management
map {
  mode = 'n',
  prefix = '<leader>b',
  { 'l', '<cmd>bnext<cr>', desc = 'next buffer' },
  { 'h', '<cmd>bprevious<cr>', desc = 'previous buffer' },
  { 'D', '<cmd>%bd|e#|bd#<cr>', desc = 'Close all but the current buffer' },
  { 'n', '<cmd>enew<cr>', desc = 'new buffer' },
}

-- terminal
map {
  mode = 't',
  {
    '<C-q>',
    vim.api.nvim_replace_termcodes('<C-\\><C-N>', true, true, true),
    desc = 'exit terminal mode',
  },
  {
    '<esc><esc>',
    vim.api.nvim_replace_termcodes('<C-\\><C-N>', true, true, true),
    desc = 'exit terminal mode',
  },
}

local esc = vim.api.nvim_replace_termcodes('<esc>', true, false, true)

-- comments
map {
  plugin = 'Comment',
  {
    '<c-/>',
    function() require('Comment.api').toggle.linewise.current() end,
    desc = 'comment line',
    mode = { 'i', 'n' },
  },
  {
    '<c-/>',
    function()
      vim.api.nvim_feedkeys(esc, 'nx', false)
      require('Comment.api').locked 'toggle.linewise'(vim.fn.visualmode())
    end,
    desc = 'comment line',
    mode = 'x',
  },
  {
    '<leader>/',
    function() require('Comment.api').toggle.linewise.current() end,
    desc = 'comment line',
  },
  { 'ic', require('vim._comment').textobject, desc = 'Uncomment commented lines', mode = 'o' },
  {
    'ic',
    function()
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<esc>', true, true, true), 'nx', false)
      require('vim._comment').textobject()
    end,
    desc = 'select commented lines',
    mode = 'x',
  },
}

-- visuals
map {
  mode = 'n',
  prefix = '<leader>u',
  {
    'h',
    function()
      if vim.opt.cursorline._value == true then
        vim.opt.cursorline = false
      else
        vim.opt.cursorline = true
      end
    end,
    desc = 'toggle cursorline',
  },
  {
    'j',
    function()
      if vim.opt.cursorcolumn._value == true then
        vim.opt.cursorcolumn = false
      else
        vim.opt.cursorcolumn = true
      end
    end,
    desc = 'toggle cursorcolumn',
  },
  { 't', '<cmd>TSToggle highlight<cr>', desc = 'toggle TS highlights' },
  {
    'll',
    function() vim.o.list = not vim.o.list end,
    desc = 'toggle list chars',
  },
  {
    'lm',
    function()
      local icons = require 'phaezer.core.icons'
      vim.opt.listchars = icons.listchars {
        'extends',
        'precedes',
        'nbsp',
        'trail',
      }
      vim.o.list = true
    end,
    desc = 'enable minimal listchars',
  },
  {
    'la',
    function()
      local icons = require 'phaezer.core.icons'
      vim.opt.listchars = icons.listchars 'all'
      vim.o.list = true
    end,
    desc = 'enable all listchars',
  },
  {
    'x',
    function() vim.o.conceallevel = vim.o.conceallevel ~= 1 and 1 or 0 end,
    desc = 'toggle conceal level1',
  },
  {
    'c',
    function() vim.o.conceallevel = vim.o.conceallevel ~= 2 and 2 or 0 end,
    desc = 'toggle conceal level2',
  },
  {
    'w',
    function() vim.o.wrap = not vim.o.wrap end,
    desc = 'toggle conceal level2',
  },
  {
    'r',
    function() vim.o.relativenumber = not vim.o.relativenumber end,
    desc = 'toggle relativenumber',
  },
}

-- lsp
map {
  mode = 'n',
  prefix = '<leader>l',
  {
    'h',
    function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { 0 }, { 0 }) end,
    desc = 'toggle inlay hints',
  },
  {
    'l',
    '<cmd>ToggleLSPSelect<cr>',
    desc = 'Toggle on/off an LSP',
  },
}

map {
  mode = { 'n', 'i' },
  { '<A-w>', '<cmd>write<cr>', desc = 'write buffer' },
  { '<C-w>', '<cmd>write<cr>', desc = 'write buffer' },
}

-- actions / leader k
map {
  mode = 'n',
  prefix = '<leader>k',
  { 'r', vim.cmd.checktime, desc = 'refresh files' },
  { 'w', '<cmd>write<cr>', desc = 'write buffer' },
  { 'q', '<cmd>quit<cr>', desc = 'quit window' },

  { 'i', '<CMD>Inspect<CR>', desc = 'Inspect' },
  { 't', '<cmd>TSToggle highlight<cr>', desc = 'toggle TS highlights' },
  {
    '?',
    function() vim.diagnostic.enabled(not vim.diagnostic.is_enabled()) end,
    desc = 'toggle diagnostics',
  },
}

-- misc. normal mode maps
map {
  mode = 'n',
  { '<esc>', '<CMD>nohlsearch<CR>', desc = 'clear highlights on search' },
  { '<leader>q', vim.diagnostic.setloclist, desc = 'diagnostic Quickfix list' },

  -- cut/copy/paste
  { 'x', '"_x', desc = 'single x no register' },
  { '<leader>kd', '"_d', desc = 'Delete no register' },

  -- undo/redo
  { '<A-u>', '<cmd>earlier 1f<cr>', desc = 'undo to last saved' },
  { '<A-r>', '<cmd>later 1f<cr>', desc = 'undo to last saved' },

  -- macro key remap
  { 'q', '<nop>', desc = 'stop spamming random macros' },
  { 'Q', 'q', desc = 'record macro' },
  { '<C-Q>', 'Q', desc = 'replay macro' },

  -- move up and down half a screen and then center
  { '<C-u>', '<C-u>zz', desc = 'go up half screen' },
}

map {
  mode = { 'n', 'v' },
  { 's', '<nop>', desc = 'stop deleting characters when using surrounds' },
}

-- explorers
map {
  mode = 'n',
  prefix = '<leader>e',
  plugin = 'Neo-tree',
  { 'e', '<cmd>Neotree filesystem reveal<cr>', desc = 'File Explorer' },
  { 'h', '<cmd>Neotree reveal left<cr>', desc = 'Neo-tree left' },
  { 'l', '<cmd>Neotree reveal left<cr>', desc = 'Neo-tree right' },
  { 'f', '<cmd>Neotree reveal float<cr>', desc = 'Neo-tree float' },
  { 'b', '<cmd>Neotree buffers reveal<cr>', desc = 'Buffer Explorer' },
  { 's', '<cmd>Neotree document_symbols reveal<cr>', desc = 'Symbol Explorer' },
  { 'g', '<cmd>Neotree git_status reveal<cr>', desc = 'Git Status Explorer' },
}

-- sessions
map {
  mode = 'n',
  prefix = '<leader>ks',
  {
    'r',
    function() require('mini.sessions').select 'read' end,
    desc = 'select session',
    plugin = 'mini.sessions',
  },
  {
    'w',
    function() require('mini.sessions').write() end,
    desc = 'write session',
    plugin = 'mini.sessions',
  },
  {
    'd',
    function() require('mini.sessions').write 'delete' end,
    desc = 'delete session',
    plugin = 'mini.sessions',
  },
  {
    'n',
    function()
      local session_name = vim.fn.input('Session Name:', '')
      require('mini.sessions').write(session_name, { verbose = true })
    end,
    desc = 'new sessions',
    plugin = 'mini.sessions',
  },
  {
    'B',
    function()
      local session_name = vim.fn.input('Buffer Session Name:', '', '')
      require('dart').write_session(session_name)
    end,
    desc = 'write buffer session',
    plugin = 'dart',
  },
  {
    'b',
    function()
      local session_name = vim.fn.input('Buffer Session Name:', '', '')
      require('dart').read_session(session_name)
    end,
    desc = 'read buffer session',
    plugin = 'dart',
  },
}

-- terminal
-- NOTE: currently using toggle term for nvim terminals
map {
  mode = { 'n', 'i', 't' },
  plugin = 'ToggleTerm',
  {
    '<C-`>',
    '<cmd>ToggleTerm direction=horizontal<cr>',
    desc = 'toggle horizontal Terminal',
  },
}

map {
  mode = 'n',
  prefix = '<leader>t',
  plugin = 'ToggleTerm',
  {
    'f',
    '<cmd>ToggleTerm direction=float<cr>',
    desc = 'toggle floating terminal',
  },
  {
    't',
    '<cmd>ToggleTerm direction=horizontal<cr>',
    desc = 'toggle horizontal Terminal',
  },
  {
    'v',
    '<cmd>ToggleTerm direction=vertical<cr>',
    desc = 'toggle Vertical Terminal',
  },
}

-- ft specific key maps (leader a)
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'yaml.ansible' },
  callback = function()
    map {
      mode = 'n',
      buffer = true,
      { '<leader>ar', '<cmd>AnsibleRunFile<cr>', desc = 'Run Ansible Playbook' },
    }
  end,
})

-- ft specific key maps (leader a)
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'markdown', 'mdx', 'md' },
  callback = function()
    map {
      mode = 'n',
      buffer = true,
      prefix = 'Table Mode',
      { '<leader>T', '<cmd>TableModeToggle<cr>', desc = 'toggle table mode' },
    }
  end,
})
