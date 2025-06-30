-- lspkind for icons in completion menu
local icons = Config.icon

return {
  'onsails/lspkind.nvim',
  lazy = false,
  config = function()
    require('lspkind').init({
      symbol_map = icons.kind,
    })
  end
}
