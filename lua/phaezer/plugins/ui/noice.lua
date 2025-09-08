-- Noice
-- notification manager for Neovim
return {
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
      progress = { enabled = false }, -- shhhh
      -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
        ['cmp.entry.get_documentation'] = false,
      },
      signature = { enabled = false },
    },
    -- you can enable a preset for easier configuration
    presets = {
      bottom_search = true,
      command_palette = true, -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = true, -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = false,
    },
    cmdline = {
      enabled = true,
      view = 'cmdline_popup',
      -- opts = {}, -- global options for the cmdline. See section on views
      format = {
        cmdline = { pattern = '^:', icon = '', lang = 'vim' },
        search_down = { kind = 'search', pattern = '^/', icon = ' ', lang = 'regex' },
        search_up = { kind = 'search', pattern = '^%?', icon = ' ', lang = 'regex' },
        filter = { pattern = '^:%s*!', icon = '󱆃', lang = 'bash' },
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
        view = 'split',
        opts = { enter = true, format = 'details' },
        filter = {},
      },
    },
    -- SEE: https://github.com/folke/noice.nvim/blob/main/lua/noice/config/views.lua
    -- for styling elements refer to NUI docs:
    --   popup: https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/popup
    --   split: shttps://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/split
    views = {
      cmdline_popup = {
        relative = 'editor',
        position = {
          row = '50%',
          col = '50%',
        },
      },
      popup = {
        relative = 'editor',
        position = {
          row = '50%',
          col = '50%',
        },
      },
    },
  },
}
