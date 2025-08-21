return {
  'folke/snacks.nvim',
  lazy = false,
  -- event = 'VeryLazy',
  priority = 500,
  config = function()
    local hl = require 'phaezer.config.highlights'

    require('snacks').setup {
      dashboard = {
        enabled = true,
        preset = {
          header = [[
  ██████╗ ██╗  ██╗ █████╗ ███████╗███████╗███████╗██████╗
  ██╔══██╗██║  ██║██╔══██╗██╔════╝╚══███╔╝██╔════╝██╔══██╗
  ██████╔╝███████║███████║█████╗    ███╔╝ █████╗  ██████╔╝
  ██╔═══╝ ██╔══██║██╔══██║██╔══╝   ███╔╝  ██╔══╝  ██╔══██╗
  ██║     ██║  ██║██║  ██║███████╗███████╗███████╗██║  ██║
  ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝╚═╝  ╚═╝]],
          keys = {
            {
              icon = ' ',
              key = 'f',
              desc = 'Find File',
              action = ":lua Snacks.dashboard.pick('files')",
            },
            { icon = ' ', key = 'n', desc = 'New File', action = ':ene | startinsert' },
            {
              icon = ' ',
              key = 'g',
              desc = 'Find Text',
              action = ":lua Snacks.dashboard.pick('live_grep')",
            },
            {
              icon = ' ',
              key = 'r',
              desc = 'Recent Files',
              action = ":lua Snacks.dashboard.pick('oldfiles')",
            },
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
          {
            icon = ' ',
            title = 'Recent Files',
            section = 'recent_files',
            indent = 2,
            padding = 1,
          },
          { icon = ' ', title = 'Projects', section = 'projects', indent = 2, padding = 1 },
        },
      },
      explorer = {
        enabled = false, -- enable the snacks explorer
        replace_netrw = false,
      },
      bigfile = { enabled = true },
      -- SEE: https://github.com/folke/snacks.nvim/blob/main/docs/indent.md
      indent = {
        enabled = true,
        indent = {
          char = '│',
          only_scope = false,
          only_current = false,
          hl = hl.rainbow.names.dm,
        },
        scope = {
          enabled = true, -- enable highlighting the current scope
          priority = 200,
          char = '│',
          underline = false, -- underline the start of the scope
          only_current = false, -- only show scope in the current window
          hl = hl.rainbow.names.br,
        },
        animate = { enabled = false }, -- disable animations
      },
      input = { enabled = true },
      notifier = {
        enabled = true,
        timeout = 3000, -- 3 seconds
      },
      picker = {
        prompt = ' ',
        enabled = true, -- use telescope w/ fzf instead
        ui_select = false, -- don't replace `vim.ui.select` with the snacks picker
        -- TODO: update icons
        icons = {
          files = {
            enabled = true, -- show file icons
            dir = '󰉋 ',
            dir_open = '󰝰 ',
            file = '󰈔 ',
          },
          keymaps = {
            nowait = '󰓅 ',
          },
          diagnostics = {
            Error = ' ',
            Warn = ' ',
            Hint = ' ',
            Info = ' ',
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
          kinds = {
            Array = ' ',
            Boolean = '󰨙 ',
            Class = ' ',
            Color = ' ',
            Control = ' ',
            Collapsed = ' ',
            Constant = '󰏿 ',
            Constructor = ' ',
            Copilot = ' ',
            Enum = ' ',
            EnumMember = ' ',
            Event = ' ',
            Field = ' ',
            File = ' ',
            Folder = ' ',
            Function = '󰊕 ',
            Interface = ' ',
            Key = ' ',
            Keyword = ' ',
            Method = '󰊕 ',
            Module = ' ',
            Namespace = '󰦮 ',
            Null = ' ',
            Number = '󰎠 ',
            Object = ' ',
            Operator = ' ',
            Package = ' ',
            Property = ' ',
            Reference = ' ',
            Snippet = '󱄽 ',
            String = ' ',
            Struct = '󰆼 ',
            Text = ' ',
            TypeParameter = ' ',
            Unit = ' ',
            Unknown = ' ',
            Value = ' ',
            Variable = '󰀫 ',
          },
        },
      },

      require('phaezer.core.keys').set {
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
        { '<leader>fR', function() Snacks.rename.rename_file() end, desc = 'Rename File' },
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
        {
          '<leader>sw',
          function() Snacks.picker.grep_word() end,
          desc = 'Visual selection or word',
        },
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
        { '<leader>ss', function() Snacks.picker.lsp_symbols() end, desc = 'LSP Symbols' },
        { '<leader>sS', function() Snacks.picker.lsp_workspace_symbols() end, desc = 'LSP Workspace Symbols' },
        -- LSP GoTo
        { 'gd', function() Snacks.picker.lsp_definitions() end, desc = 'LSP Definitions' },
        { 'gD', function() Snacks.picker.lsp_declarations() end, desc = 'LSP Declaration' },
        { 'gR', function() Snacks.picker.lsp_references() end, desc = 'LSP References', nowait = true },
        { 'gi', function() Snacks.picker.lsp_implementations() end, desc = 'LSP Implementation' },
        { 'gy', function() Snacks.picker.lsp_type_definitions() end, desc = 'LSP Type Definition' },
        -- zen
        { '<leader>z', function() Snacks.zen() end, desc = 'Toggle Zen Mode' },
        { '<leader>Z', function() Snacks.zen.zoom() end, desc = 'Toggle Zoom' },
        -- buffers
        { '<leader>b.', function() Snacks.scratch() end, desc = 'Toggle Scratch Buffer' },
        { '<leader>bs', function() Snacks.scratch.select() end, desc = 'Select Scratch Buffer' },
        { '<leader>bd', function() Snacks.bufdelete() end, desc = 'Delete Buffer' },
        -- ui
        { '<leader>sC', function() Snacks.picker.colorschemes() end, desc = 'Colorschemes' },
        -- git
        { '<leader>gB', function() Snacks.gitbrowse() end, desc = 'Git Browse', mode = { 'n', 'v' } },
        { '<leader>gL', function() Snacks.lazygit() end, desc = 'Lazygit' },
        { '<leader>un', function() Snacks.notifier.hide() end, desc = 'Dismiss All Notifications' },
        { '<c-/>', function() Snacks.terminal() end, desc = 'Toggle Terminal' },
        { '<c-`>', function() Snacks.terminal() end, desc = 'which_key_ignore' },
        -- navigation
        { ']]', function() Snacks.words.jump(vim.v.count1) end, desc = 'Next Reference', mode = { 'n', 't' } },
        { '[[', function() Snacks.words.jump(-vim.v.count1) end, desc = 'Prev Reference', mode = { 'n', 't' } },
      },
    }
  end,
}
