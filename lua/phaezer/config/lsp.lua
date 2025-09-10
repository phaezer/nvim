---@diagnostic disable: need-check-nil
local icons = require 'phaezer.core.icons'

-- Store buffers attached to each LSP client
local attached_buffers_by_client = {}
-- Store configurations for each LSP client
local client_configs = {}

--- get all lua filenames in the lsp config directory except init.lua and return as a table
local function get_lua_filenames_without_extension()
  local filenames = vim.split(vim.fn.glob(vim.fn.stdpath 'config' .. '/lsp/*.lua'), '\n')
  local result = {}
  for _, path in ipairs(filenames) do
    if not path:match 'init%.lua$' then
      table.insert(result, vim.fn.fnamemodify(path, ':t:r'))
    end
  end
  return result
end

local diag_icon_map = {
  [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
  [vim.diagnostic.severity.WARN] = icons.diagnostics.Warn,
  [vim.diagnostic.severity.INFO] = icons.diagnostics.Info,
  [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
}

-- LSP Settings
vim.diagnostic.config {
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = true,
  virtual_text = {
    source = 'if_many',
    prefix = '',
    current_line = true,
    severity = { vim.diagnostic.severity.HINT, vim.diagnostic.severity.INFO },
    format = function(diag)
      return diag_icon_map[diag.severity] .. ' ' .. diag.message .. ' '
    end,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error .. ' ',
      [vim.diagnostic.severity.WARN] = icons.diagnostics.Warn .. ' ',
      [vim.diagnostic.severity.INFO] = icons.diagnostics.Info .. ' ',
      [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint .. ' ',
    },
    format = function() end,
  },
  virtual_lines = {
    severity = { min = vim.diagnostic.severity.WARN },
    format = function(diag)
      return diag_icon_map[diag.severity] .. ' ' .. diag.message
    end,
  },
}

local lsps = get_lua_filenames_without_extension()

local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities =
-- vim.tbl_deep_extend('force', capabilities, require('blink').get_lsp_capabilities({}, false))
capabilities = vim.tbl_deep_extend('force', capabilities, {
  textDocument = {
    foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    },
  },
})

vim.lsp.config('*', {
  root_markers = { '.git' },
  capabilities = capabilities,
})

for _, lsp in ipairs(lsps) do
  vim.lsp.enable(lsp)
end

-- Store a reference to the original buf_attach_client function
local original_buf_attach_client = vim.lsp.buf_attach_client

-- Function to add a buffer to the client's buffer table
local function add_buf(client_name, buf)
  if not attached_buffers_by_client[client_name] then
    attached_buffers_by_client[client_name] = {}
  end

  -- Check if the buffer is already in the list
  local exists = false
  for _, value in ipairs(attached_buffers_by_client[client_name]) do
    if value == buf then
      exists = true
      break
    end
  end

  -- Add the buffer if it doesn’t already exist in the client’s list
  if not exists then
    table.insert(attached_buffers_by_client[client_name], buf)
  end
end

-- Middleware function to control LSP client attachment to buffers
-- Prevents LSP client from reattaching if LSPs are disabled
vim.lsp.buf_attach_client = function(bufnr, client_id)
  -- get the client
  local client = vim.lsp.get_client_by_id(client_id)

  if not client then
    return original_buf_attach_client(bufnr, client_id)
  end

  local client_config = (client and client.config) or {}

  if not client_configs[client.name] then
    client_configs[client.name] = {
      config = client_config,
      enabled = true,
    }
  end

  if not client_configs[client.name].config then
    client_configs[client.name].config = client_config
  end

  if not client_configs[client.name].enabled then
    add_buf(client.name, bufnr)
    vim.lsp.stop_client(client_id)
    return false
  end

  return original_buf_attach_client(bufnr, client_id) -- Use the original attachment method if enabled LSP
end

-- Stops the client, waiting up to 5 seconds; force quits if needed
local function client_stop(client)
  vim.lsp.stop_client(client.id, false)

  local timer = vim.uv.new_timer() -- Create a timer
  local max_attempts = 50 -- Set max attempts to check if stopped
  local attempts = 0 -- Track the number of attempts

  timer:start(
    100,
    100,
    vim.schedule_wrap(function()
      attempts = attempts + 1
      if client.is_stopped() then -- Check if the client is stopped
        timer:stop()
        timer:close()
        vim.diagnostic.reset() -- Reset diagnostics for the client
      elseif attempts >= max_attempts then -- If max attempts reached
        vim.lsp.stop_client(client.id, true) -- Force stop the client
        timer:stop()
        timer:close()
        vim.diagnostic.reset() -- Reset diagnostics for the client
      end
    end)
  )
end

-- Toggle LSPs on or off, managing client states and attached buffers
local function toggle_lsp(name)
  if not client_configs[name] then
    return false
  end

  local lsp_enabled = client_configs[name].enabled

  if lsp_enabled then -- If LSP is currently enabled, disable it
    for _, client in ipairs(vim.lsp.get_clients { name = name }) do
      -- cache the config
      client_configs[client.name].config = client.config
      for buf, _ in pairs(client.attached_buffers) do
        add_buf(client.name, buf) -- Add buffer to the client’s buffer table
        vim.lsp.buf_detach_client(buf, client.id) -- Detach the client from the buffer
      end
      client_stop(client) -- Stop the client
    end

    vim.notify('LSP ' .. name .. ' has been disabled')
  else -- If LSP is currently disabled, enable it
    local new_ids = {}

    -- Reinitialize clients with previous configurations
    for client_name, buffers in pairs(attached_buffers_by_client) do
      local client_config = client_configs[name].config -- Retrieve client config
      local new_client_id, err = vim.lsp.start_client(client_config) -- Start client with config

      if err then -- Notify if there was an error starting the client
        vim.notify(err, vim.log.levels.WARN)
        return nil
      end

      -- Reattach buffers to the newly started client
      for _, buf in ipairs(buffers) do
        original_buf_attach_client(buf, new_client_id)
      end
    end

    vim.notify('LSP ' .. name .. ' has been enabled')
  end

  client_configs[name].enabled = not lsp_enabled
end

vim.api.nvim_create_user_command('ToggleLSP', function(opts)
  local lsp_name = opts.fargs[1]
  if not lsp_name then
    vim.notify('LSP name must be provided', vim.log.levels.ERROR)
  end
  toggle_lsp(lsp_name)
end, { nargs = 1 })

local function toggle_select()
  local client_names = {}
  for _, client in ipairs(vim.lsp.get_clients()) do
    client_names[client.name] = true
  end
  for client_name, _ in pairs(client_configs) do
    client_names[client_name] = true
  end

  vim.ui.select(vim.tbl_keys(client_names), {
    prompt = 'Select LSP to toggle',
    format_item = function(item)
      return item
    end,
  }, function(choice)
    toggle_lsp(choice)
  end)
end

vim.api.nvim_create_user_command('ToggleLSPSelect', function()
  toggle_select()
end, { nargs = 0 })

return lsps
