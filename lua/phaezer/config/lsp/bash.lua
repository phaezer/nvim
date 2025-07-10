local function split_str(str)
  if not str or #str == 0 then
    return nil
  end

  return vim.split(str, '%s+', { trimempty = true })
end

---@type LangSpec
local M = {
  filetype = "bash",
  patterns = { "*.sh", "envrc" },
  parsers = {
    "bash",
  },
  lsp = {
    { bashls = {} }
  },
  env = {}
}

function M.env.go_dlv_port()
  return vim.iter({
    vim.b.go_dlv_port,
    os.getenv("GO_DELVE_PORT"),
    vim.g.go_dlv_port,
  }):find(function(v) return v and v ~= '' end)
end

function M.env.go_dlv_path()
  return vim.iter({
    vim.b.go_dlv_path,
    os.getenv("GO_DELVE_PATH"),
    vim.g.go_dlv_path,
  }):find(function(v) return v and v ~= '' end)
end

function M.env.go_dlv_arg()
  return vim.iter({
    split_str(vim.b.go_dlv_args),
    split_str(os.getenv("GO_DELVE_ARGS")),
    split_str(vim.g.go_dlv_args),
  }):find(function(v) return v and #v > 0 end)
end

function M.env.go_build_flags()
  return vim.iter({
    split_str(vim.b.go_build_flags),
    split_str(os.getenv("GO_BUILD_FLAGS")),
    split_str(vim.g.go_build_flags),
  }):find(function(v) return v and #v > 0 end)
end

function M.env.go_dlv_cwd()
  return vim.iter({
    vim.b.go_dlv_cwd,
    os.getenv("GO_DELVE_CWD"),
    vim.g.go_dlv_cwd,
  }):find(function(v) return v and v ~= '' end)
end

function M.env.go_test_args()
  return vim.iter({
    split_str(vim.b.go_test_args),
    split_str(os.getenv("GO_TEST_ARGS")),
    split_str(vim.g.go_test_args),
  }):find(function(v) return v and #v > 0 end)
end

return M
