-- Colorful Menu
-- NOTE: A Neovim plugin that provides a colorful menu for LSP completion and other text
return {
  'xzbdmw/colorful-menu.nvim',
  lazy = true,
  event = 'LspAttach',
  opts = {
    ls = {
      gopls = {
        -- When true, label for field and variable will format like "foo: Foo"
        -- instead of go's original syntax "foo Foo". If align_type_to_right is
        -- true, this option has no effect.
        add_colon_before_type = false,
        -- See https://github.com/xzbdmw/colorful-menu.nvim/pull/36
        preserve_type_when_truncate = true,
      },
      -- for lsp_config or typescript-tools
      ts_ls = {
        extra_info_hl = '@comment',
      },
      ['rust-analyzer'] = {
        extra_info_hl = '@comment',
        -- See https://github.com/xzbdmw/colorful-menu.nvim/pull/36
        preserve_type_when_truncate = true,
      },
      clangd = {
        extra_info_hl = '@comment',
        import_dot_hl = '@comment',
        preserve_type_when_truncate = true,
      },
      -- The same applies to pyright/pylance
      basedpyright = {
        extra_info_hl = '@comment',
      },
      pylsp = {
        extra_info_hl = '@comment',
      },
      fallback = true,
      fallback_extra_info_hl = '@comment',
    },
    -- If the built-in logic fails to find a suitable highlight group for a label,
    -- this highlight is applied to the label.
    fallback_highlight = '@variable',
    max_width = 80,
  },
}
