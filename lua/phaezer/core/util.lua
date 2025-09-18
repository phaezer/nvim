---@alias os_name 'win' | 'linux' | 'mac' | 'bsd' | 'any'

local M = {
  DIR_SEP = require('package').config:sub(1, 1),
}

-- Execute a function if the OS is Windows
---@param f function The function to execute if the OS is Windows
---@return any the result of the function if vscode else nil
function M.if_vscode(f)
  if vim.g.vscode then
    return f()
  end
end

local os_map = {
  win = function()
    return vim.g.is_win
  end,
  linux = function()
    return vim.g.is_linux
  end,
  mac = function()
    return vim.g.is_mac
  end,
  bsd = function()
    return vim.g.is_bsd
  end,
  any = function()
    return true
  end,
}

--- Check if the OS is Windows
---@param os os_name | os_name[] the os(s) to check
---@return boolean true if the OS matches, false otherwise
function M.is_os(os)
  if type(os) == 'string' then
    return os_map[os]() or false
  end

  return vim.iter(os):any(function(v)
    return os_map[v]()
  end)
end

-- Execute a function if the OS matches
---@param os os_name | os_name[] the os(s) to check
---@param f function the function to execute if the OS matches
function M.if_os(os, f)
  if M.is_os(os) then
    return f()
  end
end

-- Remove duplicates from a list
---@param list_table table<number, any>
---@return table<number, any>
function M.unique(list_table)
  local seen = {}
  local result = {}
  for _, value in ipairs(list_table) do
    if not seen[value] then
      seen[value] = true
      table.insert(result, value)
    end
  end
  return result
end

--- Check if a table is list, i.e. if the keys are numbers starting from 1
---@param tbl table The table to check
---@return boolean true if the table is like a list, false otherwise
function M.is_list(tbl)
  if tbl == nil or type(tbl) ~= 'table' or #tbl == 0 then
    return false
  end

  for i = 1, #tbl do
    if tbl[i] == nil then
      return false -- if any index is nil, it's not a list
    end
  end

  return true
end

---@param tbl table The table to check
---@return boolean true if the table is like a dictionary, false otherwise
function M.dict_like(tbl)
  if tbl == nil or type(tbl) ~= 'table' or #tbl == 0 then
    return false
  end

  for k, _ in pairs(tbl) do
    if type(k) ~= 'number' then
      return true -- if any key is not a number, it's dictionary-like
    end
  end

  return false
end

---Extract key-value pairs from a table based on a list of keys or a comparison function
---@param tbl table The table to extract from
---@param cmp table | function The list of keys to extract or function that returns boolean given a key and value
---@return table, table field extracted key-value pairs and the remaining key-value pairs
function M.tbl_extract(tbl, cmp)
  local extracted = {}
  local remains = {}
  local cmp_fn = type(cmp) == 'function' and cmp
    or function(key, _)
      local keys = cmp --[[@as table]]
      return vim.tbl_contains(keys, key)
    end

  for key, v in pairs(tbl) do
    if cmp_fn(key, v) then
      extracted[key] = v
    else
      remains[key] = v
    end
  end
  return extracted, remains
end

-- Normalize a file path
local function localize_path(path)
  if M.DIR_SEP == '\\' then
    path = path:gsub('/', '\\')
  end
  return path
end

-- read contents of a file
M.read_file = function(path)
  local localized_path = vim.fn.expand(localize_path(path))
  local file = io.open(localized_path, 'r')
  if not file then
    return nil
  end

  local content = file:read '*a'
  file:close()
  return content
end

--- get a hl color
--- SRC: https://github.com/folke/snacks.nvim/blob/main/lua/snacks/util/init.lua)
--- @param group string|string[] hl group to get color from
--- @param prop? string property to get. Defaults to "fg"
function M.color(group, prop)
  prop = prop or 'fg'
  group = type(group) == 'table' and group or { group }
  ---@cast group string[]
  for _, g in ipairs(group) do
    local hl = vim.api.nvim_get_hl(0, { name = g, link = false })
    if hl[prop] then
      return string.format('#%06x', hl[prop])
    end
  end
end

--- Find the first truthy value in a table
--- @param tbl table The table to search
function M.first_truthy(tbl)
  vim.iter(tbl):find(function(v)
    return v and v ~= '' and v ~= 0
  end)
end

--- Format all strings in a table
--- @param fmt string format to apply to all strings
--- @param tbl table of strings to format
--- @return table table of formatted strings
function M.format_all(fmt, tbl)
  return vim
    .iter(tbl)
    :map(function(v, k)
      return string.format(fmt, v)
    end)
    :totable()
end

--- Get the selected text in visual mode
---@return string
function M.get_selected_text()
  local mode = vim.api.nvim_get_mode().mode
  local opts = {}
  -- \22 is an escaped version of <c-v>
  if mode == 'v' or mode == 'V' or mode == '\22' then
    opts.type = mode
  end
  local lines = vim.fn.getregion(vim.fn.getpos 'v', vim.fn.getpos '.', opts)
  return vim.concat(lines, '\n')
end

--- Replace the selected text in visual mode with the given text
function M.replace_selection(text)
  -- Use unpack to give tuple values a name otherwise you can only use indexing.
  -- We are getting line, column, buffer nr etc based on the visual markers here.
  local s_buf, s_row, s_col, _ = unpack(vim.fn.getpos "'<")
  local _, e_row, e_col, _ = unpack(vim.fn.getpos "'>")
  -- Indexing into buffer row needs - 1 because lua indexing starts from 1.
  -- Column subtracts are just to account for start and end scenarios.
  -- We use the positions to fully clear all selected text of a v-block.
  vim.api.nvim_buf_set_text(s_buf, e_row - 1, s_col - 1, e_row - 1, e_col, {})
  -- Place text.
  vim.api.nvim_buf_set_text(s_buf, s_row - 1, s_col, s_row - 1, s_col, { text })
  -- Exit visual mode
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<esc>', true, false, true), 'x', false)
end

--- Run a shell command and return it's output
function M.shell_cmd(cmd, opt)
  local cwd = opt.cwd or vim.fn.getcwd()
  local shell = opt.shell or 'bash'
  local result = vim.system({ shell, '-c', cmd }, { text = true, cwd = cwd }):wait()
  if result.code ~= 0 then
    vim.notify(
      'Error running command: ' .. result.stdout .. '. Error: ' .. result.stderr,
      vim.log.levels.ERROR
    )
    return nil
  end
  return result.stdout
end

return M
