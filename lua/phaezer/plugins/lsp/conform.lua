-- NOTE: A formatter for Neovim
return {
  'stevearc/conform.nvim',
  lazy = true,
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- Disable "format_on_save lsp_fallback" for languages that don't
      -- have a well standardized coding style. You can add additional
      -- languages here or re-enable it for the disabled ones.
      local disable_filetypes = { c = true, cpp = true }
      if disable_filetypes[vim.bo[bufnr].filetype] then
        return nil
      else
        return {
          timeout_ms = 500,
          lsp_format = 'fallback',
        }
      end
    end,
    formatters_by_ft = {
      lua = { 'stylua' },
      go = { 'gofumpt', 'goimports' },
      -- You can customize some of the format options for the filetype (:help conform.format)
      rust = { 'rustfmt', lsp_format = 'fallback' },
      python = { 'ruff_format', 'ruff_organize_imports', 'ruff_fix' },
      javascript = { 'prettierd', 'prettier', stop_after_first = true },
      mojo = { 'mojo_format' },
      typescript = { 'prettierd', 'prettier', stop_after_first = true },
      typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
      javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
      json = { 'prettierd', 'prettier', stop_after_first = true },
      jsonc = { 'prettierd', 'prettier', stop_after_first = true },
      zig = { 'zigfmt' },
      terraform = { 'tofu_fmt' },
      yaml = { 'yamlfmt' },
    },
  },
  keys = {
    {
      '<leader>kf',
      function() require('conform').format { async = true, lsp_format = 'fallback' } end,
      mode = 'n',
      desc = 'format  conform',
    },
  },
}
