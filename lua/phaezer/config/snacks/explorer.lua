local keymap = require 'lua.phaezer.keymap'

-- SRC: https://github.com/folke/snacks.nvim/blob/bc0630e43be5699bb94dadc302c0d21615421d93/lua/snacks/picker/config/sources.lua#L39
local opts = {
  formatters = {
    file = { filename_only = true },
    severity = { pos = "right" },
  },
  jump = { close = false },
  layout = {
    hidden = { 'input' },
  },
  matcher = { sort_empty = false, fuzzy = false },
  icons = {
    diagnostics = {
      Error = ' ',
      Warn = ' ',
      Hint = ' ',
      Info = ' ',
    },
    git = {
      commit = '󰜘',
      conflict = '',
      staged = '',
      added = '',
      deleted = '',
      modified = '',
      ignored = '',
      unstaged = '',
      renamed = '',
      untracked = '',
    },
  },
  win = {
    list = {
      keys = {
        ["T"] = "tab",
        ["<BS>"] = "explorer_up",
        ["l"] = "confirm",
        ["h"] = "explorer_close", -- close directory
        ["a"] = "explorer_add",
        ["d"] = "explorer_del",
        ["r"] = "explorer_rename",
        ["c"] = "explorer_copy",
        ["m"] = "explorer_move",
        ["o"] = "explorer_open", -- open with system application
        ["P"] = "toggle_preview",
        ["y"] = { "explorer_yank", mode = { "n", "x" } },
        ["p"] = "explorer_paste",
        ["u"] = "explorer_update",
        ["<c-c>"] = "tcd",
        ["<leader>/"] = "picker_grep",
        ["<c-t>"] = "terminal",
        ["."] = "explorer_focus",
        ["I"] = "toggle_ignored",
        ["H"] = "toggle_hidden",
        ["Q"] = "explorer_close_all",
        ["]g"] = "explorer_git_next",
        ["[g"] = "explorer_git_prev",
        ["]d"] = "explorer_diagnostic_next",
        ["[d"] = "explorer_diagnostic_prev",
        ["]w"] = "explorer_warn_next",
        ["[w"] = "explorer_warn_prev",
        ["]e"] = "explorer_error_next",
        ["[e"] = "explorer_error_prev",
      },
    },
  },
}

keymap.set { '<leader>e', function() Snacks.explorer(opts) end, desc = 'File Explorer' }
