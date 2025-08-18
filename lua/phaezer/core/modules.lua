local M = {
  lua_dir = vim.fn.stdpath 'config' .. '/lua/',
}

-- require all Lua files in a directory
---@param dir string Directory path relative to the Neovim config directory
---@return nil
---@throws if the directory does not exist
function M.require_all_in_dir(dir)
  -- split dir by path separator

  local output = {}
  local base_dir = M.lua_dir .. dir
  local fd = vim.loop.fs_scandir(base_dir)

  for file_name in function() return vim.loop.fs_scandir_next(fd) end do
    local path = base_dir .. '/' .. file_name
    if file_name:sub(-4) == '.lua' then
      local path_no_ext = path:sub(#M.lua_dir + 1):sub(0, -5) -- remove the .lua extension
      local dir_parts = {}
      for part in string.gmatch(path_no_ext, '[^/]+') do
        table.insert(dir_parts, part)
      end

      local out = require(table.concat(dir_parts, '.'))
      if out then table.insert(output, out) end
    end
  end

  return output
end

-- require multiple modules
---@param mods string[] The modules to require
function M.require_all(mods)
  local out = {}
  for _, m in ipairs(mods) do
    out[m] = require(m)
  end
  return out
end

-- if a package is loaded, execute a function
---@param pkg string The package name to check
---@param f function The function to execute if the package is loaded
function M.if_pkg(pkg, f)
  if package.loaded[pkg] then return f() end
end

-- execute a function and catch any errors
---@param f function The function to execute
---@param catch function|nil The function to call if an error occurs
function M.try(f, catch)
  local ok, result = pcall(f)
  if not ok then
    if catch then
      return catch(result)
    else
      error(result)
    end
  end
  return result
end

return M
