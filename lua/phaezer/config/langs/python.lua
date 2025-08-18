local ENV = {}

function ENV.bin_path()
  return vim
    .iter({
      vim.b.python_path, -- local python path
      os.getenv 'VIRTUAL_ENV' and os.getenv 'VIRTUAL_ENV' .. '/bin/python',
      os.getenv 'CONDA_DEFAULT_ENV' and os.getenv 'CONDA_DEFAULT_ENV' .. '/bin/python',
      os.getenv 'PYENV_ROOT' and os.getenv 'PYENV_ROOT' .. '/shims/python',
      os.getenv 'PYTHON_PATH',
      vim.g.python_path, -- global python path
    })
    :find(function(v)
      return v and v ~= ''
    end)
end

function ENV.test_runner()
  return vim
    .iter({
      vim.b.python_test_runner, -- local python path
      os.getenv 'PYTHON_TEST_RUNNER',
      vim.g.python_test_runner, -- global python path
    })
    :find(function(v)
      return v and v ~= ''
    end)
end

function ENV.test_file_pattern()
  return vim
    .iter({
      vim.b.python_test_file_pattern, -- local python path
      os.getenv 'PYTHON_TEST_FILE_PATTERN',
      vim.g.python_test_file_pattern, -- global python path
    })
    :find(function(v)
      return v and v ~= ''
    end)
end

return ENV
