local util = require 'phaezer.core.util'
local icons = require 'phaezer.core.icons'

-- LuaLine
-- NOTE: a statusline plugin for Neovim
local LuaLine = {
  'nvim-lualine/lualine.nvim',
  lazy = false,
  dependencies = {
    'bwpge/lualine-pretty-path',
    'stevearc/overseer.nvim',
    'folke/noice.nvim',
  },
}

LuaLine.opts = function(_, opts)
  -- local has_lsp = function() return next(vim.lsp.get_clients()) ~= nil end
  local buffer_not_empty = function() return vim.fn.empty(vim.fn.expand '%:t') ~= 1 end
  local overseer = require 'overseer'
  return vim.tbl_deep_extend('force', opts or {}, {
    options = {
      refresh = {
        statusline = 1000,
        tabline = 1000,
        winbar = 1000,
        refresh_time = 16, -- ~60fps
        events = {
          'WinEnter',
          'BufEnter',
          'BufWritePost',
          'SessionLoadPost',
          'FileChangedShellPost',
          'VimResized',
          'Filetype',
          'CursorMoved',
          'CursorMovedI',
          'ModeChanged',
          'ColorScheme',
        },
      },
      theme = 'auto',
      globalstatus = true,
      disabled_filetypes = {
        statusline = {
          'dashboard',
          'alpha',
          'ministarter',
          'snacks_dashboard',
          'Outline',
          'neo-tree',
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
          icon = icons.gui.Neovim,
        },
      },
      lualine_b = {},
      lualine_c = {
        {
          'branch',
          icon = icons.gui.Branch,
          padding = { left = 1, right = 1 },
        },
        { 'pretty_path' },
        { 'filesize', cond = buffer_not_empty },
        {
          'diagnostics',
          icon = '',
          symbols = {
            error = icons.diagnostics.Error,
            warn = icons.diagnostics.Warn,
            info = icons.diagnostics.Info,
            hint = icons.diagnostics.Hint,
          },
          {
            function() return ' ' .. require('dap').status() end,
            cond = function() return require('dap').status() ~= '' end,
            color = function() return { fg = util.color 'Debug' } end,
          },
        },
        {
          'diff',
          icon = '',
          symbols = {
            added = icons.git.Added,
            modified = icons.git.Modified,
            removed = icons.git.Removed,
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
      },
      lualine_x = {
        {
          require('noice').api.status.command.get,
          cond = require('noice').api.status.command.has,
          color = function() return { fg = util.color 'Constant' } end,
        },
        {
          require('noice').api.status.search.get,
          cond = require('noice').api.status.search.has,
          color = function() return { fg = util.color 'Type' } end,
        },
        {
          'overseer',
          label = '', -- Prefix for task counts
          colored = true, -- Color the task icons and counts
          symbols = {
            [overseer.STATUS.FAILURE] = '',
            [overseer.STATUS.CANCELED] = '󰜺',
            [overseer.STATUS.SUCCESS] = '',
            [overseer.STATUS.RUNNING] = '',
          },
          unique = false, -- Unique-ify non-running task count by name
          name = nil, -- List of task names to search for
          name_not = false, -- When true, invert the name search
          status = nil, -- List of task statuses to display
          status_not = false, -- When true, invert the status search
        },
        { 'filetype' },
        {
          'lsp_status',
          icon = icons.gui.Server,
          -- separator = { left = '', right = '' },
          symbols = {
            -- Standard unicode symbols to cycle through for LSP progress:
            spinner = icons.spinners.circle,
            -- Standard unicode symbol for when LSP is done:
            done = '',
            -- Delimiter inserted between LSP names:
            separator = ' ',
          },
        },
        {
          'progress',
          icon = '',
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
    inactive_sections = {
      lualine_a = { 'filename' },
      lualine_b = {},
      lualine_c = { 'pretty_path' },
      lualine_x = {},
      lualine_y = {},
      lualine_z = { 'location' },
    },
    extensions = { 'lazy', 'fzf', 'trouble' },
  })
end

return LuaLine
