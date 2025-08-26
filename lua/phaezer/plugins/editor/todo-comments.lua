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
    signs = false,
    keywords = {
      FIX = {
        icon = ' ', -- icon used for the sign, and in search results
        color = 'error', -- can be a hex color, or a named color (see below)
        alt = { 'FIXME', 'BUG', 'FIXIT', 'ISSUE' }, -- a set of other keywords that all map to this FIX keywords
      },
      TODO = { icon = ' ', color = 'info' },
      HACK = { icon = ' ', color = 'warning' },
      WARN = { icon = ' ', color = 'warning', alt = { 'WARNING', 'XXX' } },
      PERF = { icon = ' ', alt = { 'OPTIM', 'PERFORMANCE', 'OPTIMIZE' } },
      NOTE = { icon = ' ', color = 'hint', alt = { 'INFO' } },
      TEST = { icon = '󰙨 ', color = 'test', alt = { 'TESTING', 'PASSED', 'FAILED' } },
      DOC = {
        icon = ' ',
        color = 'hint',
        alt = { 'SRC', 'SEE', 'DOCUMENTATION', 'DOCS', 'README', 'RTFM' },
      },
    },
  },
}
