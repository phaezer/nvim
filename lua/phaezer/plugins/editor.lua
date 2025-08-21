return {
  { 'numToStr/Comment.nvim', opts = {} },

  -- ==============================================================================================
  -- Visual Whitespace
  -- Display white space characters in visual mode, like VSCode's renderWhitespace: selection.
  {
    'mcauley-penney/visual-whitespace.nvim',
    lazy = true,
    event = 'BufEnter',
    opts = {
      enabled = true,
      highlight = { link = 'Visual', default = true },
      match_types = {
        space = true,
        tab = true,
        nbsp = true,
        lead = false,
        trail = false,
      },
      list_chars = {
        space = '',
        tab = '',
        nbsp = '󱁐',
        lead = '',
        trail = '',
      },
      fileformat_chars = {
        unix = '',
        mac = '',
        dos = '󰘌',
      },
      ignore = {
        filetypes = {
          'neo-tree',
          'snacks_dashboard',
          'Outline',
          'oil',
        },
        buftypes = {},
      },
    },
    keys = {
      {
        '<leader>u.',
        function() require('visual-whitespace').toggle() end,
        desc = 'Toggle Visual Whitespace',
      },
    },
  }, -- / Visual Whitespace

  -- ==============================================================================================
  -- Outline
  -- provides an outline view for Neovim
  {
    'hedyhli/outline.nvim',
    lazy = true,
    cmd = { 'Outline', 'OutlineOpen' },
    keys = {
      { '<leader>o', '<cmd>Outline<CR>', desc = 'Toggle outline' },
    },
    opts = {
      keymaps = {
        show_help = '?',
        close = { '<Esc>', 'q' },
        -- Jump to symbol under cursor.
        -- It can auto close the outline window when triggered, see
        -- 'auto_close' option above.
        goto_location = '<Cr>',
        -- Jump to symbol under cursor but keep focus on outline window.
        peek_location = 'o',
        -- Visit location in code and close outline immediately
        goto_and_close = '<S-Cr>',
        -- Change cursor position of outline window to match current location in code.
        -- 'Opposite' of goto/peek_location.
        restore_location = '<C-g>',
        -- Open LSP/provider-dependent symbol hover information
        hover_symbol = '<C-space>',
        -- Preview location code of the symbol under cursor
        toggle_preview = 'K',
        rename_symbol = 'r',
        code_actions = 'a',
        -- These fold actions are collapsing tree nodes, not code folding
        fold = 'h',
        unfold = 'l',
        fold_toggle = '<Tab>',
        -- Toggle folds for all nodes.
        -- If at least one node is folded, this action will fold all nodes.
        -- If all nodes are folded, this action will unfold all nodes.
        fold_toggle_all = '<S-Tab>',
        fold_all = 'W',
        unfold_all = 'E',
        fold_reset = 'R',
        -- Move down/up by one line and peek_location immediately.
        -- You can also use outline_window.auto_jump=true to do this for any
        -- j/k/<down>/<up>.
        down_and_jump = '<C-j>',
        up_and_jump = '<C-k>',
      },

      outline_window = {
        position = 'right',
        width = 25,
        relative_width = true,
        auto_close = false,
        focus_on_open = false, -- don't focus on the outline when opening it
      },

      guides = {
        enabled = true,
        markers = {
          -- It is recommended for bottom and middle markers to use the same number
          -- of characters to align all child nodes vertically.
          bottom = '└',
          middle = '├',
          vertical = '│',
        },
      },
      symbol_folding = {
        -- Depth past which nodes will be folded by default. Set to false to unfold all on open.
        autofold_depth = 1,
        -- When to auto unfold nodes
        auto_unfold = {
          -- Auto unfold currently hovered symbol
          hovered = true,
          -- Auto fold when the root level only has this many nodes.
          -- Set true for 1 node, false for 0.
          only = true,
        },
        markers = { '', '' },
      },
      symbols = {
        -- Filter by kinds (string) for symbols in the outline.
        -- Possible kinds are the Keys in the icons table below.
        -- A filter list is a string[] with an optional exclude (boolean) field.
        -- The symbols.filter option takes either a filter list or ft:filterList
        -- key-value pairs.
        -- Put  exclude=true  in the string list to filter by excluding the list of
        -- kinds instead.
        -- Include all except String and Constant:
        --   filter = { 'String', 'Constant', exclude = true }
        -- Only include Package, Module, and Function:
        --   filter = { 'Package', 'Module', 'Function' }
        -- See more examples below.
        filter = nil,
        icon_source = 'lspkind',
        icons = {
          File = { icon = '', hl = 'Identifier' },
          Module = { icon = '󰮄', hl = 'Include' },
          Namespace = { icon = '󱘎', hl = 'Include' },
          Package = { icon = '󰆧', hl = 'Include' },
          Class = { icon = '', hl = 'Type' },
          Method = { icon = '󰡱', hl = 'Function' },
          Property = { icon = '', hl = 'Identifier' },
          Field = { icon = '󰽐', hl = 'Identifier' },
          Constructor = { icon = '', hl = 'Special' },
          Enum = { icon = '', hl = 'Type' },
          Interface = { icon = '', hl = 'Type' },
          Function = { icon = '󰊕', hl = 'Function' },
          Variable = { icon = '󰫧', hl = 'Constant' },
          Constant = { icon = '', hl = 'Constant' },
          String = { icon = '', hl = 'String' },
          Number = { icon = '', hl = 'Number' },
          Boolean = { icon = '󰨙', hl = 'Boolean' },
          Array = { icon = '󰅪', hl = 'Constant' },
          Object = { icon = '󰅩', hl = 'Type' },
          Key = { icon = '', hl = 'Type' },
          Null = { icon = '', hl = 'Type' },
          EnumMember = { icon = '', hl = 'Identifier' },
          Struct = { icon = '', hl = 'Structure' },
          Event = { icon = '', hl = 'Type' },
          Operator = { icon = '', hl = 'Identifier' },
          TypeParameter = { icon = '󰗴', hl = 'Identifier' },
          Component = { icon = '󰘦', hl = 'Function' },
          Fragment = { icon = '󰘦', hl = 'Constant' },
          TypeAlias = { icon = '󰰦', hl = 'Type' },
          Parameter = { icon = '', hl = 'Identifier' },
          StaticMethod = { icon = '󰡱', hl = 'Function' },
          Macro = { icon = '', hl = 'Function' },
        },
      },
      providers = {
        priority = { 'lsp', 'coc', 'markdown', 'norg', 'man' },
        lsp = {
          blacklist_clients = {},
        },
        markdown = {
          filetypes = { 'markdown' },
        },
      },
    },
  }, -- / Outline

  -- ==============================================================================================
  -- Trouble
  -- TODO: finish trouble config
  {
    'folke/trouble.nvim',
    cmd = { 'Trouble', 'TroubleToggle', 'TroubleRefresh' },
  }, -- / Trouble

  -- ==============================================================================================
  -- TODO Comments
  -- Highlights todo, notes, etc in comments
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'folke/snacks.nvim',
    },
    keys = {
      {
        '<leader>st',
        function() Snacks.picker.todo_comments { keywords = { 'TODO', 'FIX', 'FIXME' } } end,
        desc = 'Todos',
      },
      { '<leader>sT', function() Snacks.picker.todo_comments {} end, desc = 'All Todo Flags' },
      -- TODO: keys for other todo flag types
    },
    opts = {
      signs = false,
      keywords = {
        FIX = {
          icon = ' ', -- icon used for the sign, and in search results
          color = 'error', -- can be a hex color, or a named color (see below)
          alt = { 'FIXME', 'BUG', 'FIXIT', 'ISSUE' }, -- a set of other keywords that all map to this FIX keywords
        },
        TODO = { icon = ' ', color = 'info' },
        HACK = { icon = ' ', color = 'warning' },
        WARN = { icon = ' ', color = 'warning', alt = { 'WARNING', 'XXX' } },
        PERF = { icon = ' ', alt = { 'OPTIM', 'PERFORMANCE', 'OPTIMIZE' } },
        NOTE = { icon = ' ', color = 'hint', alt = { 'INFO' } },
        TEST = { icon = '󰙨 ', color = 'test', alt = { 'TESTING', 'PASSED', 'FAILED' } },
        DOC = {
          icon = ' ',
          color = 'hint',
          alt = { 'SEE', 'DOCUMENTATION', 'DOCS', 'README', 'RTFM' },
        },
        SRC = { icon = ' ', color = 'hint', alt = { 'SOURCE' } },
      },
    },
  }, -- / TODO Comments

  -- Vim Text Objects
  -- vim-textobj-quote
  -- Typographic quotes
  {
    'preservim/vim-textobj-quote',
    lazy = true,
    event = 'BufEnter',
    dependencies = { 'kana/vim-textobj-user' },
    config = function()
      local keys = require 'phaezer.core.keys'
      local api = vim.api
      local group = api.nvim_create_augroup('textobjquote', { clear = true })

      local function setup_textobj_quote(educate, bufnr)
        vim.cmd("textobj#quote#init({'educate':" .. educate .. '})')
        keys.set { '<leader>mq', '<cmd>ToggleEducate<cr>', desc = 'Toggle Typographic Quotes', buffer = bufnr }
      end

      api.nvim_create_autocmd('FileType', {
        group = group,
        pattern = { 'markdown', 'textile' },
        desc = 'setup textobj-quote for curl quotes',
        callback = function(ev) setup_textobj_quote(1, ev.buf) end,
      })

      api.nvim_create_autocmd('FileType', {
        group = group,
        pattern = { 'text' },
        desc = 'setup textobj-quote for curl quotes',
        callback = function(ev) setup_textobj_quote(0, ev.buf) end,
      })
    end,
  }, -- / vim-textobj-quote

  -- ==============================================================================================
  -- Illuminate
  --  highlights other uses of the word under the cursor
  {
    'RRethy/vim-illuminate',
    event = 'BufReadPost',
    config = function()
      require('illuminate').configure {
        delay = 100,
        filetypes_denylist = {
          'dirbuf',
          'dirvish',
          'fugitive',
          'Outline',
        },
      }
    end,
  }, -- / Illuminate

  -- ==============================================================================================
  -- Substitute
  -- A Neovim plugin for performing substitutions with a visual selection or a range
  {
    'gbprod/substitute.nvim',
    lazy = false,
    opts = {
      on_substitute = function() require('yanky.integration').substitute() end,
    },
    keys = {
      { 's', function() require('substitute').operator() end, desc = 'Substitute' },
      { 'ss', function() require('substitute').line() end, desc = 'Substitute line' },
      { 'S', function() require('substitute').eol() end, desc = 'Substitute end of line' },
      { 'gs', function() require('substitute').visual() end, desc = 'Substitute visual selection' },
    },
  }, -- / Substitute

  -- ==============================================================================================
  -- Colorizer
  -- add highlighted color backgrounds to common color types (hex, rgb, etc.)
  {
    'norcalli/nvim-colorizer.lua',
    lazy = false,
    opts = {},
  }, -- / Colorizer

  -- ==============================================================================================
  -- Tiny Code Action
  -- provides a simple way to run and visualize code actions.
  {
    'rachartier/tiny-code-action.nvim',
    lazy = true,
    event = 'LspAttach',
    dependencies = {
      'folke/snacks.nvim',
    },
    opts = {},
  },
  keys = {
    { '<leader>la', function() require('tiny-code-action').code_action() end, desc = 'Code Action' },
  }, -- / Tiny Code Action

  -- ==============================================================================================
  -- Minty
  -- Beautifully crafted color tools for Neovim
  {
    'nvzone/minty',
    lazy = true,
    cmd = { 'Shades', 'Huefy' },
    dependencies = {
      { 'nvzone/volt', lazy = true },
    },
  }, -- / Minty

  -- ==============================================================================================
  -- Colorful Menu
  -- A Neovim plugin that provides a colorful menu for LSP completion and other text
  {
    'xzbdmw/colorful-menu.nvim',
    config = function()
      -- You don't need to set these options.
      require('colorful-menu').setup {
        ls = {
          gopls = {
            -- When true, label for field and variable will format like "foo: Foo"
            -- instead of go's original syntax "foo Foo". If align_type_to_right is
            -- true, this option has no effect.
            add_colon_before_type = false,
            -- See https://github.com/xzbdmw/colorful-menu.nvim/pull/36
            preserve_type_when_truncate = true,
          },
          -- for lsp_config or typescript-tools
          ts_ls = {
            extra_info_hl = '@comment',
          },
          ['rust-analyzer'] = {
            extra_info_hl = '@comment',
            -- See https://github.com/xzbdmw/colorful-menu.nvim/pull/36
            preserve_type_when_truncate = true,
          },
          clangd = {
            extra_info_hl = '@comment',
            import_dot_hl = '@comment',
            preserve_type_when_truncate = true,
          },
          -- The same applies to pyright/pylance
          basedpyright = {
            extra_info_hl = '@comment',
          },
          pylsp = {
            extra_info_hl = '@comment',
          },
          fallback = true,
          fallback_extra_info_hl = '@comment',
        },
        -- If the built-in logic fails to find a suitable highlight group for a label,
        -- this highlight is applied to the label.
        fallback_highlight = '@variable',
        max_width = 80,
      }
    end,
  },
}
