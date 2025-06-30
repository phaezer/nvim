vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- set custom keymaps here
---@type key_table[]
Core.keymap.set {
  -- common keymaps

  -- Remap for dealing with visual line wraps
  { 'k',          'v:count == 0 ? "gk" : "k"',   desc = 'Move up',                         expr = true },
  { 'j',          'v:count == 0 ? "gj" : "j"',   desc = 'Move down',                       expr = true },
  -- Keep selection while indenting
  { '<',          '<gv',                         desc = 'Indent left',                     mode = 'v' },
  { '>',          '>gv',                         desc = 'Indent right',                    mode = 'v' },
  { 'jk',         '<esc>',                       desc = 'Exit insert mode',                mode = 'i' },
  -- Clear highlights on search
  { '<esc>',      '<cmd>nohlsearch<CR>',         desc = 'Clear highlights on search' },
  -- Open diagnostic [Q]uickfix list
  { '<leader>q',  vim.diagnostic.setloclist,     desc = 'Open diagnostic [Q]uickfix list' },

  -- terminal
  { '<C-q>',      '<C-\\><C-n>',                 desc = 'Exit terminal mode',              mode = 't' },
  { '<esc><esc>', '<C-\\><C-n>',                 desc = 'Exit terminal mode',              mode = 't' },

  -- window
  { '<leader>ws', '<cmd>split<cr>',              desc = 'Horizontal split' },
  { '<leader>wv', '<cmd>vsplit<cr>',             desc = 'Vertical split' },
  { '<leader>wc', '<cmd>close<cr>',              desc = 'Close window' },
  { '<leader>wT', '<cmd>wincmd T<cr>',           desc = 'Move window to new tab' },
  { '<leader>wr', '<cmd>wincmd r<cr>',           desc = 'Rotate window down/right' },
  { '<leader>wR', '<cmd>wincmd R<cr>',           desc = 'Rotate window up/left' },
  { '<leader>wH', '<cmd>wincmd H<cr>',           desc = 'Move window left' },
  { '<leader>wJ', '<cmd>wincmd J<cr>',           desc = 'Move window down' },
  { '<leader>wK', '<cmd>wincmd K<cr>',           desc = 'Move window up' },
  { '<leader>wL', '<cmd>wincmd L<cr>',           desc = 'Move window right' },
  { '<leader>wk', '<cmd>resize +3<cr>',          desc = 'Increase window height' },
  { '<leader>wj', '<cmd>resize -3<cr>',          desc = 'Decrease window height' },
  { '<leader>wh', '<cmd>vertical resize +3<cr>', desc = 'Increase window width' },
  { '<leader>wl', '<cmd>vertical resize -3<cr>', desc = 'Decrease window width' },
  { '<leader>w=', '<cmd>wincmd =<cr>',           desc = 'Windows Equalize size' },
  { '<a-h>',      '<cmd>wincmd h<cr>',           desc = 'Switch to window left' },
  { '<a-j>',      '<cmd>wincmd j<cr>',           desc = 'Switch to window down' },
  { '<a-k>',      '<cmd>wincmd k<cr>',           desc = 'Switch to window up' },
  { '<a-l>',      '<cmd>wincmd l<cr>',           desc = 'Switch to window right' },

  -- buffers
  { '<leader>bl', '<cmd>bnext<cr>',              desc = 'Next buffer' },
  { '<leader>bh', '<cmd>bprevious<cr>',          desc = 'Previous buffer' },
  { '<leader>bD', '<cmd>%bd|e#|bd#<cr>',         desc = 'Close all but the current buffer' },

  -- files
  { '<leader>fN', '<cmd>enew<cr>',               desc = 'New file' },
  { '<leader>fs', '<cmd>w<cr><esc>',             desc = 'Save file' },
}

Core.plugin:config {
  'romgrk/barbar.nvim',
  keys = {
    { '<A-,>', '<Cmd>BufferPrevious<CR>',     desc = 'Previous buffer' },
    { '<A-.>', '<Cmd>BufferNext<CR>',         desc = 'Next buffer' },
    { '<A-<>', '<Cmd>BufferMovePrevious<CR>', desc = 'Next buffer' },
    { '<A->>', '<Cmd>BufferMoveNext<CR>',     desc = 'Next buffer' },

    -- select buffer
    { '<A-1>', '<Cmd>BufferGoto 1<CR>',       desc = 'Go to buffer 1' },
    { '<A-2>', '<Cmd>BufferGoto 2<CR>',       desc = 'Go to buffer 2' },
    { '<A-3>', '<Cmd>BufferGoto 3<CR>',       desc = 'Go to buffer 3' },
    { '<A-4>', '<Cmd>BufferGoto 4<CR>',       desc = 'Go to buffer 4' },
    { '<A-5>', '<Cmd>BufferGoto 5<CR>',       desc = 'Go to buffer 5' },
    { '<A-6>', '<Cmd>BufferGoto 6<CR>',       desc = 'Go to buffer 6' },
    { '<A-7>', '<Cmd>BufferGoto 7<CR>',       desc = 'Go to buffer 7' },
    { '<A-8>', '<Cmd>BufferGoto 8<CR>',       desc = 'Go to buffer 8' },
    { '<A-9>', '<Cmd>BufferGoto 9<CR>',       desc = 'Go to buffer 9' },
    { '<A-0>', '<Cmd>BufferGoto 10<CR>',      desc = 'Go to buffer 10' },
    -- pin / unpin
    { '<A-p>', '<Cmd>BufferPin<CR>',          desc = 'Pin buffer' },
    -- close buffer
    { '<A-c>', '<Cmd>BufferClose<CR>',        desc = 'Close buffer' },
  }
}

Core.plugin:config {
  'gbprod/yanky.nvim',
  keys = {
    {
      "<leader>p",
      function()
        Snacks.picker.yanky()
      end,
      mode = { "n", "x" },
      desc = "Open Yank History",
    },
    { "y",     "<Plug>(YankyYank)",                    desc = "Yank (copy)",                           mode = { "n", "x" } },
    { "p",     "<Plug>(YankyPutAfter)",                desc = "Paste after",                           mode = { "n", "x" } },
    { "P",     "<Plug>(YankyPutBefore)",               desc = "Paste before",                          mode = { "n", "x" } },
    { "gp",    "<Plug>(YankyGPutAfter)",               desc = "Paste after and keep cursor position",  mode = { "n", "x" } },
    { "gP",    "<Plug>(YankyGPutBefore)",              desc = "Paste before and keep cursor position", mode = { "n", "x" } },
    { "<c-p>", "<Plug>(YankyPreviousEntry)",           desc = "Yank" },
    { "<c-n>", "<Plug>(YankyNextEntry)",               desc = "Delete" },
    { "]p",    "<Plug>(YankyPutIndentAfterLinewise)",  desc = "Change" },
    { "[p",    "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Paste before indent linewise" },
    { "]P",    "<Plug>(YankyPutIndentAfterLinewise)",  desc = "Paste after indent linewise" },
    { "[P",    "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Paste before indent linewise" },
    {
      "iy",
      function()
        require("yanky.textobj").last_put()
      end,
      desc = "Paste last yanked text object",
      mode = { "o", "x" },
    }
  }
}

Core.plugin:config {
  'piersolenski/wtf.nvim',
  keys = {
    {
      "<leader>?a",
      function()
        require("wtf").ai()
      end,
      desc = "Debug diagnostic with AI",
      mode = { "n", "x" },
    },
    {
      "<leader>?s",
      function()
        require("wtf").search()
      end,
      desc = "Search diagnostic with Google",
    },
    {
      "<leader>?h",
      function()
        require("wtf").history()
      end,
      desc = "Populate the quickfix list with previous chat history",
    },
    {
      "<leader>?g",
      function()
        require("wtf").grep_history()
      end,
      desc = "Grep previous chat history with Telescope",
    },
  },
}


Core.plugin:config {
  "folke/snacks.nvim",
  keys = {
    -- Top Pickers & Explorer
    { "<leader><space>", function() Snacks.picker.smart() end,           desc = "Smart Find Files" },
    { "<leader>,",       function() Snacks.picker.buffers() end,         desc = "Buffers" },
    { "<leader>/",       function() Snacks.picker.grep() end,            desc = "Grep" },
    { "<leader>:",       function() Snacks.picker.command_history() end, desc = "Command History" },
    { "<leader>n",       function() Snacks.picker.notifications() end,   desc = "Notification History" },
    {
      "<leader>e",
      function()
        Snacks.explorer({
          win = {
            input = {
              keys = {
                ['T'] = { 'tab', mode = { 'i', 'n' } },
              }
            },
            list = {
              keys = {
                ["<BS>"] = "explorer_up",
                ["l"] = "confirm",
                ["h"] = "explorer_close", -- close directory
                ["a"] = "explorer_add",
                ["d"] = "explorer_del",
                ["r"] = "explorer_rename",
                ["c"] = "explorer_copy",
                ["m"] = "explorer_move",
                ["o"] = "explorer_open", -- open with system application
                ["P"] = "toggle_preview",
                ["y"] = { "explorer_yank", mode = { "n", "x" } },
                ["p"] = "explorer_paste",
                ["u"] = "explorer_update",
                ["<c-c>"] = "tcd",
                ["<leader>/"] = "picker_grep",
                ["<c-t>"] = "terminal",
                ["."] = "explorer_focus",
                ["I"] = "toggle_ignored",
                ["H"] = "toggle_hidden",
                ["Z"] = "explorer_close_all",
                ["]g"] = "explorer_git_next",
                ["[g"] = "explorer_git_prev",
                ["]d"] = "explorer_diagnostic_next",
                ["[d"] = "explorer_diagnostic_prev",
                ["]w"] = "explorer_warn_next",
                ["[w"] = "explorer_warn_prev",
                ["]e"] = "explorer_error_next",
                ["[e"] = "explorer_error_prev",
                ["T"] = "tab",
              },
            },
          },
        })
      end,
      desc = "File Explorer"
    },

    -- files
    { "<leader>fb",  function() Snacks.picker.buffers() end,               desc = "Buffers" },
    {
      "<leader>fc",
      function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end,
      desc = "Find Config File"
    },
    { "<leader>ff",  function() Snacks.picker.files() end,                 desc = "Find Files" },
    { "<leader>fg",  function() Snacks.picker.git_files() end,             desc = "Find Git Files" },
    { "<leader>fp",  function() Snacks.picker.projects() end,              desc = "Projects" },
    { "<leader>fr",  function() Snacks.picker.recent() end,                desc = "Recent" },

    -- git
    { "<leader>gb",  function() Snacks.picker.git_branches() end,          desc = "Git Branches" },
    { "<leader>gl",  function() Snacks.picker.git_log() end,               desc = "Git Log" },
    { "<leader>gL",  function() Snacks.picker.git_log_line() end,          desc = "Git Log Line" },
    { "<leader>gs",  function() Snacks.picker.git_status() end,            desc = "Git Status" },
    { "<leader>gS",  function() Snacks.picker.git_stash() end,             desc = "Git Stash" },
    { "<leader>gd",  function() Snacks.picker.git_diff() end,              desc = "Git Diff (Hunks)" },
    { "<leader>gf",  function() Snacks.picker.git_log_file() end,          desc = "Git Log File" },

    -- Grep
    { "<leader>sb",  function() Snacks.picker.lines() end,                 desc = "Buffer Lines" },
    { "<leader>sB",  function() Snacks.picker.grep_buffers() end,          desc = "Grep Open Buffers" },
    { "<leader>sg",  function() Snacks.picker.grep() end,                  desc = "Grep" },
    { "<leader>sw",  function() Snacks.picker.grep_word() end,             desc = "Visual selection or word", mode = { "n", "x" } },

    -- search
    { '<leader>sr"', function() Snacks.picker.registers() end,             desc = "Registers" },
    { '<leader>s/',  function() Snacks.picker.search_history() end,        desc = "Search History" },
    { "<leader>sa",  function() Snacks.picker.autocmds() end,              desc = "Autocmds" },
    { "<leader>sb",  function() Snacks.picker.lines() end,                 desc = "Buffer Lines" },
    { "<leader>sc",  function() Snacks.picker.command_history() end,       desc = "Command History" },
    { "<leader>sC",  function() Snacks.picker.commands() end,              desc = "Commands" },
    { "<leader>sd",  function() Snacks.picker.diagnostics() end,           desc = "Diagnostics" },
    { "<leader>sD",  function() Snacks.picker.diagnostics_buffer() end,    desc = "Buffer Diagnostics" },
    { "<leader>sh",  function() Snacks.picker.help() end,                  desc = "Help Pages" },
    { "<leader>sH",  function() Snacks.picker.highlights() end,            desc = "Highlights" },
    { "<leader>si",  function() Snacks.picker.icons() end,                 desc = "Icons" },
    { "<leader>sj",  function() Snacks.picker.jumps() end,                 desc = "Jumps" },
    { "<leader>sk",  function() Snacks.picker.keymaps() end,               desc = "Keymaps" },
    { "<leader>sl",  function() Snacks.picker.loclist() end,               desc = "Location List" },
    { "<leader>sm",  function() Snacks.picker.marks() end,                 desc = "Marks" },
    { "<leader>sM",  function() Snacks.picker.man() end,                   desc = "Man Pages" },
    { "<leader>sp",  function() Snacks.picker.lazy() end,                  desc = "Search for Plugin Spec" },
    { "<leader>sq",  function() Snacks.picker.qflist() end,                desc = "Quickfix List" },
    { "<leader>sR",  function() Snacks.picker.resume() end,                desc = "Resume" },
    { "<leader>su",  function() Snacks.picker.undo() end,                  desc = "Undo History" },

    -- LSP
    { "gd",          function() Snacks.picker.lsp_definitions() end,       desc = "Goto Definition" },
    { "gD",          function() Snacks.picker.lsp_declarations() end,      desc = "Goto Declaration" },
    { "gr",          function() Snacks.picker.lsp_references() end,        nowait = true,                     desc = "References" },
    { "gI",          function() Snacks.picker.lsp_implementations() end,   desc = "Goto Implementation" },
    { "gy",          function() Snacks.picker.lsp_type_definitions() end,  desc = "Goto T[y]pe Definition" },
    { "<leader>ss",  function() Snacks.picker.lsp_symbols() end,           desc = "LSP Symbols" },
    { "<leader>sS",  function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },

    -- zen
    { "<leader>z",   function() Snacks.zen() end,                          desc = "Toggle Zen Mode" },
    { "<leader>Z",   function() Snacks.zen.zoom() end,                     desc = "Toggle Zoom" },

    -- buffers
    { "<leader>b.",  function() Snacks.scratch() end,                      desc = "Toggle Scratch Buffer" },
    { "<leader>bs",  function() Snacks.scratch.select() end,               desc = "Select Scratch Buffer" },
    { "<leader>bd",  function() Snacks.bufdelete() end,                    desc = "Delete Buffer" },

    -- ui
    { "<leader>uC",  function() Snacks.picker.colorschemes() end,          desc = "Colorschemes" },

    -- git
    { "<leader>gB",  function() Snacks.gitbrowse() end,                    desc = "Git Browse",               mode = { "n", "v" } },
    { "<leader>gg",  function() Snacks.lazygit() end,                      desc = "Lazygit" },
    { "<leader>un",  function() Snacks.notifier.hide() end,                desc = "Dismiss All Notifications" },
    { "<c-/>",       function() Snacks.terminal() end,                     desc = "Toggle Terminal" },
    { "<c-`>",       function() Snacks.terminal() end,                     desc = "which_key_ignore" },

    -- refactoring
    { "<leader>rf",  function() Snacks.rename.rename_file() end,           desc = "Rename File" },

    -- navigation
    { "]]",          function() Snacks.words.jump(vim.v.count1) end,       desc = "Next Reference",           mode = { "n", "t" } },
    { "[[",          function() Snacks.words.jump(-vim.v.count1) end,      desc = "Prev Reference",           mode = { "n", "t" } },
  }
}

Core.plugin:config {
  'mfussenegger/nvim-dap',
  keys = {
    -- Basic debugging keymaps, feel free to change to your liking!
    { '<F5>',      function() require('dap').continue() end,          desc = 'Debug: Start/Continue' },
    { '<F1>',      function() require('dap').step_into() end,         desc = 'Debug: Step Into' },
    { '<F2>',      function() require('dap').step_over() end,         desc = 'Debug: Step Over' },
    { '<F3>',      function() require('dap').step_out() end,          desc = 'Debug: Step Out' },
    { '<leader>b', function() require('dap').toggle_breakpoint() end, desc = 'Debug: Toggle Breakpoint' },
    {
      '<leader>B',
      function() require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ') end,
      desc = 'Debug: Set Breakpoint'
    },
    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    { '<F7>', function() require('dapui').toggle() end, desc = 'Debug: See last session result.' },
  }
}
-- if Core.util.is_vs_code() then
--   -- VS Code specific keymaps
--   keys = vim.list_extend(keys, {
--     { '<C-s>', '<cmd>save<cr>',  desc = 'Save file',  mode = 'n' },
--     { '<C-q>', '<cmd>close<cr>', desc = 'Close file', mode = 'n' },
--     { '<C-w>', '<cmd>close<cr>', desc = 'Close file', mode = 'n' },
--   })
-- end

Core.plugin:config {
  'folke/trouble.nvim',
  keys = {
    {
      "<leader>xx",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Diagnostics (Trouble)",
    },
    {
      "<leader>xX",
      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      desc = "Buffer Diagnostics (Trouble)",
    },
    {
      "<leader>cs",
      "<cmd>Trouble symbols toggle focus=false<cr>",
      desc = "Symbols (Trouble)",
    },
    {
      "<leader>xl",
      "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
      desc = "LSP Definitions / references / ... (Trouble)",
    },
    {
      "<leader>xL",
      "<cmd>Trouble loclist toggle<cr>",
      desc = "Location List (Trouble)",
    },
    {
      "<leader>xQ",
      "<cmd>Trouble qflist toggle<cr>",
      desc = "Quickfix List (Trouble)",
    },
  }
}

Core.plugin:config {
  'gbprod/substitute.nvim',
  keys = {
    { "s",  function() require('substitute').operator() end, desc = "Substitute" },
    { "ss", function() require('substitute').line() end,     desc = "Substitute line" },
    { "S",  function() require('substitute').eol() end,      desc = "Substitute end of line" },
    { "gs", function() require('substitute').visual() end,   desc = "Substitute visual selection" },
  }
}

Core.plugin:config {
  "hedyhli/outline.nvim",
  keys = { -- Example mapping to toggle outline
    { "<leader>o", "<cmd>Outline<CR>", desc = "Toggle outline" },
  },
}

Core.plugin:config {
  'jmbuhr/otter.nvim',
  keys = {
    { '<leader>ta', function() require('otter').activate() end,   desc = 'Otter Activate' },
    { '<leader>td', function() require('otter').deactivate() end, desc = 'Otter Deactivate' },
  }
}
