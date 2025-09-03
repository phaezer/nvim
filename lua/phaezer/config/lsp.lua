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

local diag_icon_map = {
  [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
  [vim.diagnostic.severity.WARN] = icons.diagnostics.Warn,
  [vim.diagnostic.severity.INFO] = icons.diagnostics.Info,
  [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
}

-- LSP Settings
vim.diagnostic.config {
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = true,
  virtual_text = {
    source = 'if_many',
    prefix = '',
    current_line = true,
    severity = { vim.diagnostic.severity.HINT, vim.diagnostic.severity.INFO },
    format = function(diag)
      return diag_icon_map[diag.severity] .. ' ' .. diag.message .. ' '
    end,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error .. ' ',
      [vim.diagnostic.severity.WARN] = icons.diagnostics.Warn .. ' ',
      [vim.diagnostic.severity.INFO] = icons.diagnostics.Info .. ' ',
      [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint .. ' ',
    },
    format = function() end,
  },
  virtual_lines = {
    severity = { min = vim.diagnostic.severity.WARN },
    format = function(diag)
      return diag_icon_map[diag.severity] .. ' ' .. diag.message
    end,
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
