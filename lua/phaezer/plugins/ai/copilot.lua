-- CoPilot
-- NOTE: Setup with `:Copilot setup`
return {
  'github/copilot.vim',
  cmd = 'Copilot',
  enabled = false, -- disabled in favor of copilot-lsp
  event = 'BufWinEnter',
  -- SRC: https://github.com/fang2hou/blink-copilot
  init = function() vim.g.copilot_no_maps = true end,
  config = function()
    -- Block the normal Copilot suggestions
    vim.api.nvim_create_augroup('github_copilot', { clear = true })
    vim.api.nvim_create_autocmd({ 'FileType', 'BufUnload' }, {
      group = 'github_copilot',
      callback = function(args) vim.fn['copilot#On' .. args.event]() end,
    })
    vim.fn['copilot#OnFileType']()
  end,
}
