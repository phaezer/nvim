local util = require 'phaezer.core.util'
local icons = require 'phaezer.core.icons'

-- cSpell:words bwpge statusline lualine globalstatus ministarter filesize gitsigns
-- cSpell:words navic linrongbin16 SmiteshP
-- LuaLine
-- NOTE: a statusline plugin for Neovim
local LuaLine = {
  'nvim-lualine/lualine.nvim',
  lazy = false,
  dependencies = {
    'bwpge/lualine-pretty-path',
    'stevearc/overseer.nvim',
    'folke/noice.nvim',
    'linrongbin16/lsp-progress.nvim',
    'SmiteshP/nvim-navic',
  },
}

LuaLine.opts = function(_, opts)
  local navic = require 'nvim-navic'
  local overseer = require 'overseer'
  -- local has_lsp = function() return next(vim.lsp.get_clients()) ~= nil end
  local buffer_not_empty = function() return vim.fn.empty(vim.fn.expand '%:t') ~= 1 end
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
        winbar = {
          'neo-tree',
          'Outline',
          'dashboard',
          'Snacks_dashboard',
          'Oil',
          'mini',
        },
      },
      component_separators = ' ',
      section_separators = { left = '', right = '' },
    },
    -- status line
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
          symbols = {
            error = icons.diagnostics.Error .. ' ',
            warn = icons.diagnostics.Warn .. ' ',
            info = icons.diagnostics.Info .. ' ',
            hint = icons.diagnostics.Hint .. ' ',
          },
          {
            function() return ' ' .. require('dap').status() end,
            cond = function() return require('dap').status() ~= '' end,
            color = function() return { fg = util.color 'Debug' } end,
          },
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
        {
          function()
            -- invoke `progress` here.
            return require('lsp-progress').progress {
              max_size = 100,
            }
          end,
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
    -- winbar
    winbar = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {
        {
          'pretty_path',
          cond = function()
            return not vim.tbl_contains({
              'snacks_dashboard',
            }, vim.bo.filetype)
          end,
        },
        {
          'navic',
          color_correction = nil,
          navic_opts = nil,
        },
      },
      lualine_x = {
        {
          'diagnostics',
          symbols = {
            error = icons.diagnostics.Error .. ' ',
            warn = icons.diagnostics.Warn .. ' ',
            info = icons.diagnostics.Info .. ' ',
            hint = icons.diagnostics.Hint .. ' ',
          },
        },
      },
      lualine_y = {},
      lualine_z = {},
    },
    inactive_winbar = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { 'pretty_path' },
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
    -- inactive
    inactive_sections = {
      lualine_a = { 'mode' },
      lualine_b = {},
      lualine_c = { 'pretty_path' },
      lualine_x = { 'location' },
      lualine_y = {},
      lualine_z = {},
    },
    -- extensions = { 'lazy', 'fzf', 'trouble', 'overseer', 'toggleterm', 'oil' },
  })
end

LuaLine.init = function()
  -- listen lsp-progress event and refresh lualine
  vim.api.nvim_create_augroup('lualine_augroup', { clear = true })
  vim.api.nvim_create_autocmd('User', {
    group = 'lualine_augroup',
    pattern = 'LspProgressStatusUpdated',
    callback = require('lualine').refresh,
  })
end

return LuaLine
