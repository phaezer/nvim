local icons = require 'config.icon'

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

if not vim.uv.fs_stat(lazypath) then
  local out = vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    '--branch=stable',
    'https://github.com/folke/lazy.nvim.git',
    lazypath
  })

  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

vim.opt.rtp:prepend(lazypath)

return {
  ui = {
    size = { width = 1, height = 1 },
    border = "none",
    backdrop = 80,
    wrap = false,
    icons = {
      cmd = icons.ui.Cmd .. " ",
      config = icons.ui.Config .. " ",
      event = icons.ui.Event .. " ",
      init = icons.ui.Init .. " ",
      imports = icons.ui.Imports .. " ",
      keys = icons.ui.Keys .. " ",
      lazy = icons.ui.Lazy .. " ",
      runtime = icons.ui.Runtime .. " ",
      loaded = icons.ui.Loaded .. " ",
      not_loaded = icons.ui.NotLoaded .. " ",
      plugin = icons.ui.Plugin .. " ",
      require = icons.ui.Require .. " ",
      source = icons.ui.Source .. " ",
      start = icons.ui.Start .. " ",
      task = icons.ui.Task .. " ",
      list = {
        "●",
        "➜",
        "★",
        "─",
      },
    }
  },
  diff = {
    -- diff command <d> can be one of:
    -- * browser: opens the github compare view. Note that this is always mapped to <K> as well,
    --   so you can have a different command for diff <d>
    -- * git: will run git diff and open a buffer with filetype git
    -- * terminal_git: will open a pseudo terminal with git diff
    -- * diffview.nvim: will open Diffview to show the diff
    cmd = "terminal_git",
  },
  performance = {
    cache = {
      enabled = true,
    },
    reset_packpath = true, -- reset the package path to improve startup time
    rtp = {
      reset = true,        -- reset the runtime path to $VIMRUNTIME and your config directory
      ---@type string[]
      paths = {},          -- add any custom paths here that you want to includes in the rtp
      ---@type string[] list any plugins you want to disable here
      disabled_plugins = {
        -- "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        -- "tarPlugin",
        -- "tohtml",
        -- "tutor",
        -- "zipPlugin",
      },
    },
  }
}
