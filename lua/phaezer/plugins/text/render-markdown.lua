-- NOTE: provides completions for both checkboxes and callouts provided you follow the relevant setup
-- DOCS: https://github.com/MeanderingProgrammer/render-markdown.nvim/wiki
-- TODO: configure render-markdown.nvim further
return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim', 'nvim-tree/nvim-web-devicons' },
  opts = {
    completions = {
      lsp = { enabled = true },
      blink = { enabled = true },
    },
  },
}
