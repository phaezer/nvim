-- rust lang support
-- src: https://github.com/mrcjkb/rustaceanvim
return {
  'mrcjkb/rustaceanvim',
  version = '^6',
  lazy = false,
  init = function()
    vim.g.rustaceanvim = {
      -- Plugin configuration
      tools = {
      },
      -- LSP configuration
      server = {
        on_attach = function(client, bufnr)
          -- todo: add keymaps here
        end,
        default_settings = {
          -- rust-analyzer language server configuration
          ['rust-analyzer'] = {
          },
        },
      },
      -- DAP configuration
      dap = {
      },
    }
  end,
}
