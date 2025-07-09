---@type LangSpec
local M = {
  filetype = "typescript",
  patterns = { "*.ts" },
  parsers  = { "typescript", "typescriptreact" },
  cmp      = {
    sources = {
      'lsp',
      'path',
      'snippets',
      'buffer',
      'copilot',
    }
  },
  lsp      = {
    ts_ls = {},
  }
}

return M
