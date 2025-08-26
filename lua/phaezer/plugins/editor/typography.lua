return {
  -- ==============================================================================================
  -- Vim Text Objects
  -- NOTE: Helps add typographic quotes
  {
    'preservim/vim-textobj-quote',
    lazy = true,
    event = 'BufEnter',
    dependencies = { 'kana/vim-textobj-user' },
    config = function()
      local keys = require 'phaezer.core.keys'
      local api = vim.api
      local group = api.nvim_create_augroup('textobjquote', { clear = true })

      local function setup_textobj_quote(educate, bufnr)
        vim.cmd("textobj#quote#init({'educate':" .. educate .. '})')
        keys.set { '<leader>mq', '<cmd>ToggleEducate<cr>', desc = 'Toggle Typographic Quotes', buffer = bufnr }
      end

      api.nvim_create_autocmd('FileType', {
        group = group,
        pattern = { 'markdown', 'textile' },
        desc = 'setup textobj-quote for curl quotes',
        callback = function(ev) setup_textobj_quote(1, ev.buf) end,
      })

      api.nvim_create_autocmd('FileType', {
        group = group,
        pattern = { 'text' },
        desc = 'setup textobj-quote for curl quotes',
        callback = function(ev) setup_textobj_quote(0, ev.buf) end,
      })
    end,
  }, -- / vim-textobj-quote
}
