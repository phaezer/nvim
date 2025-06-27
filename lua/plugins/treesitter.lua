-- [[ Configure Treesitter ]] See `:help nvim-treesitter`

-- docs: https://github.com/nvim-treesitter/nvim-treesitter

local parsers = {
  'bash',
  'c',
  'css',
  'diff',
  'dockerfile',
  'git_config',
  'git_rebase',
  'gitattributes',
  'gitcommit',
  'gitignore',
  'go',
  'gomod',
  'gosum',
  'gotmpl',
  'graphql',
  'html',
  'javascript',
  'jq',
  'json',
  'lua',
  'luadoc',
  'make',
  'markdown_inline',
  'markdown',
  'mermaid',
  'nginx',
  'nix',
  'python',
  'query',
  'regex',
  'rust',
  'scss',
  'sql',
  'terraform',
  'toml',
  'typescript',
  'vim',
  'vimdoc',
  'yaml',
  'zig',
}

return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  lazy = false,
  -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
  config = function()
    require('nvim-treesitter.configs').setup {
      -- parsers found here: https://github.com/tree-sitter/tree-sitter/wiki/List-of-parsers
      ensure_installed = parsers,
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = {
          'ruby'
        }
      },
      indent = {
        enable = true,
        disable = { 'ruby' }
      }
    }

    -- enable folding with treesitter
    vim.wo.foldmethod = 'expr'
    vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
  end,
}
