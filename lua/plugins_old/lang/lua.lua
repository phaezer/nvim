return {
  {
    -- Lazydev is a plugin that allows you to use lazydev to manage your plugins
    -- SRC: https://github.com/folke/lazydev.nvim
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  }
}
