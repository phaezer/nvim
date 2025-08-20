vim.uv = vim.uv or vim.loop

local colorscheme = 'tokyonight'

require 'phaezer.config'

-- Lazy.nvim setup
-- DOCS: `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

if not vim.uv.fs_stat(lazypath) then
  local out = vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    '--branch=stable',
    'https://github.com/folke/lazy.nvim.git',
    lazypath,
  }

  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require 'phaezer.config.lazy'

lazy_config.spec = {
  { import = 'phaezer.plugins' },
  { import = 'phaezer.plugins.lang' },
}

require('lazy').setup(lazy_config)

vim.cmd 'set nolist'
vim.cmd('colorscheme ' .. colorscheme)
