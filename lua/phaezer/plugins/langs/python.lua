return {
  -- NOTE: python dap integration
  {

    'mfussenegger/nvim-dap-python',
    dependencies = {
      'mfussenegger/nvim-dap',
    },
    ft = { 'python' },
    config = function()
      local python = require 'phaezer.config.langs.python'
      require('dap-python').setup(python.bin_path() or 'uv')
    end,
  }, -- / dap-python
}
