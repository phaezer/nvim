-- render-markdown.nvim - A plugin for rendering markdown in the chat buffer
-- src: https://github.com/MeanderingProgrammer/render-markdown.nvim

return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'echasnovski/mini.nvim'
  },
  ft = {
    "markdown",
    -- render markdown in the chat buffer
    "codecompanion"
  },
  opts = {
    completions = { lsp = { enabled = true } },
    render_on_save = true,
    render_on_save_delay = 1000,
    render_on_save_delay_type = 'ms',
  }
}
