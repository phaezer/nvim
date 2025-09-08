local icons = require 'phaezer.core.icons'

-- NeoTree
-- NOTE: a file explorer plugin for Neovim
return {
  'nvim-neo-tree/neo-tree.nvim',
  lazy = false,
  version = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-neotest/nvim-nio',
    'mason-org/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  opts = {
    close_if_last_window = false,
    popup_border_style = 'rounded',
    enable_git_status = true,
    enable_diagnostics = true,
    sort_case_insensitive = true,
    sort_function = nil, -- use the default sort function
    window = {
      ['P'] = {
        'toggle_preview',
        config = {
          use_float = false,
          use_snacks_image = true,
          title = 'Preview',
        },
      },
    },
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
        folder_closed = icons.kind.FolderClosed,
        folder_open = icons.kind.FolderOpen,
        folder_empty = icons.kind.FolderEmpty,
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
        default = '',
        highlight = 'NeoTreeFileIcon',
      },
      modified = {
        symbol = '',
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
          added = '', -- or "✚", but this is redundant info if you use git_status_colors on the name
          modified = '', -- or "", but this is redundant info if you use git_status_colors on the name
          deleted = icons.git.Removed, -- this can only be used in the git_status source
          renamed = icons.git.Renamed, -- this can only be used in the git_status source
          -- Status type
          untracked = icons.git.Untracked,
          ignored = icons.git.Ignored,
          unstaged = icons.git.Unstaged,
          staged = icons.git.Staged,
          conflict = icons.git.Confict,
        },
      },
      -- If you don't want to use these columns, you can set `enabled = false` for each of them individually
      file_size = {
        enabled = true,
        width = 12, -- width of the column
        required_width = 50, -- min width of window required to show this column
      },
      type = {
        enabled = true,
        width = 10, -- width of the column
        required_width = 122, -- min width of window required to show this column
      },
      last_modified = {
        enabled = true,
        width = 20, -- width of the column
        required_width = 80, -- min width of window required to show this column
      },
      created = {
        enabled = true,
        width = 20, -- width of the column
        required_width = 100, -- min width of window required to show this column
      },
      symlink_target = {
        enabled = false,
      },
    },
    filesystem = {
      filtered_items = {
        visible = false, -- when true, they will just be displayed differently than normal items
        hide_dotfiles = false,
        hide_gitignored = false,
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
        enabled = true, -- This will find and focus the file in the active buffer every time
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
    sources = {
      'filesystem',
      'buffers',
      'git_status',
      'document_symbols',
    },
  },

}
