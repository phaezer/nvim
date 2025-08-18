return {
  -- ==============================================================================================
  -- Snacks
  -- snacks.nvim is a Neovim plugin that provides a dashboard, picker, and various utilities
  -- SRC: https://github.com/folke/snacks.nvim
  -- TODO: finish snacks config
  {
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
          enabled = false,
          indent = {
            char = '│',
            only_scope = false,
            only_current = false,
            -- hl = hl.rainbow_indent_names 'dim',
          },
          scope = {
            enabled = false, -- enable highlighting the current scope
            priority = 200,
            char = '│',
            underline = false, -- underline the start of the scope
            only_current = false, -- only show scope in the current window
            -- hl = hl.rainbow_indent_names 'bright',
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
          -- LSP
          { 'gd', function() Snacks.picker.lsp_definitions() end, desc = 'Goto Definition' },
          { 'gD', function() Snacks.picker.lsp_declarations() end, desc = 'Goto Declaration' },
          { 'gr', function() Snacks.picker.lsp_references() end, desc = 'References', nowait = true },
          { 'gi', function() Snacks.picker.lsp_implementations() end, desc = 'Goto Implementation' },
          { 'gt', function() Snacks.picker.lsp_type_definitions() end, desc = 'Goto T[y]pe Definition' },
          { '<leader>ss', function() Snacks.picker.lsp_symbols() end, desc = 'LSP Symbols' },
          { '<leader>sS', function() Snacks.picker.lsp_workspace_symbols() end, desc = 'LSP Workspace Symbols' }, -- zen { '<leader>z', function() Snacks.zen() end, desc = 'Toggle Zen Mode' }, { '<leader>Z', function() Snacks.zen.zoom() end, desc = 'Toggle Zoom' }, -- buffers { '<leader>b.', function() Snacks.scratch() end, desc = 'Toggle Scratch Buffer' }, { '<leader>bs', function() Snacks.scratch.select() end, desc = 'Select Scratch Buffer' }, { '<leader>bd', function() Snacks.bufdelete() end, desc = 'Delete Buffer' },
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
        },
      }
    end,
  }, -- / Snacks
  -- ----------------------------------------------------------------------------------------------

  -- ==============================================================================================
  -- LuaLine
  -- a statusline plugin for Neovim
  -- SRC: https://github.com/nvim-lualine/lualine.nvim
  {
    'nvim-lualine/lualine.nvim',
    lazy = false,
    dependencies = {
      'bwpge/lualine-pretty-path',
    },
    config = function()
      local function clients_lsp()
        local clients = vim.lsp.get_clients()
        if next(clients) == nil then return '' end

        local c = {}
        for _, client in pairs(clients) do
          table.insert(c, client.name)
        end
        return '󱘖 ' .. table.concat(c, '|')
      end

      require('lualine').setup {
        options = {
          theme = 'auto',
          globalstatus = true,
          disabled_filetypes = {
            statusline = {
              'dashboard',
              'alpha',
              'ministarter',
              'snacks_dashboard',
              'Outline',
            },
          },
          component_separators = '|',
          section_separators = { left = '', right = '' },
        },
        sections = {
          lualine_a = {
            {
              'mode',
              separator = { left = '', right = '' },
              -- padding = { left = 1, right = 1 },
              icon = '',
            },
          },

          lualine_b = {
            { 'branch', icon = '' },
          },

          lualine_c = {
            {
              'diagnostics',
              symbols = {
                error = '',
                warn = '',
                info = '',
                hint = '',
              },
              update_in_insert = true,
            },
            { 'pretty_path' },
          },

          lualine_x = {
            {
              function() return require('noice').api.status.command.get() end,
              cond = function() return package.loaded['noice'] and require('noice').api.status.command.has() end,
              color = function() return { fg = Snacks.util.color 'Statement' } end,
            },
            {
              function() return require('noice').api.status.mode.get() end,
              cond = function() return package.loaded['noice'] and require('noice').api.status.mode.has() end,
              color = function() return { fg = Snacks.util.color 'Constant' } end,
            },
            {
              function() return ' ' .. require('dap').status() end,
              cond = function() return package.loaded['dap'] and require('dap').status() ~= '' end,
              color = function() return { fg = Snacks.util.color 'Debug' } end,
            },
            {
              'diff',
              symbols = {

                added = ' ',
                modified = ' ',
                removed = ' ',
              },
              source = function()
                local gitsigns = vim.b.gitsigns_status_dict
                if gitsigns then
                  return {
                    added = gitsigns.added,
                    modified = gitsigns.changed,
                    removed = gitsigns.removed,
                  }
                end
              end,
            },
          },

          lualine_y = {
            clients_lsp,
            { 'progress', separator = ' ', padding = { left = 1, right = 2 } },
          },

          lualine_z = {
            {
              'location',
              -- padding = { left = 0, right = 1 },
              separator = { left = '', right = '' },
              icon = '',
            },
          },
        },

        extensions = { 'neo-tree', 'lazy', 'fzf', 'trouble' },

        inactive_sections = {
          lualine_a = { 'filename' },
          lualine_b = {},
          lualine_c = { 'pretty_path' },
          lualine_x = {},
          lualine_y = {},
          lualine_z = { 'location' },
        },
      }
    end,
  }, -- / LuaLine
  -- ----------------------------------------------------------------------------------------------

  -- BufferLine
  -- SRC: https://github.com/akinsho/bufferline.nvim
  {
    'akinsho/bufferline.nvim',
    lazy = false,
    priority = 100,
    -- highlights = require('catppuccin.groups.integrations.bufferline').get(),
    opts = {
      -- close_command = 'bp|sp|bn|bd! %d',
      -- right_mouse_command = 'bp|sp|bn|bd! %d',
      left_mouse_command = 'buffer %d',
      buffer_close_icon = '',
      modified_icon = ' ',
      close_icon = ' ',
      left_trunc_marker = ' ',
      right_trunc_marker = ' ',
      max_name_length = 15,
      max_prefix_length = 13,
      tab_size = 15,
      show_buffer_icons = true,
      -- show_buffer_default_icon = true,
      show_close_icon = false,
      show_tab_indicators = true,
      indicator = {
        style = 'icon',
        icon = '', -- '▎',
      },
      enforce_regular_tabs = true,
      view = 'multiwindow',
      show_buffer_close_icons = true,
      -- separator_style = 'thin',
      -- separator_style = 'slant',
      separator_style = 'thin',
      always_show_bufferline = true,
      persist_buffer_sort = true,
      diagnostics = false,
      themable = true,
      hover = {
        enabled = true,
        delay = 200,
        reveal = { 'close' },
      },
      offsets = {
        {
          filetype = 'neo-tree',
          text = 'File Explorer',
          -- TODO: change this highlight
          highlight = 'Directory',
          text_align = 'left',
          separator = true,
        },
      },
    },
  }, -- / BufferLine
  -- ----------------------------------------------------------------------------------------------

  -- ===============================================================================================
  -- NeoTree
  -- a file explorer plugin for Neovim
  -- SRC: https://github.com/nvim-neo-tree/neo-tree.nvim
  {
    'nvim-neo-tree/neo-tree.nvim',
    lazy = false,
    version = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-neotest/nvim-nio',
      'mason-org/mason.nvim',
      'jay-babu/mason-nvim-dap.nvim',
      'nvim-tree/nvim-web-devicons', -- icons
    },
    opts = {
      close_if_last_window = true,
      -- popup_border_style = ''
      enable_git_status = true,
      enable_diagnostics = true,
      sort_case_insensitive = true,
      sort_function = nil, -- use the default sort function
      default_component_configs = {
        container = {
          enable_character_fade = true,
        },
        indent = {
          indent_size = 2,
          padding = 1, -- extra padding on left hand side
          -- indent guides
          with_markers = true,
          indent_marker = '│',
          last_indent_marker = '└',
          highlight = 'NeoTreeIndentMarker',
          -- expander config, needed for nesting files
          with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
          expander_collapsed = '',
          expander_expanded = '',
          expander_highlight = 'NeoTreeExpander',
        },
        icon = {
          folder_closed = '',
          folder_open = '',
          folder_empty = '',
          provider = function(icon, node, state) -- default icon provider utilizes nvim-web-devicons if available
            if node.type == 'file' or node.type == 'terminal' then
              local ok, web_devicons = pcall(require, 'nvim-web-devicons')
              local name = node.type == 'terminal' and 'terminal' or node.name
              if ok then
                local devicon, hl = web_devicons.get_icon(name)
                icon.text = devicon or icon.text
                icon.highlight = hl or icon.highlight
              end
            end
          end,
          -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
          -- then these will never be used.
          default = '*',
          highlight = 'NeoTreeFileIcon',
        },
        modified = {
          symbol = '[+]',
          highlight = 'NeoTreeModified',
        },
        name = {
          trailing_slash = false,
          use_git_status_colors = true,
          highlight = 'NeoTreeFileName',
        },
        git_status = {
          symbols = {
            -- Change type
            added = '', -- or "✚", but this is redundant info if you use git_status_colors on the name
            modified = '', -- or "", but this is redundant info if you use git_status_colors on the name
            deleted = '', -- this can only be used in the git_status source
            renamed = '', -- this can only be used in the git_status source
            -- Status type
            untracked = '',
            ignored = '',
            unstaged = '',
            staged = '',
            conflict = '',
          },
        },
        -- If you don't want to use these columns, you can set `enabled = false` for each of them individually
        file_size = {
          enabled = true,
          width = 12, -- width of the column
          required_width = 64, -- min width of window required to show this column
        },
        type = {
          enabled = true,
          width = 10, -- width of the column
          required_width = 122, -- min width of window required to show this column
        },
        last_modified = {
          enabled = true,
          width = 20, -- width of the column
          required_width = 88, -- min width of window required to show this column
        },
        created = {
          enabled = true,
          width = 20, -- width of the column
          required_width = 110, -- min width of window required to show this column
        },
        symlink_target = {
          enabled = false,
        },
      },
      filesystem = {
        filtered_items = {
          visible = false, -- when true, they will just be displayed differently than normal items
          hide_dotfiles = true,
          hide_gitignored = true,
          hide_hidden = true, -- only works on Windows for hidden files/directories
          hide_by_name = {
            --"node_modules"
          },
          hide_by_pattern = { -- uses glob style patterns
            --"*.meta",
            --"*/src/*/tsconfig.json",
          },
          always_show = { -- remains visible even if other settings would normally hide it
            '.gitignored',
          },
          always_show_by_pattern = { -- uses glob style patterns
            --".env*",
          },
          never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
            '.DS_Store',
            'thumbs.db',
          },
          never_show_by_pattern = { -- uses glob style patterns
            --".null-ls_*",
          },
        },
        follow_current_file = {
          enabled = false, -- This will find and focus the file in the active buffer every time
          --               -- the current file is changed while the tree is open.
          leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
        },
        group_empty_dirs = false, -- when true, empty folders will be grouped together
        hijack_netrw_behavior = 'open_default', -- netrw disabled, opening a directory opens neo-tree
        -- in whatever position is specified in window.position
        -- "open_current",  -- netrw disabled, opening a directory opens within the
        -- window like netrw would, regardless of window.position
        -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
        use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
      },

      buffers = {
        follow_current_file = {
          enabled = true, -- This will find and focus the file in the active buffer every time
          --              -- the current file is changed while the tree is open.
          leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
        },
        group_empty_dirs = true, -- when true, empty folders will be grouped together
        show_unloaded = true,
      },
    },
    keys = {
      { '<leader>e', '<cmd>Neotree reveal<cr>', desc = 'File Explorer' },
    },
  }, -- / NeoTree
  -- ----------------------------------------------------------------------------------------------

  -- ==============================================================================================
  -- Noice
  -- notification manager for Neovim
  -- SRC: https://github.com/folke/noice.nvim
  {
    'folke/noice.nvim',
    lazy = true,
    event = 'VeryLazy',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    },
    opts = {
      routes = {
        {
          view = 'notify',
          filter = { event = 'msg_showmode' },
        },
        {
          view = 'split',
          filter = { event = 'msg_show', min_height = 20 },
        },
      },
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = false,
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = false,
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
      cmdline = {
        enabled = true,
        view = 'cmdline_popup',
        -- opts = {}, -- global options for the cmdline. See section on views
        format = {
          cmdline = { pattern = '^:', icon = '', lang = 'vim' },
          search_down = { kind = 'search', pattern = '^/', icon = ' ', lang = 'regex' },
          search_up = { kind = 'search', pattern = '^%?', icon = ' ', lang = 'regex' },
          filter = { pattern = '^:%s*!', icon = '$', lang = 'bash' },
          lua = {
            pattern = { '^:%s*lua%s+', '^:%s*lua%s*=%s*', '^:%s*=%s*' },
            icon = '',
            lang = 'lua',
          },
          help = { pattern = '^:%s*he?l?p?%s+', icon = '' },
          input = { view = 'cmdline_input', icon = '󰥻 ' }, -- Used by input()
        },
      },
      commands = {
        history = {
          -- options for the message history that you get with `:Noice`
          view = 'split',
          opts = { enter = true, format = 'details' },
          filter = {
            any = {
              { event = 'notify' },
              { error = true },
              { warning = true },
              { event = 'msg_show', kind = { '' } },
              { event = 'lsp', kind = 'message' },
            },
          },
        },
        last = {
          view = 'popup',
          opts = { enter = true, format = 'details' },
          filter = {
            any = {
              { event = 'notify' },
              { error = true },
              { warning = true },
              { event = 'msg_show', kind = { '' } },
              { event = 'lsp', kind = 'message' },
            },
          },
          filter_opts = { count = 1 },
        },
        errors = {
          -- options for the message history that you get with `:Noice`
          view = 'popup',
          opts = { enter = true, format = 'details' },
          filter = { error = true },
          filter_opts = { reverse = true },
        },
        all = {
          -- options for the message history that you get with `:Noice`
          view = 'split',
          opts = { enter = true, format = 'details' },
          filter = {},
        },
      },
      -- SEE: https://github.com/folke/noice.nvim/blob/main/lua/noice/config/views.lua
      -- for styling elements refer to NUI docs:
      --   popup: https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/popup
      --   split: shttps://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/split
      -- views = {
      --   popupmenu = {
      --     relative = 'editor',
      --     border = {
      --       style = 'none',
      --       padding = { 1, 2 },
      --     },
      --     position = {
      --       row = 8,
      --       col = '50%',
      --     },
      --     size = {
      --       width = 60,
      --       height = 10,
      --     },
      --     win_options = {
      --       winhighlight = {
      --         Normal = 'NormalFloat', -- change to NormalFloat dto make it look like other floats
      --         FloatBorder = 'FloatBorder', -- border highlight
      --         CursorLine = 'NoicePopupmenuSelected', -- used for highlighting the selected item
      --         PmenuMatch = 'NoicePopupmenuMatch', -- used to highlight the part of the item that matches the input
      --       },
      --     },
      --   },
      --   cmdline_popup = {

      --     border = {
      --       style = 'none',
      --       padding = { 1, 2 },
      --     },
      --     win_options = {
      --       winhighlight = {
      --         Normal = 'NormalFloat',
      --         FloatBorder = 'FloatBorder',
      --         CursorLine = 'NoicePopupmenuSelected',
      --         PmenuMatch = 'NoicePopupmenuMatch',
      --       },
      --     },
      --   },
      -- },
    },
  }, -- / Noice
  -- ----------------------------------------------------------------------------------------------

  -- ==============================================================================================s
  -- Which Key
  -- a Neovim plugin that provides a popup menu for keybindings
  -- SRC: https://github.com/folke/which-key.nvim
  {
    'folke/which-key.nvim',
    lazy = true,
    event = 'VeryLazy',
    config = function()
      local wk = require 'which-key'

      wk.setup {
        -- delay between pressing a key and opening which-key (milliseconds)
        -- this setting is independent of vim.o.timeoutlen
        delay = 100,
        icons = {
          breadcrumb = '', -- symbol used in the command line area that shows your active key combo
          separator = '', -- symbol used between a key and it's label
          group = ' ', -- symbol prepended to a group
          ellipsis = '󰇘',
          colors = false, -- use which-key colors
          mappings = true,
          keys = {
            Up = ' ',
            Down = ' ',
            Left = ' ',
            Right = ' ',
            C = '󰘴 ',
            M = '󰘵 ',
            D = '󰘳 ',
            S = '󰘶 ',
            CR = '󰌑 ',
            Esc = '󱊷 ',
            ScrollWheelDown = '󱕐 ',
            ScrollWheelUp = '󱕑 ',
            NL = '󰌑 ',
            BS = '󰁮 ',
            Space = '󱁐 ',
            Tab = '󰌒 ',
            F1 = '󱊫',
            F2 = '󱊬',
            F3 = '󱊭',
            F4 = '󱊮',
            F5 = '󱊯',
            F6 = '󱊰',
            F7 = '󱊱',
            F8 = '󱊲',
            F9 = '󱊳',
            F10 = '󱊴',
            F11 = '󱊵',
            F12 = '󱊶',
          },
        },
      }

      -- which key mappings
      wk.add {
        { '<leader>b', group = 'Buffer' },
        {
          '<leader>b',
          'b',
          group = 'Buffers',
          expand = function() return require('which-key.extras').expand.buf() end,
        },
        { '<leader>d', group = 'Diffview', mode = { 'n' } },
        { '<leader>f', group = 'Files' },
        { '<leader>g', group = 'Git' },
        { '<leader>g', 'd', group = 'Git Diff' },
        { '<leader>h', group = 'Git Hunk', mode = { 'n' } },
        { '<leader>l', group = 'LSP' },
        { '<leader>r', group = 'Refactor' },
        { '<leader>s', group = 'Search' },
        { '<leader>t', group = 'Otter' },
        { '<leader>t', group = 'Toggle' },
        { '<leader>u', group = 'UI' },
        { '<leader>w', group = 'Window' },
        { '<leader>x', group = 'Trouble' },
        { '<leader>m', group = 'Mason' },
        { '<leader>?', group = 'WTF' },
      }
    end,
  }, -- / Which Key
  -- ----------------------------------------------------------------------------------------------

  -- ==============================================================================================
  -- Window Picker
  -- a Neovim plugin that allows you to pick a window by its number or name
  -- SRC: https://github.com/s1n7ax/nvim-window-picker
  -- {
  --   's1n7ax/nvim-window-picker',
  --   lazy = true,
  --   name = 'window-picker',
  --   event = 'VeryLazy',
  --   version = '2.*',
  --   config = function()
  --     -- get highlight colors from theme
  --     local search_hl = vim.api.nvim_get_hl(0, { name = 'Search' })
  --     local folded_hl = vim.api.nvim_get_hl(0, { name = 'Folded' })

  --     require('nvim-window-picker').setup {
  --       -- type of hints you want to get
  --       -- following types are supported
  --       -- 'statusline-winbar' | 'floating-big-letter' | 'floating-letter'
  --       -- 'statusline-winbar' draw on 'statusline' if possible, if not 'winbar' will be
  --       -- 'floating-big-letter' draw big letter on a floating window
  --       -- 'floating-letter' draw letter on a floating window
  --       hint = 'statusline-winbar',
  --       -- hint = 'floating-big-letter',
  --       -- This section contains picker specific configurations
  --       picker_config = {
  --         handle_mouse_click = true,
  --         floating_big_letter = {
  --           -- window picker plugin provides bunch of big letter fonts
  --           -- fonts will be lazy loaded as they are being requested
  --           -- additionally, user can pass in a table of fonts in to font
  --           -- property to use instead

  --           font = require 'phaezer.config.plugins.window-picker.fonts.rubi',
  --         },
  --         statusline_winbar_picker = {
  --           -- You can change the display string in status bar.
  --           -- It supports '%' printf style. Such as `return char .. ': %f'` to display
  --           -- buffer file path. See :h 'stl' for details.
  --           selection_display = function(char, windowid) return '%=' .. char .. '%=' end,

  --           -- whether you want to use winbar instead of the statusline
  --           -- "always" means to always use winbar,
  --           -- "never" means to never use winbar
  --           -- "smart" means to use winbar if cmdheight=0 and statusline if cmdheight > 0
  --           use_winbar = 'always', -- "always" | "never" | "smart"
  --         },
  --       },
  --       filter_rules = {
  --         include_current_win = false,
  --         autoselect_one = true,
  --         -- filter using buffer options
  --         bo = {
  --           -- if the file type is one of following, the window will be ignored
  --           filetype = { 'neo-tree', 'neo-tree-popup', 'notify', 'snacks_notif' },
  --           -- if the buffer type is one of following, the window will be ignored
  --           buftype = { 'terminal', 'quickfix' },
  --         },
  --       },
  --       show_prompt = false,
  --       highlights = {
  --         enabled = true,
  --         statusline = {
  --           focused = {
  --             fg = search_hl.fg,
  --             bg = search_hl.bg,
  --             bold = true,
  --           },
  --           unfocused = {
  --             fg = folded_hl.fg,
  --             bg = folded_hl.bg,
  --             bold = true,
  --           },
  --         },
  --         winbar = {
  --           focused = {
  --             fg = search_hl.fg,
  --             bg = search_hl.bg,
  --             bold = true,
  --           },
  --           unfocused = {
  --             fg = folded_hl.fg,
  --             bg = folded_hl.bg,
  --             bold = true,
  --           },
  --         },
  --       },
  --     }

  --     -- create the pick window comand and keybinding
  --     vim.api.nvim_create_user_command('PickWindow', function()
  --       local win_id = require('window-picker').pick_window()
  --       vim.api.nvim_set_current_win(win_id)
  --     end, { desc = 'Pick a window' })

  --     -- reload the window-picker when a colorscheme is changed
  --     -- so that the highlight colors are updated
  --     vim.api.nvim_create_autocmd('ColorScheme', {
  --       group = vim.api.nvim_create_augroup('nvim-window-picker', { clear = true }),
  --       desc = 'reload window-picker to update highlight colors',
  --       callback = function(ev) vim.cmd { cmd = 'Lazy', args = { 'reload', 'window-picker' } } end,
  --     })
  --   end,
  --   keys = {
  --     { '<leader>wp', '<cmd>PickWindow<cr>', desc = 'Pick a window' },
  --   },
  -- }, -- / Window Picker
  -- ----------------------------------------------------------------------------------------------

  -- ==============================================================================================
  -- Oil
  -- a Neovim plugin that allows you to manage files and directories
  -- SRC: https://github.com/stevearc/oil.nvim
  {
    'stevearc/oil.nvim',
    lazy = true,
    dependencies = { { 'echasnovski/mini.icons', opts = {} } },
    opts = {},
    keys = {
      { '-', '<cmd>Oil<cr>', desc = 'Open parent directory' },
    },
  }, -- / Oil
  -- ----------------------------------------------------------------------------------------------
}
