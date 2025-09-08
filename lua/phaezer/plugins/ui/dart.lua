-- NOTE: minimalist tabline focused on pinning buffers for fast switching between a group of files. Pick a file and throw a single-character dart to jump to it.
return {
  'iofq/dart.nvim',
  dependencies = {
    'echasnovski/mini.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  opts = {
    -- List of characters to use to mark 'pinned' buffers
    -- The characters will be chosen for new pins in order
    marklist = { 'a', 's', 'd', 'f', 'j', 'h', 'k', 'l', 'g', 'h'},

    -- List of characters to use to mark recent buffers, which are displayed first (left) in the tabline
    -- Buffers that are 'marked' are not included in this list
    -- The length of this list determines how many recent buffers are tracked
    -- Set to {} to disable recent buffers in the tabline
    buflist = { 'q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p'},

    tabline = {
      -- Force the tabline to always be shown, even if no files are currently marked
      always_show = true,

      -- If true, Dart.next and Dart.prev will wrap around the tabline
      cycle_wraps_around = true,

      -- Override the default label foreground highlight
      -- You can also use the DartVisibleLabel/DartCurrentLabel/etc. highlights
      -- to override the label highlights entirely.
      -- label_fg = 'orange',

      -- Display icons in the tabline
      -- Supported icon providers are mini.icons and nvim-web-devicons
      icons = true,

      -- Function to determine the order mark/buflist items will be shown on the tabline
      -- Should return a table with keys being the mark and values being integers,
      -- e.g. { "a": 1, "b", 2 } would sort the "a" mark to the left of "b" on your tabline
      order = function(config)
        local order = {}
        for i, key in ipairs(vim.list_extend(vim.deepcopy(config.buflist), config.marklist)) do
          order[key] = i
        end
        return order
      end,

      -- Function to format a tabline item after the path is built
      format_item = function(item)
        local icon = item.icon ~= nil and string.format('%s  ', item.icon) or ''
        return string.format(
          '%%#%s#%s %s%%#%s#%s%%#%s#%s %%X',
          item.hl,
          item.click,
          icon,
          item.hl_label,
          item.label,
          item.hl,
          item.content
        )
      end,
    },

    picker = {
      -- argument to pass to vim.fn.fnamemodify `mods`, before displaying the file path in the picker
      -- e.g. ":t" for the filename, ":p:." for relative path to cwd
      path_format = ':t',
      -- border style for the picker window
      -- See `:h winborder` for options
      border = 'rounded',
    },

    -- State persistence. Use Dart.read_session and Dart.write_session manually
    persist = {
      -- Path to persist session data in
      path = vim.fs.joinpath(vim.fn.stdpath 'data', 'dart'),
    },

    -- Default mappings
    -- Set an individual mapping to an empty string to disable,
    mappings = {
      mark = ';;', -- Mark current buffer
      jump = ';', -- Jump to buffer marked by next character i.e `;a`
      pick = ';<Space>', -- Open Dart.pick
      next = '<S-l>', -- Cycle right through the tabline
      prev = '<S-h>', -- Cycle left through the tabline
      unmark_all = ';u', -- Close all marked and recent buffers
    },
  },
}
