local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

-- lspkind.nvim provides icons for lsp completion items
add { source = 'onsails/lspkind.nvim' }

-- treesitter syntax highlighting
add {
  source = 'nvim-treesitter/nvim-treesitter',
  checkout = 'main',
  monitor = 'main',
  -- Perform action after every checkout
  hooks = {
    post_checkout = function()
      vim.cmd 'TSUpdate'
    end,
  },
}

-- lsp configuration
add {
  source = 'neovim/nvim-lspconfig',
  depends = {
    'mason-org/mason.nvim',
    'mason-org/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    'saghen/blink.cmp',
  },
}

-- snacks.nvim provides a dashboard, file explorer, and other UI features
add { source = 'folke/snacks.nvim' }

-- noice - a noice UI for neovim
add {
  source = 'folke/noice.nvim',
  depends = {
    'MunifTanjim/nui.nvim',
    'rcarriga/nvim-notify',
  },
}

-- Otter.nvim provides lsp features and a code completion source for code embedded in other documents
add {
  source = 'jmbuhr/otter.nvim',
  depends = { 'nvim-treesitter/nvim-treesitter' },
}

require 'config.plugins.lspkind'
require 'config.plugins.treesitter'
require 'config.plugins.lspconfig'
require 'config.plugins.snacks'

later(function()
  require 'config.plugins.noice'
  require 'config.plugins.otter'
end)
