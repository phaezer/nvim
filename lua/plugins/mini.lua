-- mini - Collection of various small independent plugins/modules
-- see: https://github.com/echasnovski/mini.nvim
local M = {
  'echasnovski/mini.nvim',
  lazy = false,
  version = '*',
}

function M.config()
  -- mini.ai
  -- docs: https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-ai.md
  require('mini.ai').setup {
    mappings = {
      -- Main textobject prefixes
      around = 'a',
      inside = 'i',

      -- Next/last variants
      around_next = 'an',
      inside_next = 'in',
      around_last = 'al',
      inside_last = 'il',

      -- Move cursor to corresponding edge of `a` textobject
      goto_left = 'g[',
      goto_right = 'g]',
    },
    n_lines = 500,
  }

  -- mini.comment
  require('mini.comment').setup({
    mappings = {
      -- Toggle comment (like `gcip` - comment inner paragraph) for both
      -- Normal and Visual modes
      comment = 'gc',
      -- Toggle comment on current line
      comment_line = 'gC',
      -- Toggle comment on visual selection
      comment_visual = 'gc',
      -- Define 'comment' textobject (like `dgc` - delete whole comment block)
      -- Works also in Visual mode if mapping differs from `comment_visual`
      textobject = 'g|',
    },
  })

  -- mini.move
  -- docs: https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-move.md
  require('mini.move').setup({
    -- Module mappings. Use `''` (empty string) to disable one.
    mappings = {
      -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
      left = '<M-h>',
      right = '<M-l>',
      down = '<M-j>',
      up = '<M-k>',

      -- Move current line in Normal mode
      line_left = '<M-h>',
      line_right = '<M-l>',
      line_down = '<M-j>',
      line_up = '<M-k>',
    },

    -- Options which control moving behavior
    options = {
      -- Automatically reindent selection during linewise vertical move
      reindent_linewise = true,
    },
  })
end

return M
