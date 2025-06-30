-- yanky - Yank history
-- https://github.com/gbprod/yanky.nvim
return {
  "gbprod/yanky.nvim",
  dependencies = { "folke/snacks.nvim" },
  opts = {
    ring = {
      history_length = 100,
      storage = "shada",
      storage_path = vim.fn.stdpath("data") .. "/databases/yanky.db", -- Only for sqlite storage
      sync_with_numbered_registers = true,
      cancel_event = "update",
      ignore_registers = { "_" },
      update_register_on_cycle = false,
      permanent_wrapper = nil,
    },
    picker = {
      select = {
        action = nil, -- nil to use default put action
      },
      telescope = {
        use_default_mappings = true, -- if default mappings should be used
        mappings = nil,              -- nil to use default mappings or no mappings (see `use_default_mappings`)
      },
    },
    system_clipboard = {
      sync_with_ring = true,
      clipboard_register = nil,
    },
    highlight = {
      on_put = true,
      on_yank = true,
      timer = 500,
    },
    preserve_cursor_position = {
      enabled = true,
    },
    textobj = {
      enabled = false,
    },
  },
  keys = {
    {
      "<leader>p",
      function()
        Snacks.picker.yanky()
      end,
      mode = { "n", "x" },
      desc = "Open Yank History",
    },
    { "y",     "<Plug>(YankyYank)",                    desc = "Yank (copy)",                           mode = { "n", "x" } },
    { "p",     "<Plug>(YankyPutAfter)",                desc = "Paste after",                           mode = { "n", "x" } },
    { "P",     "<Plug>(YankyPutBefore)",               desc = "Paste before",                          mode = { "n", "x" } },
    { "gp",    "<Plug>(YankyGPutAfter)",               desc = "Paste after and keep cursor position",  mode = { "n", "x" } },
    { "gP",    "<Plug>(YankyGPutBefore)",              desc = "Paste before and keep cursor position", mode = { "n", "x" } },
    { "<c-p>", "<Plug>(YankyPreviousEntry)",           desc = "Yank" },
    { "<c-n>", "<Plug>(YankyNextEntry)",               desc = "Delete" },
    { "]p",    "<Plug>(YankyPutIndentAfterLinewise)",  desc = "Change" },
    { "[p",    "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Paste before indent linewise" },
    { "]P",    "<Plug>(YankyPutIndentAfterLinewise)",  desc = "Paste after indent linewise" },
    { "[P",    "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Paste before indent linewise" },
    {
      "iy",
      function()
        require("yanky.textobj").last_put()
      end,
      desc = "Paste last yanked text object",
      mode = { "o", "x" },
    }
  },

}
