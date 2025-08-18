return {
  name = 'denols',
  cmd = { 'deno', 'lsp' },
  filetypes = {
    'typescript',
    'typescriptreact',
    'typescript.tsx',
    'javascript',
    'javascriptreact',
    'javascript.jsx',
  },
  root_markers = { 'deno.json', 'deno.jsonc' },
  settings = {},
}
