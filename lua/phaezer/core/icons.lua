local icons = {}

icons.diagnostics = {
  Error = '',
  Warn = '',
  Info = '󰙎',
  Hint = '',
}

icons.list = {
  eol = '󰌑',
  tab = '  ',
  lead = '',
  trail = '',
  extends = '󰄾',
  precedes = '󰄽',
  space = '',
  nbsp = '',
}

---@param keys ('all'|'eol'|'tab'|'lead'|'trail'|'extends'|'precedes'|'space'|'nbsp')[] | 'all'
icons.listchars = function(keys)
  if keys == 'all' then return icons.list end
  local chars = {}
  if type(keys) ~= 'table' then return end
  for _, k in ipairs(keys) do
    chars[k] = icons.list[k]
  end
  return chars
end

icons.fill = {
  eob = ' ',
  lastline = '',
  fold = '󱑼',
  foldopen = '',
  foldclose = '',
  foldsep = '',
  diff = '',
}

---@param keys ('eob'|'lastline'|'fold'|'foldopen'|'foldclose'|'foldsep'|'diff')[] | 'all'
icons.fillchars = function(keys)
  if keys == 'all' then return icons.fill end
  local chars = {}
  if type(keys) ~= 'table' then return end
  for _, k in ipairs(keys) do
    chars[k] = icons.fill[k]
  end
  return chars
end

icons.git = {
  Commit = '󰜘',
  Added = '',
  Removed = '',
  Renamed = '󰟵',
  Modified = '󰥛',
  Staged = '',
  Ignored = '',
  Conflict = '',
  Untracked = '',
  Unstaged = '',
}

icons.gui = {
  Undo = '󰕍',
  Config = '󰢻',
  Quit = '󰩈',
  Exit = '󰈆',
  Keyboard = '',
  Search = '',
  Grep = '󱎸',
  Folder = '',
  FolderOpen = '',
  FolderEmpty = '',
  FolderClosed = '',
  File = '',
  Files = '',
  Mason = '󱌣',
  Lazy = '󰒲',
  Branch = '',
  Neovim = '',
  Server = '󰒋',
  Done = '󰸞',
  FoldOpen = '',
  FoldClosed = '',
}

icons.kind = {
  Folder = '',
  FolderOpen = '',
  FolderEmpty = '',
  FolderClosed = '',
  File = '',
  Files = '',
  Array = '󰅪',
  Boolean = '󰨙',
  Breadcrumb = '»',
  Bug = '',
  Class = '',
  Close = '',
  Cmd = '',
  Codeium = '󰘦',
  Collapsed = '',
  Color = '',
  Config = '',
  Constant = '',
  Constructor = '',
  Control = '',
  Copilot = '',
  Date = '',
  Debug = '',
  Doc = '󱗖',
  Done = '',
  Dots = '󰇘',
  Enum = '',
  EnumMember = '',
  Error = '',
  Event = '',
  Expanded = '',
  Field = '󰽐',
  FileTree = '',
  Function = '󰊕',
  Group = '+',
  Hack = '',
  Hint = '',
  Import = '󰋺',
  Imports = '󰋺',
  Info = '',
  Init = '',
  Interface = '',
  Key = '󰌋',
  Keys = '',
  Keyword = '',
  Lazy = '󰒲',
  Loaded = '',
  Loading = '',
  Lock = '',
  Method = '󰊕',
  Mention = '',
  Module = '',
  Namespace = '󰦮',
  Neovim = '',
  Note = '',
  NotLoaded = '',
  Null = '󰟢',
  Number = '',
  Object = '󰅩',
  Operator = '󰆕',
  Package = '',
  Perf = '',
  Pin = '',
  Plugin = '',
  Property = '',
  Reference = '',
  Require = '',
  Runtime = '',
  Shortcut = '󰬫',
  Snippet = '󱄽',
  Source = '',
  Star = '',
  Start = '',
  String = '',
  Struct = '',
  Supermaven = '',
  Tag = '',
  Task = '',
  Telescope = '',
  Test = '',
  Text = '󱀍',
  Todo = '',
  TypeParameter = '󰗴',
  Unit = '',
  Unlock = '󰿇',
  Value = '',
  Variable = '󰫧',
  Warning = '',
  Web = '',
}

icons.spinners = {
  circle = { '', '', '', '', '', '', '' },
  bar_wave = {
    '▁',
    '▂',
    '▃',
    '▄',
    '▅',
    '▆',
    '▇',
    '█',
    '▇',
    '▆',
    '▅',
    '▄',
    '▃',
    '▁',
  },
}

return icons
