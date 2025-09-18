-- Mason
-- NOTE: Mason manages external tooling
-- DOCS: registry: https://mason-registry.dev/registry/list
return {
  'mason-org/mason.nvim',
  lazy = false, -- disabled, transitioning to native LSP
  priority = 10,
  opts = {
    pip = {
      upgrade_pip = true,
    },
    ui = {
      icons = {
        package_installed = '',
        package_pending = '',
        package_uninstalled = '',
      },
    },
  },
  init = function()
    require('phaezer.core.keys').map {
      mode = 'n',
      prefix = '<leader>m',
      plugin = 'Mason',
      { 'm', '<cmd>Mason<cr>', desc = 'Mason' },
      { 'u', '<cmd>MasonUpdate<cr>', desc = 'update Mason' },
      { 'l', '<cmd>MasonLog<cr>', desc = 'Mason log' },
    }
  end,
}
