-- Vim Text Objects
-- NOTE: Helps add typographic quotes
return {
  'preservim/vim-textobj-quote',
  lazy = true,
  event = 'BufEnter',
  dependencies = { 'kana/vim-textobj-user' },
  config = function()
    local keys = require 'phaezer.core.keys'
    local api = vim.api
    local group = api.nvim_create_augroup('textobjquote', { clear = true })

    local function setup_textobj_quote(bufnr)
      vim.cmd 'call textobj#quote#init({"educate": 0})'
      keys.map {
        {
          '<leader>mq',
          '<cmd>ToggleEducate<cr>',
          desc = 'Toggle Typographic Quotes',
          buffer = bufnr,
        },
      }
    end

    api.nvim_create_autocmd('FileType', {
      group = group,
      pattern = { 'markdown', 'textile', 'text' },
      desc = 'setup textobj-quote for curl quotes',
      callback = function(ev) setup_textobj_quote(ev.buf) end,
    })
  end,
}
