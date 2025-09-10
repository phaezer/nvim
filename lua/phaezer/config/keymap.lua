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
  { 'k', 'v:count == 0 ? "gk" : "k"', desc = 'move up' },
  { 'j', 'v:count == 0 ? "gj" : "j"', desc = 'move down' },
}

-- indent and keep selection
map {
  mode = 'v',
  { '<', '<gv', desc = 'indent left' },
  { '>', '>gv', desc = 'indent right' },
}

-- use h,j,k,l to nav in insert mode
map {
  mode = 'i',
  { '<A-h>', '<Left>', desc = 'move left' },
  { '<A-j>', '<Down>', desc = 'move down' },
  { '<A-k>', '<Up>', desc = 'move up' },
  { '<A-l>', '<Right>', desc = 'move right' },
}

-- alt key bindings in normal mode
map { -- normal mode move current line
  mode = 'n',
  -- move lines up and down
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
  { 's', '<CMD>split<CR>', desc = 'split ' },
  { 'v', '<CMD>vsplit<CR>', desc = 'split |' },
  { 'q', '<CMD>close<CR>', desc = 'close' },
  { 'T', '<CMD>wincmd T<CR>', desc = 'move to new tab' },
  { 'r', '<CMD>wincmd r<CR>', desc = 'rotate ' },
  { 'R', '<CMD>wincmd R<CR>', desc = 'rotate ' },
  { 'H', '<CMD>wincmd H<CR>', desc = 'move 󰜱' },
  { 'J', '<CMD>wincmd J<CR>', desc = 'move 󰜮' },
  { 'K', '<CMD>wincmd K<CR>', desc = 'move 󰜷' },
  { 'L', '<CMD>wincmd L<CR>', desc = 'move 󰜴' },
  { 'k', '<CMD>resize +5<CR>', desc = ' height' },
  { 'j', '<CMD>resize -5<CR>', desc = ' height' },
  { 'h', '<CMD>vertical resize +5<CR>', desc = ' width' },
  { 'l', '<CMD>vertical resize -3<CR>', desc = ' width' },
  { '=', '<CMD>wincmd =<CR>', desc = ' width' },
}

-- remap window switching keys
map {
  mode = 'n',
  -- switch windows
  { '<C-h>', '<cmd>wincmd h<cr>', desc = ' 󰜱' },
  { '<C-j>', '<cmd>wincmd j<cr>', desc = ' 󰜮' },
  { '<C-k>', '<cmd>wincmd k<cr>', desc = ' 󰜷' },
  { '<C-l>', '<cmd>wincmd l<cr>', desc = ' 󰜴' },
  -- move windows
  { '<A-S-h>', '<cmd>wincmd h<cr>', desc = 'move  󰜱' },
  { '<A-S-j>', '<cmd>wincmd j<cr>', desc = 'move  󰜮' },
  { '<A-S-k>', '<cmd>wincmd k<cr>', desc = 'move  󰜷' },
  { '<A-S-l>', '<cmd>wincmd h<cr>', desc = 'move  󰜴' },
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

-- file ops
map {
  mode = 'n',
  prefix = '<leader>f',
  { 'r', vim.cmd.checktime, desc = 'refresh files' },
}

-- terminal
map {
  mode = 't',
  {
    '<C-q>',
    vim.api.nvim_replace_termcodes('<C-\\><C-N>', true, true, true),
    desc = 'exit terminal mode',
  },
}

local esc = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)

-- comments
map {
  prefix = '<c-/>',
  {
    '',
    function()
      require('Comment.api').toggle.linewise.current()
    end,
    desc = 'comment line  Comment',
    mode = { 'i', 'n' },
  },
  {
    '',
    function()
      vim.api.nvim_feedkeys(esc, 'nx', false)
      require('Comment.api').locked 'toggle.linewise'(vim.fn.visualmode())
    end,
    desc = 'comment line  Comment',
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
    desc = 'select commented lines',
    mode = 'x',
  },
}

-- visuals
map {
  mode = 'n',
  prefix = '<leader>v',
  {
    'c',
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
    'C',
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
}

-- lsp
map {
  mode = 'n',
  prefix = '<leader>l',
  {
    'h',
    function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { 0 }, { 0 })
    end,
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
  { '<C-s>', '<cmd>write<cr>', desc = 'write buffer' },
}

-- actions / leader k
map {
  mode = 'n',
  prefix = '<leader>k',
  { 'w', '<cmd>write<cr>', desc = 'write buffer' },
  { 'q', '<cmd>quit<cr>', desc = 'quit window' },
  {
    '/',
    function()
      require('Comment.api').toggle.linewise.current()
    end,
    desc = 'comment line  Comment',
  },
  { 'i', '<CMD>Inspect<CR>', desc = 'Inspect' },
  { 't', '<cmd>TSToggle highlight<cr>', desc = 'toggle TS highlights' },
  {
    'd',
    function()
      vim.diagnostic.enabled(not vim.diagnostic.is_enabled())
    end,
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
  { '<leader>d', '"_d', desc = 'Delete no register' },

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
  prefix = '<leader>',
  plugin = 'Neo-tree',
  { 'E', '<cmd>Neotree filesystem reveal<cr>', desc = 'File Explorer' },
  { 'ee', '<cmd>Neotree filesystem reveal<cr>', desc = 'File Explorer' },
  { 'eh', '<cmd>Neotree reveal left<cr>', desc = 'Neo-tree left' },
  { 'el', '<cmd>Neotree reveal left<cr>', desc = 'Neo-tree right' },
  { 'ef', '<cmd>Neotree reveal float<cr>', desc = 'Neo-tree float' },
  { 'eb', '<cmd>Neotree buffers reveal<cr>', desc = 'Buffer Explorer' },
  {
    'es',
    '<cmd>Neotree document_symbols reveal<cr>',
    desc = 'Symbol Explorer',
  },
  {
    'eg',
    '<cmd>Neotree git_status reveal<cr>',
    desc = 'Git Status Explorer',
  },
}

-- sessions
-- NOTE: currently using mini.sessions
map {
  mode = 'n',
  prefix = '<leader>ks',
  {
    'r',
    function()
      require('mini.sessions').select 'read'
    end,
    desc = 'select session',
    plugin = 'mini.sessions',
  },
  {
    'w',
    function()
      require('mini.sessions').write()
    end,
    desc = 'write session',
    plugin = 'mini.sessions',
  },
  {
    'd',
    function()
      require('mini.sessions').write 'delete'
    end,
    desc = 'delete session',
    plugin = 'mini.sessions',
  },
  {
    'n',
    function()
      local session_name = vim.fn.input('Session Name:', '', '')
      require('mini.sessions').write(session_name, { verbose = true })
    end,
    desc = 'new sessions',
    plugin = 'mini.sessions',
  },
  {
    'b',
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
-- NOTE: currently using toggleterm for nvim terminals
map {
  mode = { 'n', 'i' },
  plugin = 'ToggleTerm',
  {
    '<C-`>',
    '<cmd<ToggleTerm direction=horizontal<cr>',
    desc = 'toggle horizontal Terminal',
  },
}

map {
  mode = 'n',
  prefix = '<leader>t',
  plugin = 'ToggleTerm',
  {
    '<C-\\>',
    '<cmd<ToggleTerm direction=vertical<cr>',
    desc = 'toggle horizontal Terminal',
  },
  {
    'f',
    '<cmd>ToggleTerm direction=float<cr>',
    desc = 'toggle floating terminal',
    mode = 'n',
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
    mode = 'n',
  },
}

-- refactoring
map {
  mode = 'n',
  prefix = '<leader>r',
  {
    'n',
    function()
      return ':IncRename ' .. vim.fn.expand '<cword>'
    end,
    expr = true,
    desc = 'rename identifier',
    plugin = 'inc-rename',
  },
}

-- ft specific key maps (leader a)
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'yaml' },
  callback = function()
    map {
      mode = 'n',
      buffer = true,
      { '<leader>ar', '<cmd>AnsibleRunFile<cr>', desc = 'Run Ansible Playbook' },
    }
  end,
})

-- ft specific key maps
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'http', 'rest' },
  callback = function()
    map {
      mode = 'n',
      buffer = true,
      plugin = 'kulala',
      prefix = '<leader>a',
      { '<leader>s', desc = 'Send request' },
      { '<leader>a', desc = 'Send all requests' },
      { '<leader>b', desc = 'Open scratchpad' },
    }
  end,
})
