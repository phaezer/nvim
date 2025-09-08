return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    'nvim-neotest/neotest-plenary',
    'nvim-neotest/neotest-go',
    'nvim-neotest/neotest-python',
    'stevearc/overseer.nvim',
  },
  config = function()
    local go_env = require('config.lang.go').env
    local python_env = require('config.lang.python').env
    require('neotest').setup {
      consumers = {
        overseer = require 'neotest.consumers.overseer',
      },
      overseer = {
        enabled = true,
        -- When this is true (the default), it will replace all neotest.run.* commands
        force_default = false,
      },
      strategies = {
        overseer = {
          components = function(run_spec)
            return {
              {
                'dependencies',
                task_names = {
                  { 'shell', cmd = 'sleep 4' },
                },
              },
              'default_neotest',
            }
          end,
        },
      },
      adapters = {
        require 'neotest-plenary',
        -- go
        require 'neotest-go' {
          experimental = {
            test_table = true,
          },
          args = go_env.test_args() or { '-count=1', '-timeout=60s' },
        },
        -- python
        require 'neotest-python' {
          -- Extra arguments for nvim-dap configuration
          -- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
          dap = { justMyCode = false },
          -- Command line arguments for runner
          -- Can also be a function to return dynamic values
          args = { '--log-level', 'DEBUG' },
          -- Runner to use. Will use pytest if available by default.
          -- Can be a function to return dynamic value.
          runner = python_env.test_runner() or 'pytest',
          -- Custom python path for the runner.
          -- Can be a string or a list of strings.
          -- Can also be a function to return dynamic value.
          -- If not provided, the path will be inferred by checking for
          -- virtual envs in the local directory and for Pipenev/Poetry configs
          python = python_env.bin_path(),
          -- Returns if a given file path is a test file.
          -- NB: This function is called a lot so don't perform any heavy tasks within it.
          is_test_file = python_env.test_file_pattern() or 'test_.*%.py$',
          -- !!EXPERIMENTAL!! Enable shelling out to `pytest` to discover test
          -- instances for files containing a parametrize mark (default: false)
          pytest_discover_instances = true,
        },
        -- rust
        require 'rustaceanvim.neotest',
      },
    }

    -- get neotest namespace (api call creates or returns namespace)
    local neotest_ns = vim.api.nvim_create_namespace 'neotest'
    vim.diagnostic.config({
      virtual_text = {
        format = function(diagnostic)
          local message =
            diagnostic.message:gsub('\n', ' '):gsub('\t', ' '):gsub('%s+', ' '):gsub('^%s+', '')
          return message
        end,
      },
    }, neotest_ns)
  end,
  keys = {
    { '<leader>lt', function() require('neotest').run.run() end, desc = 'run test  neotest' },
  },
}
