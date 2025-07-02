return {
  ui = {
    size = { width = 1, height = 1 },
    border = 'none',
    backdrop = 80,
    wrap = false,
    icons = {
      cmd = ' ',
      config = ' ',
      event = ' ',
      init = ' ',
      imports = '󰋺 ',
      keys = ' ',
      lazy = '󰒲 ',
      runtime = ' ',
      loaded = ' ',
      not_loaded = ' ',
      plugin = ' ',
      require = ' ',
      source = ' ',
      start = ' ',
      task = ' ',
      list = {
        '●',
        '➜',
        '★',
        '─',
      },
    },
  },
  diff = {
    -- diff command <d> can be one of:
    -- * browser: opens the github compare view. Note that this is always mapped to <K> as well,
    --   so you can have a different command for diff <d>
    -- * git: will run git diff and open a buffer with filetype git
    -- * terminal_git: will open a pseudo terminal with git diff
    -- * diffview.nvim: will open Diffview to show the diff
    cmd = 'terminal_git',
  },
  performance = {
    cache = {
      enabled = true,
    },
    reset_packpath = true, -- reset the package path to improve startup time
    rtp = {
      reset = true, -- reset the runtime path to $VIMRUNTIME and your config directory
      ---@type string[]
      paths = {}, -- add any custom paths here that you want to includes in the rtp
      ---@type string[] list any plugins you want to disable here
      disabled_plugins = {
        'gzip',
        'matchit',
        'matchparen',
        'netrwPlugin',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
}
