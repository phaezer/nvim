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
  local has_lsp = function() return next(vim.lsp.get_clients()) ~= nil end
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
      component_separators = '|',
      section_separators = { left = '', right = '' },
    },
    sections = {
      -- left side
      lualine_a = {
        {
          'mode',
          color = { gui = 'bold' },
          fmt = function(str) return str:sub(1, 1) end,
          separator = { left = '', right = '' },
          padding = { left = 0, right = 1 },
          icon = '',
        },
      },
      lualine_b = {
        { 'branch', icon = '', separator = { left = '', right = '' } },
      },
      lualine_c = {
        { 'pretty_path' },
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
            added = '',
            modified = '󰦒',
            removed = '',
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

        -- {
        --   -- Lsp server name .
        --   function()
        --     local c = {}
        --     local clients = vim.lsp.get_clients()
        --     if next(clients) == nil then return 'No LSP' end
        --     for i, client in ipairs(clients) do
        --       table.insert(c, client.name)
        --       if i > 2 then -- only show first 2 clients
        --         table.insert(c, '󰶻')
        --         break
        --       end
        --     end
        --     return table.concat(c, '  ')
        --   end,
        --   separator = { left = '', right = '' },
        -- },
      },
      lualine_y = {
        {
          'lsp_status',
          icon = '',
          separator = { left = '', right = '' },
          symbols = {
            -- Standard unicode symbols to cycle through for LSP progress:
            spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' },
            -- Standard unicode symbol for when LSP is done:
            done = '',
            -- Delimiter inserted between LSP names:
            separator = '  ',
          },
        },
      },
      lualine_z = {
        {
          'progress',
          icon = '',
          separator = { left = '', right = '' },
          padding = { left = 1, right = 1 },
        },
        {
          'location',
          separator = { left = '', right = '' },
          padding = { left = 0, right = 0 },
        },
      },
    },
    tabline = {
      lualine_a = {
        {
          'buffers',
          separator = { left = '', right = '' },
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
            modified = '', -- Text to show when the buffer is modified
            alternate_file = '', -- Text to show to identify the alternate file
            directory = '', -- Text to show when the buffer is a directory
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
