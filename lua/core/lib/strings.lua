local function is_space(str)
  return str == nil or str == '' or str == ' '
end

-- trim the left side of a string
---@param str string?
---@return string
function string:ltrim(str)
  if is_space(str) then
    str = '%s'
  end

  return self:gsub('^' .. str .. '+', '')
end

-- trim the right side of a string
---@param str string?
---@return string
function string:rtrim(str)
  if is_space(str) then
    str = '%s'
  end

  return self:gsub('%s+$' .. str .. '+', '')
end

-- trim a string
---@param str string?
---@return string
function string:trim(str)
  return self:ltrim(str):rtrim(str)
end

-- split a string into a table of strings
---@param delimiter string? delimiter to split on, defaults to '%s'
---@param cb function? callback to modify the match
---@return table<number, string> list of strings
function string:split(delimiter, cb)
  if self == nil or self:len() == 0 then
    return {}
  end

  if is_space(delimiter) then
    delimiter = '%s'
  end

  local result = {}
  for match in self:gmatch('[^' .. delimiter .. ']+') do
    if cb then
      assert(type(cb) == 'function', 'callback must be a function')
      match = cb(match)
    end
    table.insert(result, match)
  end
  return result
end
