-- mini - Collection of various small independent plugins/modules
-- SRC: https://github.com/echasnovski/mini.nvim

return {
  'echasnovski/mini.nvim',
  lazy = false,
  priority = 200,
  config = function()
    require('mini.ai').setup {
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
    }

    require('mini.comment').setup {
      mappings = {
        -- Toggle comment (like `gcip` - comment inner paragraph) for both
        -- Normal and Visual modes
        comment = 'gc',
        -- Toggle comment on current line
        comment_line = 'gC',
        -- Toggle comment on visual selection
        comment_visual = 'gc',
        -- Define 'comment' textobject (like `dgc` - delete whole comment block)
        -- Works also in Visual mode if mapping differs from `comment_visual`
        textobject = 'g|',
      },
    }

    -- local indent_scope = require 'mini.indentscope'
    -- indent_scope.setup {
    --   symbol = '│',
    -- }

    require('mini.pairs').setup {
      {
        -- In which modes mappings from this `config` should be created
        modes = { insert = true, command = false, terminal = false },

        -- Global mappings. Each right hand side should be a pair information, a
        -- table with at least these fields (see more in |MiniPairs.map|):
        -- - <action> - one of 'open', 'close', 'closeopen'.
        -- - <pair> - two character string for pair to be used.
        -- By default pair is not inserted after `\`, quotes are not recognized by
        -- <CR>, `'` does not insert pair after a letter.
        -- Only parts of tables can be tweaked (others will use these defaults).
        mappings = {
          -- basic pairs
          ['('] = { action = 'open', pair = '()', neigh_pattern = '[^\\].' },
          [')'] = { action = 'close', pair = '()', neigh_pattern = '[^\\].' },
          ['['] = { action = 'open', pair = '[]', neigh_pattern = '[^\\].' },
          [']'] = { action = 'close', pair = '[]', neigh_pattern = '[^\\].' },
          ['{'] = { action = 'open', pair = '{}', neigh_pattern = '[^\\].' },
          ['}'] = { action = 'close', pair = '{}', neigh_pattern = '[^\\].' },
          ['<'] = { action = 'open', pair = '<>', neigh_pattern = '[^\\].' },
          ['>'] = { action = 'close', pair = '<>', neigh_pattern = '[^\\].' },

          ['"'] = {
            action = 'closeopen',
            pair = '""',
            neigh_pattern = '[^\\].',
            register = { cr = false },
          },
          ["'"] = {
            action = 'closeopen',
            pair = "''",
            neigh_pattern = '[^%a\\].',
            register = { cr = false },
          },
          ['`'] = {
            action = 'closeopen',
            pair = '``',
            neigh_pattern = '[^\\].',
            register = { cr = false },
          },

          -- curved quotes
          ['“'] = {
            action = 'open',
            pair = '“”',
            neigh_pattern = '[^%a\\].',
            register = { cr = false },
          },
          ['”'] = {
            action = 'close',
            pair = '“”',
            neigh_pattern = '[^%a\\].',
            register = { cr = false },
          },
          ['‘'] = {
            action = 'open',
            pair = '‘’',
            neigh_pattern = '[^%a\\].',
            register = { cr = false },
          },
          ['’'] = {
            action = 'close',
            pair = '‘’',
            neigh_pattern = '[^%a\\].',
            register = { cr = false },
          },

          -- Guillemets
          ['‹'] = {
            action = 'open',
            pair = '‹›',
            neigh_pattern = '[^%a\\].',
            register = { cr = false },
          },
          ['›'] = {
            action = 'close',
            pair = '‹›',
            neigh_pattern = '[^%a\\].',
            register = { cr = false },
          },
          ['«'] = {
            action = 'open',
            pair = '«»',
            neigh_pattern = '[^%a\\].',
            register = { cr = false },
          },
          ['»'] = {
            action = 'close',
            pair = '«»',
            neigh_pattern = '[^%a\\].',
            register = { cr = false },
          },

          -- arrow brackets
          ['「'] = {
            action = 'open',
            pair = '「」',
            neigh_pattern = '[^%a\\].',
            register = { cr = false },
          },
          ['」'] = {
            action = 'close',
            pair = '「」',
            neigh_pattern = '[^%a\\].',
            register = { cr = false },
          },
          ['〈'] = {
            action = 'open',
            pair = '〈〉',
            neigh_pattern = '[^%a\\].',
            register = { cr = false },
          },
          ['〉'] = {
            action = 'close',
            pair = '〈〉',
            neigh_pattern = '[^%a\\].',
            register = { cr = false },
          },
          ['《'] = {
            action = 'open',
            pair = '《》',
            neigh_pattern = '[^%a\\].',
            register = { cr = false },
          },
          ['》'] = {
            action = 'close',
            pair = '《》',
            neigh_pattern = '[^%a\\].',
            register = { cr = false },
          },
        },
      },
    }
  end,
}
