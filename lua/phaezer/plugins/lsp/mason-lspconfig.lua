-- Mason LSPConfig
-- NOTE: mason-lspconfig bridges mason.nvim with the lspconfig plugin
return {
  'mason-org/mason-lspconfig.nvim',
  lazy = false,
  priority = 100,
  dependencies = {
    'mason-org/mason.nvim',
  },
  opts = {
    ensure_installed = {
      'gopls', -- go
      'basedpyright', -- python
      'biome', -- json, javascript, typescript
    },
    automatic_enable = {
      exclude = {
        'rust_analyzer', -- handled by rustacean
      },
    },
  },
}
