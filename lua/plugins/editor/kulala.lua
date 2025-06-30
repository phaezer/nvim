-- kulala.nvim - A plugin for sending HTTP requests
-- src: https://github.com/mistweaverco/kulala.nvim
-- docs: https://neovim.getkulala.net/
local icons = Config.icon

return {
  "mistweaverco/kulala.nvim",
  keys = {
    { "<leader>Rs", desc = "Send request" },
    { "<leader>Ra", desc = "Send all requests" },
    { "<leader>Rb", desc = "Open scratchpad" },
  },
  ft = { "http", "rest" },
  opts = {
    global_keymaps = false,
    global_keymaps_prefix = "<leader>R",
    kulala_keymaps_prefix = "",
    ui = {
      disable_news_popup = true,
      -- display mode: possible values: "split", "float"
      display_mode = "split",
      -- split direction: possible values: "vertical", "horizontal"
      split_direction = "vertical",
      -- window options to override defaults: width/height/split/vertical
      win_opts = {},
      -- default view: "body" or "headers" or "headers_body" or "verbose" or fun(response: Response)
      default_view = "body",
      -- enable winbar
      winbar = true,
      -- Specify the panes to be displayed by default
      -- Current available pane contains { "body", "headers", "headers_body", "script_output", "stats", "verbose", "report", "help" },
      default_winbar_panes = { "body", "headers", "headers_body", "verbose", "script_output", "report", "help" },
      -- enable/disable variable info text
      -- this will show the variable name and value as float
      -- possible values: false, "float"
      show_variable_info_text = false,
      -- icons position: "signcolumn"|"on_request"|"above_request"|"below_request" or nil to disable
      show_icons = "on_request",
      -- default icons
      icons = {
        inlay = {
          loading = icons.ui.Loading,
          done = icons.ui.Done,
          error = icons.ui.Error,
        },
        lualine = icons.ui.Web,
        textHighlight = "WarningMsg", -- highlight group for request elapsed time
      },
    }
  },
}
