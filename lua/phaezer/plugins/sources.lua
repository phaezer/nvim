local add = MiniDeps.add

-- ========================================================================
-- LSP and related plugins
-- ------------------------------------------------------------------------

add {
  -- lspkind.nvim provides icons for lsp completion items
  source = 'onsails/lspkind.nvim',
}

add {
  -- lspconfig provides configuration for Neovim's built-in LSP client
  source = 'neovim/nvim-lspconfig',
  depends = {
    'mason-org/mason.nvim',
    'mason-org/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    'saghen/blink.cmp',
  },
}

add {
  -- Otter.nvim provides lsp features and a code completion source for code embedded in other documents
  source = 'jmbuhr/otter.nvim',
  depends = { 'nvim-treesitter/nvim-treesitter' },
}

-- ========================================================================
-- Treesitter and related plugins
-- ------------------------------------------------------------------------

add {
  -- treesitter syntax highlighting
  source = 'nvim-treesitter/nvim-treesitter',
  checkout = 'main',
  monitor = 'main',
  -- Perform action after every checkout
  hooks = { post_checkout = function() vim.cmd 'TSUpdate' end },
}

-- ========================================================================
-- UI plugins
-- ------------------------------------------------------------------------

add {
  -- snacks.nvim provides a dashboard, file explorer, and other UI features
  source = 'folke/snacks.nvim',
}

add {
  -- UI Component Library for Neovim.
  source = 'MunifTanjim/nui.nvim',
}

add {
  -- noice - a noice UI for neovim
  source = 'folke/noice.nvim',
  depends = {
    'MunifTanjim/nui.nvim',
    'rcarriga/nvim-notify',
  },
}
