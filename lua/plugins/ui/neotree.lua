return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },
  opts = {
    filesystem = {
      window = {
        mappings = {
          ['\\'] = 'close_window',
        },
      },
    },
    source_selector = {
      winbar = true,
      statusline = true
    },
    window = {
      mappings = {
        ["P"] = {
          "toggle_preview",
          config = {
            use_float = false,
            -- use_image_nvim = true,
            -- title = 'Neo-tree Preview',
          },
        },
      }
    }
  },
}
