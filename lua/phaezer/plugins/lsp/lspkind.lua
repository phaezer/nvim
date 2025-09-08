-- LSPKind
-- NOTE: provides vscode-like pictograms for neovim lsp completion items
return {
  'onsails/lspkind.nvim',
  lazy = false,
  priority = 1000, -- high priority to ensure icons are loaded early
  opts = {
    symbol_map = require('phaezer.core.icons').kind,
  },
}
