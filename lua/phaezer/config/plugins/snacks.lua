local hl = require 'phaezer.config.highlights'
local keys = require 'phaezer.lib.keys'

local header = [[
  ██████╗ ██╗  ██╗ █████╗ ███████╗███████╗███████╗██████╗
  ██╔══██╗██║  ██║██╔══██╗██╔════╝╚══███╔╝██╔════╝██╔══██╗
  ██████╔╝███████║███████║█████╗    ███╔╝ █████╗  ██████╔╝
  ██╔═══╝ ██╔══██║██╔══██║██╔══╝   ███╔╝  ██╔══╝  ██╔══██╗
  ██║     ██║  ██║██║  ██║███████╗███████╗███████╗██║  ██║
  ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝╚═╝  ╚═╝]]

require('snacks').setup {
  dashboard = {
    enabled = true,
    preset = {
      header = header,
      keys = {
        { icon = ' ', key = 'f', desc = 'Find File', action = ":lua Snacks.dashboard.pick('files')" },
        { icon = ' ', key = 'n', desc = 'New File', action = ':ene | startinsert' },
        { icon = ' ', key = 'g', desc = 'Find Text', action = ":lua Snacks.dashboard.pick('live_grep')" },
        { icon = ' ', key = 'r', desc = 'Recent Files', action = ":lua Snacks.dashboard.pick('oldfiles')" },
        {
          icon = ' ',
          key = 'c',
          desc = 'Config',
          action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
        },
        { icon = ' ', key = 's', desc = 'Restore Session', section = 'session' },
        { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
      },
    },
    sections = {
      { section = 'header' },
      { icon = ' ', title = 'Keymaps', section = 'keys', indent = 2, padding = 1 },
      { icon = ' ', title = 'Recent Files', section = 'recent_files', indent = 2, padding = 1 },
      { icon = ' ', title = 'Projects', section = 'projects', indent = 2, padding = 1 },
    },
  },
  explorer = {
    enabled = false, -- disable the snacks explorer
    replace_netrw = true,
  },
  bigfile = { enabled = true },
  -- SEE: https://github.com/folke/snacks.nvim/blob/main/docs/indent.md
  indent = {
    enabled = true,
    indent = {
      char = '│',
      only_scope = false,
      only_current = false,
      hl = hl.rainbow_indent_names 'dim',
    },
    scope = {
      enabled = true, -- enable highlighting the current scope
      priority = 200,
      char = '│',
      underline = false, -- underline the start of the scope
      only_current = false, -- only show scope in the current window
      hl = hl.rainbow_indent_names 'bright',
    },
    animate = { enabled = false }, -- disable animations
  },
  input = { enabled = true },
  notifier = {
    enabled = true,
    timeout = 3000, -- 3 seconds
  },
  picker = {
    enabled = true,
    ui_select = false, -- don't replace `vim.ui.select` with the snacks picker
    icons = {
      diagnostics = {
        Error = ' ',
        Warn = ' ',
        Hint = ' ',
        Info = ' ',
      },
      git = {
        commit = '󰜘',
        conflict = '',
        staged = '',
        added = '',
        deleted = '',
        modified = '',
        ignored = '',
        unstaged = '',
        renamed = '',
        untracked = '',
      },
    },
  },
}

-- Setup some globals for debugging (lazy-loaded)
_G.dd = function(...) Snacks.debug.inspect(...) end
_G.bt = function() Snacks.debug.backtrace() end
vim.print = _G.dd -- Override print to use snacks for `:=` command

-- snacks
keys.set {
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

-- snack toggles
vim.api.nvim_create_autocmd('VimEnter', {
  group = vim.api.nvim_create_augroup('SnacksToggles', { clear = true }),
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
