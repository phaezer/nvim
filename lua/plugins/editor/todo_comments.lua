-- Highlight todo, notes, etc in comments
-- src: https://github.com/folke/todo-comments.nvim

local icons = Config.icon

return {
  'folke/todo-comments.nvim',
  event = 'VimEnter',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    signs = false,
    keywords = {
      FIX = {
        icon = " ", -- icon used for the sign, and in search results
        color = "error", -- can be a hex color, or a named color (see below)
        alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
        -- signs = false, -- configure signs for some keywords individually
      },
      TODO = { icon = icons.ui.Todo .. " ", color = "info" },
      HACK = { icon = icons.ui.Hack .. " ", color = "warning" },
      WARN = { icon = icons.ui.Warning .. " ", color = "warning", alt = { "WARNING", "XXX" } },
      PERF = { icon = icons.ui.Perf .. " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
      NOTE = { icon = icons.ui.Note .. " ", color = "hint", alt = { "INFO" } },
      TEST = { icon = icons.ui.Test .. " ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
      DOC = { icon = icons.ui.Doc .. " ", color = "hint", alt = { "SEE", "DOCUMENTATION", "DOCS", "README", "RTFM" } },
    },
  },
}
