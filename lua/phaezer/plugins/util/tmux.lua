return {
  -- NOTE: provides seemless navigation between Neovim splits and tmux panes
  {
    'alexghergh/nvim-tmux-navigation',
    cond = not vim.g.neovide,
    lazy = false,
    opts = {
      disable_when_zoomed = true, -- defaults to false
      keybindings = {
        left = '<C-h>',
        down = '<C-j>',
        up = '<C-k>',
        right = '<C-l>',
        last_active = '<C-\\>',
        next = '<C-Space>',
      },
    },
  },
}
