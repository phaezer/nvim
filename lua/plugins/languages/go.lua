return {
  {
    'leoluz/nvim-dap-go',
    dependencies = {
      'mfussenegger/nvim-dap',
    },
    ft = { 'go' },
    config = function()
      local dapgo = require('dap-go')
      dapgo.setup {
        dap_configurations = {
          {
            -- Must be "go" or it will be ignored by the plugin
            type = "go",
            name = "Attach remote",
            mode = "remote",
            request = "attach",
          },
          {
            type = "go",
            name = "Debug (Build Flags)",
            request = "launch",
            program = "${file}",
            buildFlags = dapgo.get_build_flags,
          },
          {
            type = "go",
            name = "Debug (Build Flags & Arguments)",
            request = "launch",
            program = "${file}",
            args = dapgo.get_arguments,
            buildFlags = dapgo.get_build_flags,
          },
        },
        -- delve configurations
        delve = {
          -- the path to the executable dlv which will be used for debugging.
          -- by default, this is the "dlv" executable on your PATH.
          path = vim.b.go_dlv_path
              or vim.g.go_dlv_path
              or os.getenv("GO_DELVE_PATH")
              or "dlv",
          -- time to wait for delve to initialize the debug session.
          -- default to 20 seconds
          initialize_timeout_sec = 20,
          -- a string that defines the port to start delve debugger.
          -- default to string "${port}" which instructs nvim-dap
          -- to start the process in a random available port.
          -- if you set a port in your debug configuration, its value will be
          -- assigned dynamically.
          port = vim.b.go_dlv_port
              or vim.g.go_dlv_port
              or os.getenv("GO_DELVE_PORT")
              or "${port}",
          -- additional args to pass to dlv
          args = vim.b.go_dlv_args
              or vim.g.go_dlv_args
              or (os.getenv("GO_DELVE_ARGS") or ''):split()
              or {},
          -- the build flags that are passed to delve.
          -- defaults to empty string, but can be used to provide flags
          -- such as "-tags=unit" to make sure the test suite is
          -- compiled during debugging, for example.
          -- passing build flags using args is ineffective, as those are
          -- ignored by delve in dap mode.
          -- avaliable ui interactive function to prompt for arguments get_arguments
          build_flags = vim.b.go_build_flags
              or vim.g.go_build_flags
              or (os.getenv("GO_BUILD_FLAGS") or ''):split()
              or {},
          -- whether the dlv process to be created detached or not. there is
          -- an issue on delve versions < 1.24.0 for Windows where this needs to be
          -- set to false, otherwise the dlv server creation will fail.
          -- avaliable ui interactive function to prompt for build flags: get_build_flags
          detached = vim.fn.has("win32") == 0,
          -- the current working directory to run dlv from, if other than
          -- the current working directory.
          cwd = vim.b.go_dlv_args
              or vim.g.go_dlv_args
              or os.getenv("GO_DELVE_CWD")
              or nil,
        },
        -- options related to running closest test
        tests = {
          -- enables verbosity when running the test.
          verbose = false,
        }
      }
    end
  },
}
