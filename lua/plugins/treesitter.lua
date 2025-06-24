-- [[ Configure Treesitter ]] See `:help nvim-treesitter`

-- docs: https://github.com/nvim-treesitter/nvim-treesitter

return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  main = 'nvim-treesitter.configs', -- Sets main module to use for opts
  -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
  opts = {
    ensure_installed = {
      'bash',
      'c',
      'diff',
      'html',
      'lua',
      'luadoc',
      'markdown',
      'markdown_inline',
      'query',
      'vim',
      'vimdoc',
      'go',
      'gosum',
      'gomod',
      'typescript',
      'javascript',
      'json',
      'yaml',
      'toml',
      'rust',
      'python',
      'graphql',
      'terraform',
      'sql',
      'zig',
      'regex',
      'make',
      'gitignore',
      'gitcommit',
      'git_config',
      'git_rebase',
      'gitattributes',
    },
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
  },
}
