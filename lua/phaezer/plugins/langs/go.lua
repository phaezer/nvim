return {
  -- ==============================================================================================
  -- nvim DAP for Go
  -- Go debugging with nvim DAP
  {
    'leoluz/nvim-dap-go',
    enabled = false, -- testing ray-x/go.nvim, may remove if not needed.
    lazy = true,
    dependencies = {
      'mfussenegger/nvim-dap',
    },
    ft = { 'go' },
    config = function()
      local env = require('config.langs.go').env
      local dap_go = require 'dap-go'

      dap_go.setup {
        dap_configurations = {
          {
            -- Must be "go" or it will be ignored by the plugin
            type = 'go',
            name = 'Attach remote',
            mode = 'remote',
            request = 'attach',
          },
          {
            type = 'go',
            name = 'Debug (Build Flags)',
            request = 'launch',
            program = '${file}',
            buildFlags = dap_go.get_build_flags,
          },
          {
            type = 'go',
            name = 'Debug (Build Flags & Arguments)',
            request = 'launch',
            program = '${file}',
            args = dap_go.get_arguments,
            buildFlags = dap_go.get_build_flags,
          },
        },
        -- delve configurations
        delve = {
          -- the path to the executable dlv which will be used for debugging.
          -- by default, this is the "dlv" executable on your PATH.
          path = env.go_dlv_path() or 'dlv',
          -- time to wait for delve to initialize the debug session.
          -- default to 20 seconds
          initialize_timeout_sec = 20,
          -- a string that defines the port to start delve debugger.
          -- default to string "${port}" which instructs nvim-dap
          -- to start the process in a random available port.
          -- if you set a port in your debug configuration, its value will be
          -- assigned dynamically.
          port = env.go_dlv_port() or '${port}',
          -- additional args to pass to dlv
          args = env.go_dlv_args() or {},
          -- the build flags that are passed to delve.
          -- defaults to empty string, but can be used to provide flags
          -- such as "-tags=unit" to make sure the test suite is
          -- compiled during debugging, for example.
          -- passing build flags using args is ineffective, as those are
          -- ignored by delve in dap mode.
          -- avaliable ui interactive function to prompt for arguments get_arguments
          build_flags = env.go_build_flags() or {},
          -- whether the dlv process to be created detached or not. there is
          -- an issue on delve versions < 1.24.0 for Windows where this needs to be
          -- set to false, otherwise the dlv server creation will fail.
          -- avaliable ui interactive function to prompt for build flags: get_build_flags
          detached = vim.fn.has 'win32' == 0,
          -- the current working directory to run dlv from, if other than
          -- the current working directory.
          cwd = env.go_dlv_cwd(),
        },
        -- options related to running closest test
        tests = {
          -- enables verbosity when running the test.
          verbose = false,
        },
      }
    end,
  }, -- / nvim DAP for Go

  -- ==============================================================================================
  -- A modern go neovim plugin based on treesitter, nvim-lsp and dap debugger.
  {
    'ray-x/go.nvim',
    lazy = true,
    event = { 'CmdlineEnter' },
    ft = { 'go', 'gomod' },
    dependencies = { -- optional packages
      'ray-x/guihua.lua',
      'neovim/nvim-lspconfig',
      'nvim-treesitter/nvim-treesitter',
      'voldikss/vim-floaterm',
    },
    opts = {
      icons = { breakpoint = '', currentpos = '' },
      diagnostic = false,
      gocoverage_sign = '󰕊',
      run_in_floaterm = true,
      floaterm = { -- position
        posititon = 'auto', -- one of {`top`, `bottom`, `left`, `right`, `center`, `auto`}
        width = 0.45, -- width of float window if not auto
        height = 0.98, -- height of float window if not auto
        title_colors = 'tokyo', -- default to nord, one of {'nord', 'tokyo', 'dracula', 'rainbow', 'solarized ', 'monokai'}
      },
    },
    config = function(_, opts)
      require('go').setup(opts)
      local format_sync_grp = vim.api.nvim_create_augroup('GoFormat', {})
      vim.api.nvim_create_autocmd('BufWritePre', {
        pattern = '*.go',
        callback = function() require('go.format').goimports() end,
        group = format_sync_grp,
      })
    end,
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },
}
