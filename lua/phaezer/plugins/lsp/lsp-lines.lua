return {
  'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
  event = 'LspAttach',
  config = function() require('lsp_lines').setup() end,
  keys = {
    {
      '<leader>udl',
      function()
        vim.diagnostic.config { virtual_lines = {
          highlight_whole_line = false,
        } }
      end,
      desc = 'Toggle LSP Lines',
    },
    {
      '<leader>udv',
      function() vim.diagnostic.config { virtual_text = true } end,
    },
  },
}
