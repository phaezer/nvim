local lua_dir = vim.fn.stdpath('config') .. '/lua/'

---@module 'core.util'
local M = {}

-- Check if the OS is Windows
---@return boolean true if the OS is Windows
function M.is_win()
  return vim.uv.os_uname().sysname:find("Windows") ~= nil
end

-- Check if the OS is Mac
---@return boolean true if the OS is Mac
function M.is_mac()
  return vim.uv.os_uname().sysname:find("Darwin") ~= nil
end

function M.is_vs_code()
  return vim.g.vscode ~= nil
end

-- require all Lua files in a directory
---@param dir string Directory path relative to the Neovim config directory
---@return nil
---@throws if the directory does not exist
function M.require_all(dir, recursive)
  -- split dir by path separator

  output = {}

  local base_dir = lua_dir .. dir
  local fd = vim.loop.fs_scandir(base_dir)

  for file_name in
  function() return vim.loop.fs_scandir_next(fd) end
  do
    local path = base_dir .. '/' .. file_name
    -- if dir, then recurse
    -- if recursive and vim.uv.fs_stat(path).type == 'directory' then
    --   vim.list_extend(output, M.require_all(dir .. '/' .. file_name, true))
    -- else
    -- remove the lua directory prefix and the .lua extension

    -- if file is not a lua file, skip it

    if file_name:sub(-4) == '.lua' then
      local path_no_ext = path:sub(#lua_dir + 1):sub(0, -5) -- remove the .lua extension
      local dir_parts = {}
      for part in string.gmatch(path_no_ext, "[^/]+") do
        table.insert(dir_parts, part)
      end

      table.insert(output, require(table.concat(dir_parts, '.')))
      -- end
    end
  end

  return output
end

return M
