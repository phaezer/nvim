-- LuaLine
-- a statusline plugin for Neovim
local LuaLine = {
  'nvim-lualine/lualine.nvim',
  lazy = false,
  dependencies = {
    'bwpge/lualine-pretty-path',
  },
}

LuaLine.config = function()
  -- local has_lsp = function() return next(vim.lsp.get_clients()) ~= nil end
  local buffer_not_empty = function() return vim.fn.empty(vim.fn.expand '%:t') ~= 1 end

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
      component_separators = ' ',
      section_separators = { left = '', right = '' },
    },
    sections = {
      -- left side
      lualine_a = {
        {
          'mode',
          color = { gui = 'bold' },
          separator = { left = ' ', right = '' },
          padding = { left = 0, right = 0 },
          icon = '',
        },
      },
      lualine_b = {},
      lualine_c = {
        { 'branch', icon = '', padding = { left = 1, right = 0 } },
        { 'pretty_path', padding = { left = 1, right = 0 } },
        { 'filesize', cond = buffer_not_empty },
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
      },
      -- right side
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
          function() return ' ' .. require('dap').status() end,
          cond = function() return package.loaded['dap'] and require('dap').status() ~= '' end,
          color = function() return { fg = Snacks.util.color 'Debug' } end,
        },
        {
          'diff',
          symbols = {
            added = '+',
            modified = '󱓉',
            removed = '-',
          },
          source = function()
            local gs = vim.b.gitsigns_status_dict
            if gs then
              return {
                added = gs.added,
                modified = gs.changed,
                removed = gs.removed,
              }
            end
          end,
        },
        {
          'lsp_status',
          icon = '',
          -- separator = { left = '', right = '' },
          symbols = {
            -- Standard unicode symbols to cycle through for LSP progress:
            spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' },
            -- Standard unicode symbol for when LSP is done:
            done = '',
            -- Delimiter inserted between LSP names:
            separator = '  ',
          },
        },
        {
          'progress',
          icon = '',
          -- separator = { left = '', right = '' },
          padding = { left = 1, right = 0 },
        },
        {
          'location',
          separator = { left = '', right = ' ' },
          padding = { left = 0, right = 1 },
        },
      },
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {
      lualine_a = {
        {
          'buffers',
          -- separator = { left = '', right = '' },
          color = 'BufferlineInactive',
          -- 0: Shows buffer name
          -- 1: Shows buffer index
          -- 2: Shows buffer name + buffer index
          -- 3: Shows buffer number
          -- 4: Shows buffer name + buffer number
          mode = 0,
          filetype_names = {
            dashboard = 'Dashboard',
            fzf = 'FZF',
            alpha = 'Alpha',
            ['neo-tree'] = 'Explorer',
            Oil = 'Oil',
          },
          buffers_color = {
            -- Same values as the general color option can be used here.
            active = 'BufferlineActive', -- Color for active buffer.
            inactive = 'BufferlineInactive', -- Color for inactive buffer.
          },
          symbols = {
            modified = ' ', -- Text to show when the buffer is modified
            alternate_file = '', -- Text to show to identify the alternate file
            directory = ' ', -- Text to show when the buffer is a directory
          },
        },
      },
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = { 'tabs' },
      lualine_z = {},
    },
    inactive_sections = {
      lualine_a = { 'filename' },
      lualine_b = {},
      lualine_c = { 'pretty_path' },
      lualine_x = {},
      lualine_y = {},
      lualine_z = { 'location' },
    },
    extensions = { 'neo-tree', 'lazy', 'fzf', 'trouble' },
  }
end

return LuaLine
