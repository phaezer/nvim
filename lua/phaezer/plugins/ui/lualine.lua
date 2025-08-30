local util = require 'phaezer.core.util'
local icons = require 'phaezer.core.icons'

-- LuaLine
-- NOTE: a statusline plugin for Neovim
local LuaLine = {
  'nvim-lualine/lualine.nvim',
  lazy = false,
  dependencies = {
    'bwpge/lualine-pretty-path',
  },
}

LuaLine.opts = function(_, opts)
  -- local has_lsp = function() return next(vim.lsp.get_clients()) ~= nil end
  local buffer_not_empty = function() return vim.fn.empty(vim.fn.expand '%:t') ~= 1 end
  -- local mode = require 'lualine.utils.mode'
  local highlight = require 'lualine.highlight'

  local function get_mode_hl(prop)
    local suffix = highlight.get_mode_suffix()
    return util.color('lualine_a_' .. suffix, prop)
  end

  return vim.tbl_deep_extend('force', opts or {}, {
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
          icon = icons.gui.Neovim,
        },
      },
      lualine_b = {},
      lualine_c = {
        { 'branch', icon = icons.gui.Branch, padding = { left = 1, right = 0 } },
        { 'pretty_path', padding = { left = 1, right = 0 } },
        { 'filesize', cond = buffer_not_empty },
        {
          'diagnostics',
          symbols = icons.diagnostics,
          {
            function() return require('noice').api.status.command.get() end,
            cond = function()
              return package.loaded['noice'] and require('noice').api.status.command.has()
            end,
            color = function() return { fg = util.color 'Statement' } end,
          },
          {
            function() return require('noice').api.status.mode.get() end,
            cond = function()
              return package.loaded['noice'] and require('noice').api.status.mode.has()
            end,
            color = function() return { fg = util.color 'Constant' } end,
          },
          {
            function() return ' ' .. require('dap').status() end,
            cond = function() return package.loaded['dap'] and require('dap').status() ~= '' end,
            color = function() return { fg = util.color 'Debug' } end,
          },
        },
      },
      lualine_x = {
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
            separator = '/',
          },
          ignore_lsp = {
            'null-ls',
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
          color = function() return { fg = get_mode_hl 'fg', gui = 'bold' } end,
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
    extensions = { 'neo-tree', 'lazy', 'fzf', 'trouble' },
  })
end

return LuaLine
