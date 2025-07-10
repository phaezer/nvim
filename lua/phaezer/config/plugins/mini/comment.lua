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
