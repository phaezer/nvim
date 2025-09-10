-- NOTE: auto creates open/close paris of brackets, quotes, etc.
return {
  'echasnovski/mini.pairs',
  version = '*',
  enabled = false, -- pairs have become more annoying than helpful
  opts = {
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
      -- ['('] = { action = 'open', pair = '()', neigh_pattern = '[^\\].' },
      -- [')'] = { action = 'close', pair = '()', neigh_pattern = '[^\\].' },
      -- ['['] = { action = 'open', pair = '[]', neigh_pattern = '[^\\].' },
      -- [']'] = { action = 'close', pair = '[]', neigh_pattern = '[^\\].' },
      -- ['{'] = { action = 'open', pair = '{}', nuigh_pattern = '[^\\].' },
      -- ['}'] = { action = 'close', pair = '{}', neigh_pattern = '[^\\].' },
      -- ['<'] = { action = 'open', pair = '<>', neigh_pattern = '[^\\].' },
      -- ['>'] = { action = 'close', pair = '<>', neigh_pattern = '[^\\].' },
      --
      -- ['"'] = {
      --   action = 'closeopen',
      --   pair = '""',
      --   neigh_pattern = '[^\\].',
      --   register = { cr = false },
      -- },
      -- ["'"] = {
      --   action = 'closeopen',
      --   pair = "''",
      --   neigh_pattern = '[^%a\\].',
      --   register = { cr = false },
      -- },
      -- ['`'] = {
      --   action = 'closeopen',
      --   pair = '``',
      --   neigh_pattern = '[^\\].',
      --   register = { cr = false },
      -- },

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
