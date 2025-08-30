-- Illuminate
-- NOTE: highlights other uses of the word under the cursor
return {
  'RRethy/vim-illuminate',
  lazy = true,
  event = 'BufReadPost',
  config = function()
    require('illuminate').configure {
      delay = 100,
      filetypes_denylist = {
        'dirbuf',
        'dirvish',
        'fugitive',
        'Outline',
        'Oil',
        'neo-tree',
        'snacks_dashboard',
      },
    }
  end,
}
