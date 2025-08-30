local hl = require 'phaezer.config.highlights'
local icons = require 'phaezer.core.icons'

return {
  'folke/snacks.nvim',
  lazy = false,
  -- event = 'VeryLazy',
  priority = 500,
  opts = {
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
          {
            icon = icons.kind.File .. ' ',
            key = 'n',
            desc = 'New File',
            action = ':ene | startinsert',
          },
          {
            icon = ' ',
            key = 'g',
            desc = 'Find Text',
            action = ":lua Snacks.dashboard.pick('live_grep')",
          },
          {
            icon = icons.gui.Files .. ' ',
            key = 'r',
            desc = 'Recent Files',
            action = ":lua Snacks.dashboard.pick('oldfiles')",
          },
          {
            icon = icons.gui.Config .. ' ',
            key = 'c',
            desc = 'Config',
            action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
          },
          { icon = icons.gui.Lazy .. ' ', key = 'l', desc = 'Lazy', action = '<Cmd>Lazy<cr>' },
          { icon = icons.gui.Mason .. ' ', key = 'm', desc = 'Mason', action = '<Cmd>Mason<cr>' },
          {
            icon = icons.gui.Undo .. ' ',
            key = 's',
            desc = 'Restore Session',
            section = 'session',
          },
          { icon = icons.gui.Quit .. ' ', key = 'q', desc = 'Quit', action = ':qa' },
        },
      },
      sections = {
        { section = 'header' },
        {
          icon = icons.gui.Keyboard .. ' ',
          title = 'Keymaps',
          section = 'keys',
          indent = 2,
          padding = 1,
        },
        {
          icon = icons.gui.File .. ' ',
          title = 'Recent Files',
          section = 'recent_files',
          indent = 2,
          padding = 1,
        },
        {
          icon = icons.gui.FolderOpen .. ' ',
          title = 'Projects',
          section = 'projects',
          indent = 2,
          padding = 1,
        },
      },
    },
    explorer = { enabled = false },
    bigfile = { enabled = true },
    -- SEE: https://github.com/folke/snacks.nvim/blob/main/docs/indent.md
    indent = {
      enabled = true,
      indent = {
        char = '│',
        only_scope = false,
        only_current = false,
        hl = hl.rainbow.names.indent,
      },
      scope = {
        enabled = true, -- enable highlighting the current scope
        priority = 200,
        char = '│',
        underline = false, -- underline the start of the scope
        only_current = false, -- only show scope in the current window
        hl = hl.rainbow.names.delimiters,
      },
      animate = { enabled = false }, -- disable animations
    },
    input = { enabled = true },
    notifier = {
      enabled = true,
      timeout = 3000, -- 3 seconds
    },
    image = {
      enabled = true,
      -- image resolving for obsidian
      -- SRC: https://github.com/obsidian-nvim/obsidian.nvim/wiki/Images
      resolve = function(path, src)
        if require('obsidian.api').path_is_note(path) then
          return require('obsidian.api').resolve_image_path(src)
        end
      end,
    },
    picker = {
      prompt = '󰅂 ',
      enabled = true, -- use telescope w/ fzf instead
      ui_select = false, -- don't replace `vim.ui.select` with the snacks picker
      icons = {
        files = {
          enabled = true, -- show file icons
          dir = icons.gui.Folder .. ' ',
          dir_open = icons.gui.FolderOpen .. ' ',
          file = icons.gui.File .. ' ',
        },
        keymaps = {
          nowait = '󰅒 ',
        },
        diagnostics = icons.diagnostics,
        git = {
          commit = icons.git.Commit,
          conflict = icons.git.Confict,
          staged = icons.git.Staged,
          added = icons.git.Added,
          deleted = icons.git.Removed,
          modified = icons.git.Modified,
          ignored = icons.git.Ignored,
          unstaged = icons.git.Unstaged,
          renamed = icons.git.Renamed,
          untracked = icons.git.Untracked,
        },
        kinds = icons.kind,
      },
    },
    terminal = { enabled = false },
  },
  init = function()
    local map = require('phaezer.core.keys').map
    map {
      prefix = '<leader>',
      -- Top Pickers & Explorer
      { '<space>', function() Snacks.picker.smart() end, desc = 'Smart Find Files' },
      { ',', function() Snacks.picker.buffers() end, desc = 'Buffers' },
      { ':', function() Snacks.picker.command_history() end, desc = 'Command History' },
      { 'n', function() Snacks.picker.notifications() end, desc = 'Notification History' },
      -- Buffers
      { 'bb', function() Snacks.picker.buffers() end, desc = 'Find Buffers' },
      -- git
      { 'gL', function() Snacks.picker.git_log_line() end, desc = 'Git Log Line' },
      { 'gS', function() Snacks.picker.git_stash() end, desc = 'Git Stash' },
      { 'gb', function() Snacks.picker.git_branches() end, desc = 'Git Branches' },
      { 'gd', function() Snacks.picker.git_diff() end, desc = 'Git Diff (Hunks)' },
      { 'gf', function() Snacks.picker.git_log_file() end, desc = 'Git Log File' },
      { 'gl', function() Snacks.picker.git_log() end, desc = 'Git Log' },
      { 'gs', function() Snacks.picker.git_status() end, desc = 'Git Status' },
      -- Find
      { 'fB', function() Snacks.picker.grep_buffers() end, desc = 'Grep Open Buffers' },
      {
        'fw',
        function() Snacks.picker.grep_word() end,
        desc = 'Find word',
      },
      { 'f/', function() Snacks.picker.search_history() end, desc = 'Search History' },
      { 'ff', function() Snacks.picker.files() end, desc = 'Find Files' },
      { 'fg', function() Snacks.picker.git_files() end, desc = 'Find Git Files' },
      { 'fp', function() Snacks.picker.projects() end, desc = 'Find Projects' },
      { 'fr', function() Snacks.picker.recent() end, desc = 'Find Recent' },
      {
        'fc',
        function() Snacks.picker.files { cwd = vim.fn.stdpath 'config' } end,
        desc = 'Find Config File',
      },
      { 'fC', function() Snacks.picker.commands() end, desc = 'Commands' },
      { 'fD', function() Snacks.picker.diagnostics_buffer() end, desc = 'Buffer Diagnostics' },
      { 'fH', function() Snacks.picker.highlights() end, desc = 'Highlights' },
      { 'fM', function() Snacks.picker.man() end, desc = 'Man Pages' },
      { 'fR', function() Snacks.picker.resume() end, desc = 'Resume' },
      { 'fl', function() Snacks.picker.lines() end, desc = 'Buffer Lines' },
      { 'fc', function() Snacks.picker.command_history() end, desc = 'Command History' },
      { 'fd', function() Snacks.picker.diagnostics() end, desc = 'Diagnostics' },
      { 'fg', function() Snacks.picker.grep() end, desc = 'Grep' },
      { 'fh', function() Snacks.picker.help() end, desc = 'Help Pages' },
      { 'fi', function() Snacks.picker.icons() end, desc = 'Icons' },
      { 'fj', function() Snacks.picker.jumps() end, desc = 'Jumps' },
      { 'fk', function() Snacks.picker.keymaps() end, desc = 'Keymaps' },
      { 'fL', function() Snacks.picker.loclist() end, desc = 'Location List' },
      { 'fm', function() Snacks.picker.marks() end, desc = 'Marks' },
      { 'fp', function() Snacks.picker.lazy() end, desc = 'Search for Plugin Spec' },
      { 'fq', function() Snacks.picker.qflist() end, desc = 'Quickfix List' },
      { 'fr', function() Snacks.picker.registers() end, desc = 'Find Registers' },
      { 'fs', function() Snacks.picker.lsp_symbols() end, desc = 'Find LSP Symbols' },
      {
        'fS',
        function() Snacks.picker.lsp_workspace_symbols() end,
        desc = 'LSP Workspace Symbols',
      },
      { 'fu', function() Snacks.picker.undo() end, desc = 'Undo History' },
      -- zen
      { 'z', function() Snacks.zen() end, desc = 'Toggle Zen Mode' },
      { 'Z', function() Snacks.zen.zoom() end, desc = 'Toggle Zoom' },
      -- buffers
      { 'b.', function() Snacks.scratch() end, desc = 'Toggle Scratch Buffer' },
      { 'bs', function() Snacks.scratch.select() end, desc = 'Select Scratch Buffer' },
      { 'bd', function() Snacks.bufdelete() end, desc = 'Delete Buffer' },
      -- ui
      { 'uC', function() Snacks.picker.colorschemes() end, desc = 'Colorschemes' },
      { 'un', function() Snacks.notifier.hide() end, desc = 'Dismiss All Notifications' },
      -- git
      { 'gB', function() Snacks.gitbrowse() end, desc = 'Git Browse', mode = { 'n', 'v' } },
      { 'gL', function() Snacks.lazygit() end, desc = 'Lazygit' },
    }

    map {
      -- LSP GoTo
      { 'gd', function() Snacks.picker.lsp_definitions() end, desc = 'LSP Definitions' },
      { 'gD', function() Snacks.picker.lsp_declarations() end, desc = 'LSP Declaration' },
      {
        'gR',
        function() Snacks.picker.lsp_references() end,
        desc = 'LSP References',
        nowait = true,
      },
      { 'gi', function() Snacks.picker.lsp_implementations() end, desc = 'LSP Implementation' },
      { 'gy', function() Snacks.picker.lsp_type_definitions() end, desc = 'LSP Type Definition' },
      -- navigation
      {
        ']]',
        function() Snacks.words.jump(vim.v.count1) end,
        desc = 'Next Reference',
        mode = { 'n', 't' },
      },
      {
        '[[',
        function() Snacks.words.jump(-vim.v.count1) end,
        desc = 'Prev Reference',
        mode = { 'n', 't' },
      },
    }
  end,
}
