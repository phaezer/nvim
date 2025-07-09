vim.uv = vim.uv or vim.loop
vim.g.is_mac = vim.uv.os_uname().sysname:find 'Darwin' ~= nil
vim.g.is_win = vim.uv.os_uname().sysname:find 'Windows' ~= nil
vim.g.is_linux = vim.uv.os_uname().sysname:find 'Linux' ~= nil
vim.g.is_bsd = vim.uv.os_uname().sysname:find 'BSD' ~= nil

-- mini deps
local path_package = vim.fn.stdpath 'data' .. '/site'
local mini_path = path_package .. '/pack/deps/start/mini.nvim'

if not vim.loop.fs_stat(mini_path) then
  vim.cmd 'echo "Installing `mini.nvim`" | redraw'
  --stylua: ignore
  local clone_cmd = {
    'git', 'clone', '--filter=blob:none', '--branch', 'stable',
    'https://github.com/echasnovski/mini.nvim', mini_path,
  }
  vim.fn.system(clone_cmd)
  vim.cmd 'packadd mini.nvim | helptags ALL'
  vim.cmd 'echo "Installed `mini.nvim`" | redraw'
end

require('mini.deps').setup { path = { package = path_package } }
require 'themes'
require 'plugins'
require 'config.opt'
require 'config.keymap'

-- Put this at the top of 'init.lua'

-- -- [[ Install `lazy.nvim` plugin manager ]]
-- --    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
-- local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

-- if not vim.uv.fs_stat(lazypath) then
--   local out = vim.fn.system({
--     'git',
--     'clone',
--     '--filter=blob:none',
--     '--branch=stable',
--     'https://github.com/folke/lazy.nvim.git',
--     lazypath
--   })

--   if vim.v.shell_error ~= 0 then
--     error('Error cloning lazy.nvim:\n' .. out)
--   end
-- end

-- vim.opt.rtp:prepend(lazypath)

-- local lazy_config = require 'config.lazy'

-- lazy_config.spec = {
--   { import = 'plugins' },
--   { import = 'plugins/ui' },
--   { import = 'plugins/themes' },
--   { import = 'plugins/editor' },
--   { import = 'plugins/lsp' },
--   { import = 'plugins/lang' },
--   { import = 'plugins/ai' },
-- }

-- require('lazy').setup(lazy_config)
