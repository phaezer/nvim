local keys = require 'phaezer.lib.keys'
local api = vim.api

local group = api.nvim_create_augroup('textobjquote', { clear = true })

local function setup_textobj_quote(educate, bufnr)
  vim.cmd("call textobj#quote#init({'educate':" .. educate .. '})')
  keys.set { '<leader>mq', '<cmd>ToggleEducate<cr>', desc = 'Toggle Curl Quotes', buffer = bufnr }
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
