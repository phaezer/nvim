-- NOTE: auto creates open/close paris of brackets, quotes, etc.
return {
  'nvim-mini/mini.pairs',
  version = '*',
  lazy = false,
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

      -- guillemets
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
  init = function()
    require('phaezer.core.keys').map {
      plugin = 'mini.pairs',
      prefix = '<leader>k',
      {
        'p',
        function()
          -- cSpell:words minipairs
          ---@diagnostic disable-next-line: inject-field
          vim.g.minipairs_disable = not (vim.g.minipairs_disable or false)
          if vim.g.minipairs_disable then
            vim.notify 'mini.pairs disabled'
          else
            vim.notify 'mini.pairs enabled'
          end
        end,
        desc = 'toggle auto pairs',
      },
    }
  end,
}
