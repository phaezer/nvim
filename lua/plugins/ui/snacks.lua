-- snacks, A collection of small QoL plugins for Neovim.
-- src: https://github.com/folke/snacks.nvim

return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    explorer = {
      enabled = true,
      replace_netrw = true,
    },
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
            icon = ' ',
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
          { icon = '󰒲 ', key = 'L', desc = 'Lazy', action = ':Lazy', enabled = package.loaded.lazy ~= nil },
          { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
        },
      },
    },
    bigfile = { enabled = true },
    -- see: https://github.com/folke/snacks.nvim/blob/main/docs/indent.md
    indent = {
      enabled = true,
      indent = {
        char = '│',
        only_scope = false,
        only_current = false,
        hl = {
          'IndentRainbowDim0',
          'IndentRainbowDim1',
          'IndentRainbowDim2',
          'IndentRainbowDim3',
          'IndentRainbowDim4',
          'IndentRainbowDim5',
          'IndentRainbowDim6',
          'IndentRainbowDim7',
        },
      },
      scope = {
        enabled = true, -- enable highlighting the current scope
        priority = 200,
        char = '│',
        underline = false,    -- underline the start of the scope
        only_current = false, -- only show scope in the current window
        hl = {
          'IndentRainbowBright0',
          'IndentRainbowBright1',
          'IndentRainbowBright2',
          'IndentRainbowBright3',
          'IndentRainbowBright4',
          'IndentRainbowBright5',
          'IndentRainbowBright6',
          'IndentRainbowBright7',
        },
      },
      animate = { enabled = false }, -- disable animations
    },
    input = { enabled = true },
    notifier = {
      enabled = true,
      timeout = 3000, -- 3 seconds
    },
    picker = {
      layout = {
        hidden = { 'input' },
      },
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
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    styles = {                -- see: https://github.com/folke/snacks.nvim/blob/main/docs/styles.md
      notification = {
        wo = { wrap = true }, -- Wrap notifications
      },
      -- cmd input above cursor
      input = {
        relative = 'cursor',
        row = -3,
        col = 0,
      },
    },
    sources = {
      explorer = {
        layout = {
          preset = 'sidebar',
          preview = false,
        },
        supports_live = true,
        tree = true,
        watch = true,
        win = {
          input = {
            keys = {
              ['T'] = { 'tab', mode = { 'i', 'n' } }, -- open file in new tab
            },
          },
          list = {
            keys = {
              ['<BS>'] = 'explorer_up',
              ['l'] = 'confirm',
              ['h'] = 'explorer_close', -- close directory
              ['a'] = 'explorer_add',
              ['d'] = 'explorer_del',
              ['r'] = 'explorer_rename',
              ['c'] = 'explorer_copy',
              ['m'] = 'explorer_move',
              ['o'] = 'explorer_open', -- open with system application
              ['P'] = 'toggle_preview',
              ['y'] = { 'explorer_yank', mode = { 'n', 'x' } },
              ['p'] = 'explorer_paste',
              ['u'] = 'explorer_update',
              ['<c-c>'] = 'tcd',
              ['<leader>/'] = 'picker_grep',
              ['<c-t>'] = 'terminal',
              ['.'] = 'explorer_focus',
              ['I'] = 'toggle_ignored',
              ['H'] = 'toggle_hidden',
              ['Z'] = 'explorer_close_all',
              [']g'] = 'explorer_git_next',
              ['[g'] = 'explorer_git_prev',
              [']d'] = 'explorer_diagnostic_next',
              ['[d'] = 'explorer_diagnostic_prev',
              [']w'] = 'explorer_warn_next',
              ['[w'] = 'explorer_warn_prev',
              [']e'] = 'explorer_error_next',
              ['[e'] = 'explorer_error_prev',
              ['T'] = 'tab', -- open file in new tab
            },
          },
        },
      },
    },
  },

  init = function()
    vim.api.nvim_create_autocmd('User', {
      pattern = 'VeryLazy',
      callback = function()
        -- set the hl groups
        local toggle = Snacks.toggle

        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
        vim.print = _G.dd -- Override print to use snacks for `:=` command

        -- toggle mappings
        -- see: https://github.com/folke/snacks.nvim/blob/main/docs/toggle.md
        toggle.option('spell', { name = 'Spelling' }):map '<leader>us'
        toggle.option('wrap', { name = 'Wrap' }):map '<leader>uw'
        toggle.option('relativenumber', { name = 'Relative Number' }):map '<leader>uL'
        toggle.option('background', { off = 'light', on = 'dark', name = 'Dark Background' }):map '<leader>ub'
        toggle.option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map '<leader>uc'

        -- color column toggle
        toggle.option('colorcolumn', { off = '', on = '+1', name = 'Color Column', global = true }):map '<leader>uv'

        -- cusror column toggle
        -- see: https://neovim.io/doc/user/options.html#'cursorcolumn'
        toggle.option('cursorcolumn', { name = 'Cursor Column', global = true }):map '<leader>uV'

        toggle.diagnostics():map '<leader>ud'
        toggle.line_number():map '<leader>ul'
        toggle.treesitter():map '<leader>uT'
        toggle.inlay_hints():map '<leader>uh'
        toggle.indent():map '<leader>ug'
        toggle.dim():map '<leader>uD'
      end,
    })
  end,

  keys = {
    -- Top Pickers & Explorer
    {
      '<leader>e',
      function()
        Snacks.explorer()
      end,
      desc = 'File Explorer',
    },
    {
      '<leader><space>',
      function()
        Snacks.picker.smart()
      end,
      desc = 'Smart Find Files',
    },
    {
      '<leader>,',
      function()
        Snacks.picker.buffers()
      end,
      desc = 'Buffers',
    },
    {
      '<leader>/',
      function()
        Snacks.picker.grep()
      end,
      desc = 'Grep',
    },
    {
      '<leader>:',
      function()
        Snacks.picker.command_history()
      end,
      desc = 'Command History',
    },
    {
      '<leader>n',
      function()
        Snacks.picker.notifications()
      end,
      desc = 'Notification History',
    },

    -- files
    {
      '<leader>fb',
      function()
        Snacks.picker.buffers()
      end,
      desc = 'Buffers',
    },
    {
      '<leader>fc',
      function()
        Snacks.picker.files { cwd = vim.fn.stdpath 'config' }
      end,
      desc = 'Find Config File',
    },
    {
      '<leader>ff',
      function()
        Snacks.picker.files()
      end,
      desc = 'Find Files',
    },
    {
      '<leader>fg',
      function()
        Snacks.picker.git_files()
      end,
      desc = 'Find Git Files',
    },
    {
      '<leader>fp',
      function()
        Snacks.picker.projects()
      end,
      desc = 'Projects',
    },
    {
      '<leader>fr',
      function()
        Snacks.picker.recent()
      end,
      desc = 'Recent',
    },

    -- git
    {
      '<leader>gb',
      function()
        Snacks.picker.git_branches()
      end,
      desc = 'Git Branches',
    },
    {
      '<leader>gl',
      function()
        Snacks.picker.git_log()
      end,
      desc = 'Git Log',
    },
    {
      '<leader>gL',
      function()
        Snacks.picker.git_log_line()
      end,
      desc = 'Git Log Line',
    },
    {
      '<leader>gs',
      function()
        Snacks.picker.git_status()
      end,
      desc = 'Git Status',
    },
    {
      '<leader>gS',
      function()
        Snacks.picker.git_stash()
      end,
      desc = 'Git Stash',
    },
    {
      '<leader>gd',
      function()
        Snacks.picker.git_diff()
      end,
      desc = 'Git Diff (Hunks)',
    },
    {
      '<leader>gf',
      function()
        Snacks.picker.git_log_file()
      end,
      desc = 'Git Log File',
    },

    -- Grep
    {
      '<leader>sb',
      function()
        Snacks.picker.lines()
      end,
      desc = 'Buffer Lines',
    },
    {
      '<leader>sB',
      function()
        Snacks.picker.grep_buffers()
      end,
      desc = 'Grep Open Buffers',
    },
    {
      '<leader>sg',
      function()
        Snacks.picker.grep()
      end,
      desc = 'Grep',
    },
    {
      '<leader>sw',
      function()
        Snacks.picker.grep_word()
      end,
      desc = 'Visual selection or word',
      mode = { 'n', 'x' },
    },

    -- search
    {
      '<leader>sr"',
      function()
        Snacks.picker.registers()
      end,
      desc = 'Registers',
    },
    {
      '<leader>s/',
      function()
        Snacks.picker.search_history()
      end,
      desc = 'Search History',
    },
    {
      '<leader>sa',
      function()
        Snacks.picker.autocmds()
      end,
      desc = 'Autocmds',
    },
    {
      '<leader>sb',
      function()
        Snacks.picker.lines()
      end,
      desc = 'Buffer Lines',
    },
    {
      '<leader>sc',
      function()
        Snacks.picker.command_history()
      end,
      desc = 'Command History',
    },
    {
      '<leader>sC',
      function()
        Snacks.picker.commands()
      end,
      desc = 'Commands',
    },
    {
      '<leader>sd',
      function()
        Snacks.picker.diagnostics()
      end,
      desc = 'Diagnostics',
    },
    {
      '<leader>sD',
      function()
        Snacks.picker.diagnostics_buffer()
      end,
      desc = 'Buffer Diagnostics',
    },
    {
      '<leader>sh',
      function()
        Snacks.picker.help()
      end,
      desc = 'Help Pages',
    },
    {
      '<leader>sH',
      function()
        Snacks.picker.highlights()
      end,
      desc = 'Highlights',
    },
    {
      '<leader>si',
      function()
        Snacks.picker.icons()
      end,
      desc = 'Icons',
    },
    {
      '<leader>sj',
      function()
        Snacks.picker.jumps()
      end,
      desc = 'Jumps',
    },
    {
      '<leader>sk',
      function()
        Snacks.picker.keymaps()
      end,
      desc = 'Keymaps',
    },
    {
      '<leader>sl',
      function()
        Snacks.picker.loclist()
      end,
      desc = 'Location List',
    },
    {
      '<leader>sm',
      function()
        Snacks.picker.marks()
      end,
      desc = 'Marks',
    },
    {
      '<leader>sM',
      function()
        Snacks.picker.man()
      end,
      desc = 'Man Pages',
    },
    {
      '<leader>sp',
      function()
        Snacks.picker.lazy()
      end,
      desc = 'Search for Plugin Spec',
    },
    {
      '<leader>sq',
      function()
        Snacks.picker.qflist()
      end,
      desc = 'Quickfix List',
    },
    {
      '<leader>sR',
      function()
        Snacks.picker.resume()
      end,
      desc = 'Resume',
    },
    {
      '<leader>su',
      function()
        Snacks.picker.undo()
      end,
      desc = 'Undo History',
    },

    -- LSP
    {
      'gd',
      function()
        Snacks.picker.lsp_definitions()
      end,
      desc = 'Goto Definition',
    },
    {
      'gD',
      function()
        Snacks.picker.lsp_declarations()
      end,
      desc = 'Goto Declaration',
    },
    {
      'gr',
      function()
        Snacks.picker.lsp_references()
      end,
      desc = 'References',
      nowait = true,
    },
    {
      'gi',
      function()
        Snacks.picker.lsp_implementations()
      end,
      desc = 'Goto Implementation',
    },
    {
      'gt',
      function()
        Snacks.picker.lsp_type_definitions()
      end,
      desc = 'Goto T[y]pe Definition',
    },
    {
      '<leader>ss',
      function()
        Snacks.picker.lsp_symbols()
      end,
      desc = 'LSP Symbols',
    },
    {
      '<leader>sS',
      function()
        Snacks.picker.lsp_workspace_symbols()
      end,
      desc = 'LSP Workspace Symbols',
    },

    -- zen
    {
      '<leader>z',
      function()
        Snacks.zen()
      end,
      desc = 'Toggle Zen Mode',
    },
    {
      '<leader>Z',
      function()
        Snacks.zen.zoom()
      end,
      desc = 'Toggle Zoom',
    },

    -- buffers
    {
      '<leader>b.',
      function()
        Snacks.scratch()
      end,
      desc = 'Toggle Scratch Buffer',
    },
    {
      '<leader>bs',
      function()
        Snacks.scratch.select()
      end,
      desc = 'Select Scratch Buffer',
    },
    {
      '<leader>bd',
      function()
        Snacks.bufdelete()
      end,
      desc = 'Delete Buffer',
    },

    -- ui
    {
      '<leader>uC',
      function()
        Snacks.picker.colorschemes()
      end,
      desc = 'Colorschemes',
    },

    -- git
    {
      '<leader>gB',
      function()
        Snacks.gitbrowse()
      end,
      desc = 'Git Browse',
      mode = { 'n', 'v' },
    },
    {
      '<leader>gg',
      function()
        Snacks.lazygit()
      end,
      desc = 'Lazygit',
    },
    {
      '<leader>un',
      function()
        Snacks.notifier.hide()
      end,
      desc = 'Dismiss All Notifications',
    },
    {
      '<c-/>',
      function()
        Snacks.terminal()
      end,
      desc = 'Toggle Terminal',
    },
    {
      '<c-`>',
      function()
        Snacks.terminal()
      end,
      desc = 'which_key_ignore',
    },

    -- refactoring
    {
      '<leader>rf',
      function()
        Snacks.rename.rename_file()
      end,
      desc = 'Rename File',
    },

    -- navigation
    {
      ']]',
      function()
        Snacks.words.jump(vim.v.count1)
      end,
      desc = 'Next Reference',
      mode = { 'n', 't' },
    },
    {
      '[[',
      function()
        Snacks.words.jump(-vim.v.count1)
      end,
      desc = 'Prev Reference',
      mode = { 'n', 't' },
    },
  },
}
