return {
  -- TreeSitter
  -- NOTE: a parser generator for human-friendly languages
  -- DOCS: https://tree-sitter.github.io/tree-sitter/
  -- parsers found here: https://github.com/tree-sitter/tree-sitter/wiki/List-of-parsers
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    version = '*',
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = {
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
          'query',
          'regex',
          'regex',
          'rust',
          'scss',
          'sql',
          'svelte',
          'terraform',
          'toml',
          'typescript',
          'vim',
          'vimdoc',
          'yaml',
          'zig',
        },
        auto_install = true,
        highlight = {
          enable = true,
          -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
          --  If you are experiencing weird indenting issues, add the language to
          --  the list of additional_vim_regex_highlighting and disabled languages for indent.
          additional_vim_regex_highlighting = {
            'ruby',
          },
        },
        indent = {
          enable = true,
          disable = { 'ruby' },
        },
      }

      local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
      -- custom parser for kanata
      parser_config.kanata = {
        install_info = {
          url = '~/projects/tree-sitter-kanata',
          files = { 'src/parser.c' },
          generate_requires_npm = true, -- if stand-alone parser without npm dependencies
          requires_generate_from_grammar = true, -- if folder contains pre-generated src/parser.c
        },
        -- filetype = 'kbd', -- if filetype does not match the parser name
      }

      vim.treesitter.language.register('kanata', 'kbd')
    end,
    init = function()
      -- enable folding with treesitter
      vim.wo.foldmethod = 'expr'
      vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    end,
  },
  -- / TreeSitter

  -- TreeSitter Context
  -- NOTE: provides a contect window (similar to vscode)
  {
    'nvim-treesitter/nvim-treesitter-context',
    lazy = false,
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = {
      enable = true,
      max_lines = 5, -- Keep this 0 to disable max_lines
    },
  }, -- / TreeSitter Context
}
