-- src code folding
--- SRC: https://github.com/OXY2DEV/foldtext.nvim
return {
  "OXY2DEV/foldtext.nvim",
  lazy = false,
  opts = {
    -- Ignore buffers with these buftypes.
    ignore_buftypes = { "nofile" },
    -- Ignore buffers with these filetypes.
    ignore_filetypes = { "Outline" },
    -- Ignore buffers/windows if the result
    -- is false.
    condition = function()
      return true;
    end,

    styles = {
      default = {
        { kind = "bufline" }
      },

      ts_expr = {
        condition = function(_, window)
          return vim.wo[window].foldmethod == "expr" and vim.wo[window].foldexpr == "v:lua.vim.treesitter.foldexpr()";
        end,

        parts = {
          {
            kind = "bufline",
            delimiter = " ... ",
            hl = "@comment",
          },
          {
            kind = "fold_size",
            hl = "@comment",
            icon = "←→ ",
            icon_hl = nil,
            padding_left = " ",
            padding_left_hl = nil,
            padding_right = " ",
            padding_right_hl = nil,
          }
        },
      },

      -- Custom foldtext.
      custom_a = {
        -- Only on these filetypes.
        filetypes = {},
        -- Only on these buftypes.
        buftypes = {},

        -- Only if this condition is
        -- true.
        condition = function(win)
          return vim.wo[win].foldmethod == "manual";
        end,

        -- Parts to create the foldtext.
        parts = {
          { kind = "fold_size" }
        }
      }
    }
  }
}
