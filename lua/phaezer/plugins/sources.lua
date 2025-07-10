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
-- language parsing
-- ------------------------------------------------------------------------

add {
  -- treesitter syntax highlighting
  source = 'nvim-treesitter/nvim-treesitter',
  checkout = 'main',
  monitor = 'main',
  -- Perform action after every checkout
  hooks = { post_checkout = function() vim.cmd 'TSUpdate' end },
}

add {
  -- ansible support
  source = 'pearofducks/ansible-vim',
}

add {
  -- curl quotes support for text objects
  source = 'preservim/vim-textobj-quote',
  depends = { 'kana/vim-textobj-user' },
}

-- ========================================================================
-- UI plugins
-- ------------------------------------------------------------------------

add {
  -- snacks.nvim provides a dashboard, file explorer, and other UI features
  source = 'folke/snacks.nvim',
}

add {
  -- which key, a keybinding helper for Neovim
  source = 'folke/which-key.nvim',
}

add {
  -- noice - a noice UI for neovim
  source = 'folke/noice.nvim',
  depends = {
    'MunifTanjim/nui.nvim',
    'rcarriga/nvim-notify',
  },
}

-- ========================================================================
-- UI plugins
-- ------------------------------------------------------------------------
