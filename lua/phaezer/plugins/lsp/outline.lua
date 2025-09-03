-- Outline
-- NOTE: provides an outline view for Neovim
return {
  'hedyhli/outline.nvim',
  lazy = true,
  cmd = { 'Outline', 'OutlineOpen' },
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
      markers = { '󰄾', '󰄼' },
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
  keys = {
    { '<leader>eo', '<cmd>Outline<cr>', desc = 'Toggle outline' },
  },
}
