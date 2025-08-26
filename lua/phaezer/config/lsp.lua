local icons = require 'phaezer.core.icons'

--- get all lua filenames in the lsp config directory except init.lua and return as a table
local function get_lua_filenames_without_extension()
  local filenames = vim.split(vim.fn.glob(vim.fn.stdpath 'config' .. '/lsp/*.lua'), '\n')
  local result = {}
  for _, path in ipairs(filenames) do
    if not path:match 'init%.lua$' then
      table.insert(result, vim.fn.fnamemodify(path, ':t:r'))
    end
  end
  return result
end

-- LSP Settings
vim.diagnostic.config {
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = vim.diagnostic.severity.ERROR },
  virtual_text = {
    source = 'if_many',
    spacing = 2,
    format = function(diag)
      local diagnostic_message = {
        [vim.diagnostic.severity.ERROR] = diag.message,
        [vim.diagnostic.severity.WARN] = diag.message,
        [vim.diagnostic.severity.INFO] = diag.message,
        [vim.diagnostic.severity.HINT] = diag.message,
      }
      return diagnostic_message[diag.severity]
    end,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error .. ' ',
      [vim.diagnostic.severity.WARN] = icons.diagnostics.Warn .. ' ',
      [vim.diagnostic.severity.INFO] = icons.diagnostics.Info .. ' ',
      [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint .. ' ',
    },
  },
}

local lsps = get_lua_filenames_without_extension()

local capabilities = vim.lsp.protocol.make_client_capabilities()
-- local capabilities =
--   vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities({}, false))
capabilities = vim.tbl_deep_extend('force', capabilities, {
  textDocument = {
    foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    },
  },
})

vim.lsp.config('*', {
  root_markers = { '.git' },
  capabilities = capabilities,
})

for _, lsp in ipairs(lsps) do
  vim.lsp.enable(lsp)
end

return lsps
