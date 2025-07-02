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
      require('dap-python').setup(vim.b.python_path
        or vim.g.python_path
        or (os.getenv("VIRTUAL_ENV") and os.getenv("VIRTUAL_ENV") .. "/bin/python")
        or (os.getenv("CONDA_DEFAULT_ENV") and os.getenv("CONDA_DEFAULT_ENV") .. "/bin/python")
        or (os.getenv("PYENV_ROOT") and os.getenv("PYENV_ROOT") .. "/shims/python")
        or os.getenv("PYTHON_PATH")
        or 'uv'
      )
    end,
  },
}
