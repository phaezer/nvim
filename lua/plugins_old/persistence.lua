return {
  -- persistence.nvim is a plugin that saves and restores the state of the editor.
  -- SRC: https://github.com/folke/persistence.nvim
  "folke/persistence.nvim",
  event = "BufReadPre", -- this will only start session saving when an actual file was opened
  opts = {
    need = 1,
    branch = true, -- use git branch to save session
  },
  keys = {
    { "<leader>qs", "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
    { "<leader>ql", "<leader>ql", function() require("persistence").load() end, desc = "Restore Last Session" },
    { "<leader>qd", "<leader>qd", function() require("persistence").stop() end, desc = "Delete Session" },
  }
}
