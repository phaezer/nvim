--- neovim options
local o = vim.opt

-- term colors
o.termguicolors = true

-- line numbers
o.number = true
o.relativenumber = true

o.guicursor = {
  'n-c-sm:block',
  'i-ci-ve:ver25',
  'v-r-cr-o:hor20',
  't:block-blinkon500-blinkoff500-TermCursor',
  'a:SmearCursorHideable',
}

-- enable mouse mode https://neovim.io/doc/user/options.html#'mouse'
o.mouse = 'a'
o.showmode = false

-- clipboard
o.clipboard = 'unnamedplus'

-- Enable break indent
o.breakindent = true

-- Save undo history
o.undofile = true
-- Maximum number of changes that can be undone
o.undolevels = 1000

-- searching
o.ignorecase = true
o.smartcase = true
o.smartindent = true

-- Keep signcolumn on by default
o.signcolumn = 'yes'

-- Decrease update time
o.updatetime = 250

-- Decrease mapped sequence wait time
o.timeoutlen = 300

-- splits
o.splitright = true
o.splitbelow = true

o.list = false

o.listchars = {
  eol = '',
  tab = ' ',
  trail = '',
  extends = '',
  precedes = '',
  space = '',
  nbsp = '',
}

-- do not show listchars by default
-- o.nolist = true

-- fillchars
o.fillchars = {
  eob = ' ',
  fold = '󱑼',
  foldsep = '│',
  foldopen = '󰘖',
  foldclose = '󰘕',
}

-- Preview substitutions
o.inccommand = 'split'

-- Show which line your cursor is on
o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
o.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
o.confirm = true

-- folding
o.foldtext = ''
o.foldenable = true
o.foldmethod = 'expr'
o.foldlevel = 99
-- top level folds only are closed by default
o.foldlevelstart = -1
o.foldnestmax = 5
o.foldtext = ''

-- default tabs and spaces
o.shiftwidth = 4
o.tabstop = 2
o.softtabstop = 2
o.expandtab = true
o.smarttab = true

-- popup windows
o.pumblend = 5
o.pumheight = 12
o.pumwidth = 20

-- ghostty
if vim.fn.getenv 'TERM_PROGRAM' == 'ghostty' then
  vim.opt.title = true
  vim.opt.titlestring = "%{fnamemodify(getcwd(), ':t')}"
end
