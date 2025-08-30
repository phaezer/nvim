-- Trouble
-- NOTE: for LSP problems, diagnostics, quickfix and location lists
return {
  'folke/trouble.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  cmd = { 'Trouble', 'TroubleToggle', 'TroubleRefresh' },
  keys = {
    {
      '<leader>x',
      function()
        local trouble = require 'trouble'
        if trouble.is_open() then
          trouble.close()
        else
          vim.cmd 'Trouble diagnostics toggle auto_jump=false'
        end
      end,
      desc = 'Open Trouble',
      mode = 'n',
    },
  },
  config = function()
    local trouble = require 'trouble'
    local icons = require 'phaezer.core.icons'
    trouble.setup {
      auto_jump = true,
      signs = {
        error = icons.diagnostics.Error,
        warning = icons.diagnostics.Warn,
        hint = icons.diagnostics.Hint,
        information = icons.diagnostics.Info,
        other = icons.diagnostics.Info,
      },
      modes = {
        lsp_references = {
          params = { include_declaration = true },
        },
        lsp_base = {
          params = { include_current = true },
        },
      },
    }

    local map = require('phaezer.core.keys').map
    map {
      mode = 'n',
      {
        ']t',
        function() trouble.next { jump = true, skip_groups = true } end,
        desc = 'jump to next trouble entry',
      },
      {
        '[t',
        function() trouble.prev { jump = true, skip_groups = true } end,
        desc = 'jump to prev trouble entry',
      },
    }
  end,
}
