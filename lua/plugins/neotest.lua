return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-neotest/neotest-plenary",
    "nvim-neotest/neotest-go",
    "nvim-neotest/neotest-python",
  },
  config = function()
    require("neotest").setup {
      adapters = {
        require("neotest-plenary"),
        -- python
        require("neotest-python")({
          -- Extra arguments for nvim-dap configuration
          -- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
          dap = { justMyCode = false },
          -- Command line arguments for runner
          -- Can also be a function to return dynamic values
          args = { "--log-level", "DEBUG" },
          -- Runner to use. Will use pytest if available by default.
          -- Can be a function to return dynamic value.
          runner = vim.b.python_test_runner
              or vim.g.python_test_runner
              or os.getenv("PYTHON_TEST_RUNNER")
              or "pytest",
          -- Custom python path for the runner.
          -- Can be a string or a list of strings.
          -- Can also be a function to return dynamic value.
          -- If not provided, the path will be inferred by checking for
          -- virtual envs in the local directory and for Pipenev/Poetry configs
          python = vim.b.python_path
              or vim.g.python_path
              or os.getenv("PYTHON_PATH"),
          -- Returns if a given file path is a test file.
          -- NB: This function is called a lot so don't perform any heavy tasks within it.
          is_test_file = function(file_path)
            return file_path:match(vim.b.python_test_file_pattern
              or vim.g.python_test_file_pattern
              or os.getenv("PYTHON_TEST_FILE_PATTERN")
              or "test_.*%.py$")
          end,
          -- !!EXPERIMENTAL!! Enable shelling out to `pytest` to discover test
          -- instances for files containing a parametrize mark (default: false)
          pytest_discover_instances = true,
        }),
        -- go
        require("neotest-go")({
          experimental = {
            test_table = true,
          },
          args = vim.b.go_test_args
              or vim.g.go_test_args
              or ((os.getenv("GO_TEST_ARGS") or '-count=1 -timeout=60s'):split())
        })
      }
    }

    -- get neotest namespace (api call creates or returns namespace)
    local neotest_ns = vim.api.nvim_create_namespace("neotest")
    vim.diagnostic.config({
      virtual_text = {
        format = function(diagnostic)
          local message =
              diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
          return message
        end,
      },
    }, neotest_ns)
  end,
  keys = {
    { "<leader>tt", function() require("neotest").run.run() end, desc = "Run Test" },
  }
}
