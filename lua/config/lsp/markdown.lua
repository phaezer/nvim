---@type LangSpec
local M = {
  filetype = "markdown",
  patterns = { "*.md" },
  parsers  = { "lua", "luadoc" },
  cmp      = {
    sources = {
      'lsp',
      'path',
      'snippets',
      'buffer',
      -- 'copilot',
    }
  },
}

return M
