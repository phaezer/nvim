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
  keys = {
    { '<leader>ms', '<cmd>Mason<cr>', desc = 'Mason' },
    { '<leader>mu', '<cmd>MasonUpdate<cr>', desc = 'update Mason' },
    { '<leader>ml', '<cmd>MasonLog<cr>', desc = 'Mason log' },
  },
}
