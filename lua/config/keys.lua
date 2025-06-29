-- set custom keymaps here

---@type key_table[]
return {
  -- Remap for dealing with visual line wraps
  { 'k',           'v:count == 0 ? "gk" : "k"',   desc = 'Move up',                         expr = true },
  { 'j',           'v:count == 0 ? "gj" : "j"',   desc = 'Move down',                       expr = true },
  -- Keep selection while indenting
  { '<',           '<gv',                         desc = 'Indent left',                     mode = 'v' },
  { '>',           '>gv',                         desc = 'Indent right',                    mode = 'v' },
  { 'jk',          '<esc>',                       desc = 'Exit insert mode',                mode = 'i' },
  -- Clear highlights on search
  { '<esc>',       '<cmd>nohlsearch<CR>',         desc = 'Clear highlights on search' },
  -- Open diagnostic [Q]uickfix list
  { '<leader>q',   vim.diagnostic.setloclist,     desc = 'Open diagnostic [Q]uickfix list' },

  -- terminal
  { '<C-q>',       '<C-\\><C-n>',                 desc = 'Exit terminal mode',              mode = 't' },
  { '<esc><esc>',  '<C-\\><C-n>',                 desc = 'Exit terminal mode',              mode = 't' },

  -- window
  { '<leader>ws',  '<cmd>split<cr>',              desc = 'Horizontal split', },
  { '<leader>wv',  '<cmd>vsplit<cr>',             desc = 'Vertical split', },
  { '<leader>wc',  '<cmd>close<cr>',              desc = 'Close window', },
  { '<leader>wT',  '<cmd>wincmd T<cr>',           desc = 'Move window to new tab', },
  { '<leader>wr',  '<cmd>wincmd r<cr>',           desc = 'Rotate window down/right', },
  { '<leader>wR',  '<cmd>wincmd R<cr>',           desc = 'Rotate window up/left', },
  { '<leader>wh',  '<cmd>wincmd h<cr>',           desc = 'Switch to window left', },
  { '<leader>wj',  '<cmd>wincmd j<cr>',           desc = 'Switch to window below', },
  { '<leader>wk',  '<cmd>wincmd k<cr>',           desc = 'Switch to window above', },
  { '<leader>wl',  '<cmd>wincmd l<cr>',           desc = 'Switch to window right', },
  { '<leader>wH',  '<cmd>wincmd H<cr>',           desc = 'Move window left', },
  { '<leader>wJ',  '<cmd>wincmd J<cr>',           desc = 'Move window down', },
  { '<leader>wK',  '<cmd>wincmd K<cr>',           desc = 'Move window up', },
  { '<leader>wL',  '<cmd>wincmd L<cr>',           desc = 'Move window right', },
  { '<leader>wwk', '<cmd>vertical resize +3<cr>', desc = 'Increase window height', },
  { '<leader>wwj', '<cmd>vertical resize -3<cr>', desc = 'Decrease window height', },
  { '<leader>wwH', '<cmd>resize +3<cr>',          desc = 'Increase window width', },
  { '<leader>wwL', '<cmd>resize -3<cr>',          desc = 'Decrease window width', },
  { '<leader>w=',  '<cmd>wincmd =<cr>',           desc = 'Windows Equalize size', },

  -- buffers
  { '<leader>bl',  '<cmd>bnext<cr>',              desc = 'Next buffer' },
  { '<leader>bh',  '<cmd>bprevious<cr>',          desc = 'Previous buffer' },
  { '<leader>bD',  '<cmd>%bd|e#|bd#<cr>',         desc = 'Close all but the current buffer' },

  -- files
  { '<leader>fN',  '<cmd>enew<cr>',               desc = 'New file' },
  { '<leader>fs',  '<cmd>w<cr><esc>',             desc = 'Save file' },
}
