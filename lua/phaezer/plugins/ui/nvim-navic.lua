-- NOTE: adds breadcrumbs to winbar
local util = require 'phaezer.core.util'
local icons = require 'phaezer.core.icons'

return {
  'SmiteshP/nvim-navic',
  lazy = 'VeryLazy',
  dependencies = 'neovim/nvim-lspconfig',
  opts = {
    icons = util.format_all('%s ', icons.kind),
    highlight = true,
    separator = '  ',
    depth_limit_indicator = '',
    click = true,
  },
  init = function()
    local navic = require 'nvim-navic'
    local disabled_lsps = {
      ['GitHub Copilot'] = true,
      null_ls = true,
    }

    -- attach to buffers
    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if
          not client
          or not client.server_capabilities.documentSymbolProvider
          or disabled_lsps[client.name]
        then
          return
        end

        navic.attach(client, event.buf)
      end,
    })
  end,
}
