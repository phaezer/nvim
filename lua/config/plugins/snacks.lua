local hl = require 'config.highlights'

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
