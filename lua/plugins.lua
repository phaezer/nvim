local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

-- lspkind.nvim provides icons for lsp completion items
add { source = 'onsails/lspkind.nvim' }
require 'config.plugins.lspkind'

-- treesitter syntax highlighting
add {
  source = 'nvim-treesitter/nvim-treesitter',
  checkout = 'main',
  monitor = 'main',
  -- Perform action after every checkout
  hooks = {
    post_checkout = function() vim.cmd 'TSUpdate' end,
  },
}
require 'config.plugins.treesitter'

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
require 'config.plugins.lspconfig'

-- snacks.nvim provides a dashboard, file explorer, and other UI features
add { source = 'folke/snacks.nvim' }
require 'config.plugins.snacks'

-- noice - a noice UI for neovim
add {
  source = 'folke/noice.nvim',
  depends = {
    'MunifTanjim/nui.nvim',
    'rcarriga/nvim-notify',
  },
}

-- vim.api.nvim_create_autocmd('VimEnter', {
--   group = vim.api.nvim_create_augroup('NoiceStart', { clear = true }),
--   -- pattern = 'VeryLazy',
--   callback = function() require 'config.plugins.noice' end,
-- })

later(function() require 'config.plugins.noice' end)
-- require 'config.plugins.noice'

-- Otter.nvim provides lsp features and a code completion source for code embedded in other documents
add {
  source = 'jmbuhr/otter.nvim',
  depends = { 'nvim-treesitter/nvim-treesitter' },
}
-- later(function() require 'config.plugins.otter' end)
