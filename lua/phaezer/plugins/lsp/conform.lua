-- NOTE: A formatter for Neovim
return {
  -- cSpell:words stevearc
  'stevearc/conform.nvim',
  lazy = true,
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- only format on save if set
      if not vim.g.format_on_save then return nil end
      local enabled_filetypes = {
        go = true,
        lua = true,
        typescript = true,
        typescriptreact = true,
        javascript = true,
        javascriptreact = true,
        rust = true,
        yaml = true,
      }
      if enabled_filetypes[vim.bo[bufnr].filetype] then
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
      tofu = { 'tofu_fmt' },
      yaml = { 'yamlfmt' },
      markdown = { 'markdownlint' },
    },
  },
  init = function()
    ---@diagnostic disable-next-line: inject-field
    vim.g.format_on_save = true
    require('phaezer.core.keys').map {
      prefix = '<leader>',
      plugin = 'conform',
      {
        'kf',
        function()
          local format_on_save = not vim.g.format_on_save
          ---@diagnostic disable-next-line: inject-field
          vim.g.format_on_save = format_on_save
          vim.notify('format on save: ' .. (format_on_save and 'enabled' or 'disabled'))
        end,
        desc = 'toggle format on save',
      },
      {
        'f',
        function() require('conform').format { async = true, lsp_format = 'fallback' } end,
        mode = 'n',
        desc = 'format buffer',
      },
    }
  end,
}
