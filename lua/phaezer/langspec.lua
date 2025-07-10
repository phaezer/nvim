---@class LangSpec
local LangSpec = {}

local function new(filetype, spec)
  local lang_spec = {
    filetype = spec.filetype or filetype,
    patterns = spec.patterns or { '*.' .. filetype },
    parsers = spec.parsers or { filetype },
    cmp = spec.cmp or {},
    lsp = spec.lsp or {},
    lint = spec.lint or {},
    fmt = spec.fmt or {},
    env = spec.env or {},
  }

  return setmetatable(lang_spec, {
    __index = LangSpec,
    __tostring = function(self)
      return string.format("LangSpec: %s (%s)", self.name, self.filetype)
    end,
  })
end

---@param parsers string[]
function LangSpec:add_parsers(parsers)
  vim.list_extend(self.parsers, parsers)
end
