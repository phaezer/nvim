local hl = require 'phaezer.config.highlights'
local icons = require 'phaezer.core.icons'

return {
  'folke/snacks.nvim',
  lazy = false,
  dependencies = { 'folke/trouble.nvim' },
  -- event = 'VeryLazy',
  priority = 500,
  opts = function(_, opts)
    return {
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
          -- char = '▎',
          only_scope = false,
          only_current = false,
          hl = hl.rainbow.names.indent,
        },
        scope = {
          enabled = true, -- enable highlighting the current scope
          priority = 200,
          -- char = '▏',
          char = '│',
          underline = false, -- underline the start of the scope
          only_current = false, -- only show scope in the current window
          hl = hl.rainbow.names.delimiters,
        },
        chunk = {
          enabled = false,
          priority = 200,
          hl = hl.rainbow.names.delimiters,
          char = {
            -- corner_top = '┌',
            -- corner_bottom = '└',
            corner_top = '╭',
            corner_bottom = '╰',
            horizontal = '─',
            vertical = '│',
            arrow = '─',
          },
        },
        animate = { enabled = false }, -- disable animations
      },
      input = { enabled = false },
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
        prompt = ' ',
        enabled = true, -- use telescope w/ fzf instead
        ui_select = false, -- don't replace `vim.ui.select` with the snacks picker
        actions = require('trouble.sources.snacks').actions,
        win = {
          input = {
            keys = {
              ['<C-t>'] = { 'trouble_open', mode = { 'n', 'i' } },
            },
          },
        },
        icons = {
          files = {
            enabled = true, -- show file icons
            dir = icons.gui.Folder .. ' ',
            dir_open = icons.gui.FolderOpen .. ' ',
            file = icons.gui.File .. ' ',
          },
          ui = {
            live = '󰐰 ',
            hidden = '',
            ignored = '',
            follow = '',
            selected = '● ',
            unselected = '○ ',
          },
          keymaps = {
            nowait = '󰅒 ',
          },
          lsp = {
            unavailable = '',
            enabled = ' ',
            disabled = ' ',
            attached = '󱘖 ',
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
      terminal = { enabled = false }, -- using toggleterm instead
      quickfile = { enabled = false }, -- can be buggy.
    }
  end,
  init = function()
    local map = require('phaezer.core.keys').map

    map {
      prefix = '<leader>',
      plugin = 'snacks',
      -- Top Pickers & Explorer
      { '<space>', function() Snacks.picker.smart() end, desc = 'smart ' },
      { ',', function() Snacks.picker.buffers() end, desc = 'buffers' },
      { ':', function() Snacks.picker.command_history() end, desc = ' history' },
      -- zen
      { 'z', function() Snacks.zen() end, desc = 'zen mode' },
      { 'Z', function() Snacks.zen.zoom() end, desc = 'toggle zoom' },
      { "'", function() Snacks.picker.marks() end, desc = 'search marks' },
      { 'h', function() Snacks.dashboard() end, desc = 'home dashboard' },
    }

    -- git
    map {
      prefix = '<leader>g',
      plugin = 'snacks',
      { 'b', function() Snacks.picker.git_branches() end, desc = 'git branches' },
      { 'd', function() Snacks.picker.git_diff() end, desc = 'git diff (hunks)' },
      { 'f', function() Snacks.picker.git_log_file() end, desc = 'git log file' },
      { 'i', function() Snacks.picker.git_log_line() end, desc = 'git log line' },
      { 'l', function() Snacks.picker.git_log() end, desc = 'git log' },
      { 's', function() Snacks.picker.git_status() end, desc = 'git status' },
      { 't', function() Snacks.picker.git_stash() end, desc = 'git stash' },
      { 'x', function() Snacks.gitbrowse() end, desc = 'git browse' },
      { 'z', function() Snacks.lazygit() end, desc = 'LazyGit' },
    }

    -- search
    map {
      prefix = '<leader>s',
      plugin = 'snacks',
      { '/', function() Snacks.picker.search_history() end, desc = 'search history' },
      { ':', function() Snacks.picker.commands() end, desc = 'commands' },
      { 'R', function() Snacks.picker.resume() end, desc = 'resume' },
      { 'Z', function() Snacks.picker.lazy() end, desc = 'search for plugin Spec' },
      { 'c', function() Snacks.picker.colorschemes() end, desc = 'grep' },
      { 'g', function() Snacks.picker.grep() end, desc = 'grep' },
      { 'h', function() Snacks.picker.help() end, desc = 'help pages' },
      { 'h', function() Snacks.picker.highlights() end, desc = 'highlights' },
      { 'i', function() Snacks.picker.icons() end, desc = 'icons' },
      { 'j', function() Snacks.picker.jumps() end, desc = 'jumps' },
      { 'k', function() Snacks.picker.keymaps() end, desc = 'keymap' },
      { 'l', function() Snacks.picker.loclist() end, desc = 'location list' },
      { 'm', function() Snacks.picker.man() end, desc = 'man pages' },
      { 'n', function() Snacks.picker.notifications() end, desc = 'notifications' },
      { 'p', function() Snacks.picker.projects() end, desc = 'projects' },
      { 'q', function() Snacks.picker.qflist() end, desc = 'quickfix list' },
      { 'r', function() Snacks.picker.registers() end, desc = 'registers' },
      { 's', function() Snacks.picker.treesitter() end, desc = 'TS symbols' },
      { 'u', function() Snacks.picker.undo() end, desc = 'undo history' },
      { 'w', function() Snacks.picker.grep_word() end, desc = 'find word' },
      { 'z', function() Snacks.picker.zoxide() end, desc = 'zoxide' },
    }

    -- files
    map {
      prefix = '<leader>f',
      plugin = 'snacks',
      { 'f', function() Snacks.picker.files() end, desc = 'files' },
      { 'r', function() Snacks.picker.recent() end, desc = 'recent' },
      {
        'c',
        function() Snacks.picker.files { cwd = vim.fn.stdpath 'config' } end,
        desc = 'find config File',
      },
      { 'g', function() Snacks.picker.git_files() end, desc = 'git files' },
    }

    -- lsp
    map {
      prefix = '<leader>l',
      plugin = 'snacks',
      { 'x', function() Snacks.picker.diagnostics() end, desc = 'diagnostics' },
      { 's', function() Snacks.picker.lsp_symbols() end, desc = 'LSP symbols' },
      {
        'w',
        function() Snacks.picker.lsp_workspace_symbols() end,
        desc = 'LSP workspace symbols',
      },
    }

    -- buffers
    map {
      prefix = '<leader>b',
      plugin = 'snacks',
      { '.', function() Snacks.scratch() end, desc = 'scratch buffer' },
      { 'd', function() Snacks.bufdelete() end, desc = 'delete buffer' },
      { 'x', function() Snacks.picker.diagnostics_buffer() end, desc = 'diagnostics' },
      { 'g', function() Snacks.picker.grep_buffers() end, desc = 'grep open buffers' },
      { 'i', function() Snacks.picker.lines() end, desc = 'buffer lines' },
      { 's', function() Snacks.scratch.select() end, desc = 'select scratch buffer' },
    }

    -- actions
    map {
      prefix = '<leader>k',
      plugin = 'snacks',
      { 'n', function() Snacks.notifier.hide() end, desc = 'dismiss notifications' },
    }

    map {
      mode = 'n',
      prefix = 'g',
      plugin = 'snacks',
      { 'd', function() Snacks.picker.lsp_definitions() end, desc = 'LSP definitions' },
      {
        'D',
        function() Snacks.picker.lsp_declarations() end,
        desc = 'LSP declaration',
      },
      {
        'R',
        function() Snacks.picker.lsp_references() end,
        desc = 'LSP References',
        nowait = true,
      },
      {
        'i',
        function() Snacks.picker.lsp_implementations() end,
        desc = 'LSP implementation',
      },
      {
        'y',
        function() Snacks.picker.lsp_type_definitions() end,
        desc = 'LSP type definition',
      },
    }

    -- navigation
    map {
      mode = { 'n', 't' },
      plugin = 'snacks',
      {
        ']]',
        function() Snacks.words.jump(vim.v.count1) end,
        desc = 'next reference',
        mode = { 'n', 't' },
      },
      {
        '[[',
        function() Snacks.words.jump(-vim.v.count1) end,
        desc = 'prev reference',
        mode = { 'n', 't' },
      },
    }
  end,
}
