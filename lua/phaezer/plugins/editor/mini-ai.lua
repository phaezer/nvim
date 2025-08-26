-- NOTE: Extend and create a/i textobjects
-- DOCS: https://github.com/echasnovski/mini.ai
return {
  'echasnovski/mini.ai',
  version = '*',
  opts = {
    mappings = {
      -- Main textobject prefixes
      around = 'a',
      inside = 'i',

      -- Next/last variants
      around_next = 'an',
      inside_next = 'in',
      around_last = 'al',
      inside_last = 'il',

      -- Move cursor to corresponding edge of `a` textobject
      goto_left = 'g[',
      goto_right = 'g]',
    },
    n_lines = 500,
  },
}
