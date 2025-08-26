-- Tiny Inline Diagnostic
-- NOTE: A Neovim plugin that display prettier diagnostic messages.
--  Display one line diagnostic messages where the cursor is, with icons and colors.
return {
  'rachartier/tiny-inline-diagnostic.nvim',
  lazy = true,
  event = 'VeryLazy', -- Or `LspAttach`
  priority = 1000, -- needs to be loaded in first
  config = function()
    require('tiny-inline-diagnostic').setup {
      signs = {
        left = '', -- Left border character
        right = '', -- Right border character
        diag = '', -- Diagnostic indicator character
        arrow = '  ', -- Arrow pointing to diagnostic
        up_arrow = '  ', -- Upward arrow for multiline
        vertical = ' │', -- Vertical line for multiline
        vertical_end = ' └', -- End of vertical line for multiline
      },
      blend = {
        factor = 0.2, -- Transparency factor (0.0 = transparent, 1.0 = opaque)
      },
      options = {
        use_icons_from_diagnostic = true,
        set_arrow_to_diag_color = false,
        multilines = {
          enabled = true,
          always_show = false,
          trim_whitespaces = false,
          tabstop = 4,
        },
      },
    }
    vim.diagnostic.config { virtual_text = false } -- Only if needed in your configuration, if you already have native LSP diagnostics
  end,
}
