local M = {
  filetype = "rust",
  rust     = { "*.rs" },
  parsers  = {
    "rust",
  },
  cmp      = {
    sources = { 'lsp', 'path', 'snippets', 'buffer', 'copilot' }
  },
  env      = {},
}

return M
