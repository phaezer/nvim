return {
  -- ==============================================================================================
  -- dap-python
  -- SRC: https://github.com/mfussenegger/nvim-dap-python
  {

    'mfussenegger/nvim-dap-python',
    dependencies = {
      'mfussenegger/nvim-dap',
    },
    ft = { 'python' },
    config = function()
      local python = require 'config.langs.python'
      require('dap-python').setup(python.bin_path() or 'uv')
    end,
  }, -- / dap-python
  -- ----------------------------------------------------------------------------------------------
}
