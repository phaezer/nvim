-- NOTE: obsidian integartion for plaintext notes

-- list of obsidian workspaces
local workspaces = {
  { 'journal', path = '~/obsidian/journal' },
  { 'writing', path = '~/obsidian/writing' },
  { 'notes', path = '~/obsidian/notes' },
}

-- build event table from workspaces
local events = {}
for _, ws in ipairs(workspaces) do
  table.insert(events, 'BufReadPre ' .. vim.fn.expand(ws.path .. '/*'))
  table.insert(events, 'BufNewFile ' .. vim.fn.expand(ws.path .. '/*'))
end

return {
  'obsidian-nvim/obsidian.nvim',
  lazy = true,
  version = '*', -- recommended, use latest release instead of latest commit
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  cmd = 'Obsidian',
  event = events,
  keys = {
    -- TODO: additional keymaps (see docs)
    { '<leader>kO', '<cmd>Obsidian<CR>', desc = 'search  Obsidian' },
    { '<leader>kos', '<cmd>Obsidian search<CR>', desc = 'search  Obsidian' },
    { '<leader>kon', '<cmd>Obsidian new<CR>', desc = 'new  Obsidian' },
  },
  opts = {
    workspaces = workspaces,
    completion = {
      nvim_cmp = false,
      blink = true,
    },
    picker = {
      name = 'snacks.pick',
    },
    ui = {
      ignore_conceal_warn = true,
      -- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
      [' '] = { char = '󰄱', hl_group = 'ObsidianTodo' },
      ['x'] = { char = '', hl_group = 'ObsidianDone' },
      ['>'] = { char = '', hl_group = 'ObsidianRightArrow' },
      ['~'] = { char = '󰜥', hl_group = 'ObsidianTilde' },
      ['!'] = { char = '', hl_group = 'ObsidianImportant' },
    },
    legacy_commands = false,
  },
}
