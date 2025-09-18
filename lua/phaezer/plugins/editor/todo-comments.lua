-- TODO Comments
-- NOTE: Highlights todo, notes, etc in comments
return {
  'folke/todo-comments.nvim',
  event = 'VimEnter',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'folke/snacks.nvim', -- snacks provides the todo picker
  },
  keys = {
    {
      '<leader>st',
      function() Snacks.picker.todo_comments { keywords = { 'TODO', 'FIX', 'FIXME' } } end,
      desc = 'Todos',
    },
    { '<leader>sT', function() Snacks.picker.todo_comments {} end, desc = 'All Todo Flags' },
  },
  opts = {
    signs = true,
    keywords = {
      FIX = {
        icon = '󰨰',
        color = 'error',
        alt = { 'FIXME', 'BUG', 'FIXIT', 'ISSUE' },
      },
      TODO = { icon = '', color = 'info' },
      HACK = { icon = '', color = 'warning' },
      WARN = { icon = '', color = 'warning', alt = { 'WARNING', 'XXX' } },
      PERF = { icon = '󱐌', alt = { 'OPTIM', 'PERFORMANCE', 'OPTIMIZE' } },
      NOTE = { icon = '󰙎', color = 'hint', alt = { 'INFO' } },
      TEST = { icon = '󰂓', color = 'test', alt = { 'TESTING', 'PASSED', 'FAILED' } },
      DOC = {
        icon = '',
        color = 'hint',
        alt = { 'SRC', 'SEE', 'DOCUMENTATION', 'DOCS', 'README', 'RTFM' },
      },
    },
    highlight = {
      multiline = true, -- enable multiline todo comments
      multiline_pattern = '^\\s+.', -- lua pattern to match the next multiline from the start of the matched keyword
      multiline_context = 10, --alt extra lines that will be re-evaluated when changing a line
      before = 'fg', -- "fg" or "bg" or empty
      keyword = 'wide', -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
      after = nil, -- "fg" or "bg" or empty
      comments_only = true, -- uses treesitter to match keywords in comments only
      max_line_len = 400, -- ignore lines longer than this
      exclude = {}, -- list of file types to exclude highlighting
    },
  },
}
