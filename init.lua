vim.uv = vim.uv or vim.loop
vim.g.termguicolors = true

require 'core.lib.strings'

require 'config.opt'
-- set up the keymaps
require 'config.keymap'

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

local lazy_config = require 'config.lazy'

local spec = {
  { import = 'plugins' },
  { import = 'plugins/ui' },
  { import = 'plugins/themes' },
  { import = 'plugins/editor' },
  { import = 'plugins/lsp' },
  { import = 'plugins/languages' },
  { import = 'plugins/ai' },
}

lazy_config.spec = spec

require('lazy').setup(lazy_config)
