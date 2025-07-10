return {
  filetype = "terraform",
  patterns = { "*.tf" },
  parsers  = { "terraform" },
  lsp      = {
    tofu_ls = {},
    -- tflint = {},
  },
  cmp      = {
    sources = { 'lsp', 'path', 'snippets', 'buffer', 'copilot' }
  },
  lint     = {

  },
  format = {

  }
}
