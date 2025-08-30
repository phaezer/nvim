-- NOTE: nonel-ls replaces null-ls
return {
  'nvimtools/none-ls.nvim',
  lazy = true,
  event = 'VeryLazy',
  dependencies = {
    'nvim-lua/plenary.nvim',
    -- NOTE: provides cspell integration
    'davidmh/cspell.nvim',
  },
  opts = function(_, opts)
    local cspell = require 'cspell'
    opts.sources = opts.sources or {}
    table.insert(
      opts.sources,
      cspell.diagnostics.with {
        diagnostics_postprocess = function(diagnostic)
          diagnostic.severity = vim.diagnostic.severity.HINT
        end,
      }
    )
    table.insert(opts.sources, cspell.code_actions)
  end,
}
