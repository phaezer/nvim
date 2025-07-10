local now, later = MiniDeps.now, MiniDeps.later

now(function()
  -- mini plugins
  require 'phaezer.config.plugins.mini.ai'
  require 'phaezer.config.plugins.mini.comment'
  require 'phaezer.config.plugins.mini.pairs'
  require 'phaezer.config.plugins.mini.move'
  require 'phaezer.config.plugins.mini.files'

  require 'phaezer.config.plugins.lspkind'
  require 'phaezer.config.plugins.treesitter'
  require 'phaezer.config.plugins.lspconfig'
  require 'phaezer.config.plugins.snacks'
end)

later(function()
  require 'phaezer.config.plugins.noice'
  require 'phaezer.config.plugins.otter'
end)
