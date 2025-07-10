local lang_list = {
  'go',
  'lua',
  'python',
  'rust',
  'terraform',
  'ansible',
  'typescript',
  'yaml',
}

local default_lsp_servers = {
  cmake = {},
  -- rust_analyzer = {}, -- disabled as this is provided by rustacean

  -- ansible requires npm package ansible-language-server
  -- src: https://github.com/neovim/nvim-lspconfig/blob/master/lsp/ansiblels.lua
  ansiblels = {},
  eslint = {},
  -- docker ls requires npm package dockerfile-language-server-nodejs
  -- src: https://github.com/neovim/nvim-lspconfig/blob/master/lsp/dockerls.lua
  dockerls = {},
  tofu_ls = {},
  -- bash ls requires npm package bash-language-server
  -- src: https://github.com/neovim/nvim-lspconfig/blob/master/lsp/bashls.lua
  bashls = {},
}

local configs = vim.iter(lang_list):map(function(lang)
  return require('config.lang.' .. lang)
end):totable()

local M = {}

function M.lsp_servers(servers)
  local servers = vim.list_extend(default_lsp_servers, servers or {})
  vim.iter(configs)
      :filter(function(c) return c.lsp ~= nil end)
      :map(function(c) return c.lsp end)
      :each(function(k, v) servers[k] = v end)
  return servers
end

---@param defaults table<string, string[]>
---@return table<string, string[]>
function M.cmp_sources(defaults)
  local sources = defaults or {}
  vim.iter(configs)
      :filter(function(c) return c.cmp ~= nil and c.cmp.sources and #c.cmp.sources > 0 end)
      :each(function(c) sources[c.filetype] = c.cmp.sources end)
  return sources
end

return M
