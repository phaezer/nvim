-- TODO: complete styling for noice
-- SEE: https://github.com/folke/noice.nvim

require('noice').setup {
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
    enabled = true, -- enable the Noice cmdline UI
    view = 'cmdline_popup', -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
    -- opts = {}, -- global options for the cmdline. See section on views
    format = {
      cmdline = { pattern = '^:', icon = '', lang = 'vim' },
      search_down = { kind = 'search', pattern = '^/', icon = ' ', lang = 'regex' },
      search_up = { kind = 'search', pattern = '^%?', icon = ' ', lang = 'regex' },
      filter = { pattern = '^:%s*!', icon = '$', lang = 'bash' },
      lua = { pattern = { '^:%s*lua%s+', '^:%s*lua%s*=%s*', '^:%s*=%s*' }, icon = '', lang = 'lua' },
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
}
