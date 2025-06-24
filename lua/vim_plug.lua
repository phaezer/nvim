local vim_plug_path = vim.fn.expand('~/.vim/autoload/plug.vim')

-- check if the script exists
if vim.fn.filereadable(vim_plug_path) == 0 then
  local Plug = vim.fn['plug#']
  vim.call('plug#begin')
  -- plugins
  -- ansible highlighting for vim https://github.com/pearofducks/ansible-vim
  Plug('pearofducks/ansible-vim')
end
