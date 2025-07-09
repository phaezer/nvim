local env = require 'config.lang.python.env'

return {
  {
    -- dap-python
    -- src: https://github.com/mfussenegger/nvim-dap-python
    'mfussenegger/nvim-dap-python',
    dependencies = {
      'mfussenegger/nvim-dap',
    },
    ft = { 'python' },
    config = function()
      require('dap-python').setup(env.python_path() or 'uv')
    end,
  },
}
