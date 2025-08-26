-- NOTE: copilot-lsp provides next edit prediction
return {
  'copilotlsp-nvim/copilot-lsp',
  init = function()
    vim.g.copilot_nes_debounce = 300
    vim.lsp.enable 'copilot_ls'
  end,
}
