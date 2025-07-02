-- illuminate - A plugin for highlighting other uses of the word under the cursor
-- src: https://github.com/RRethy/vim-illuminate

return {
  'RRethy/vim-illuminate',
  event = 'BufReadPost',
  config = function()
    require('illuminate').configure {
      delay = 100,
      filetypes_denylist = {
        'dirbuf',
        'dirvish',
        'fugitive',
        'Outline',
      },
    }
  end,
}
