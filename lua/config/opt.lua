-- [[ options ]]
local o = vim.opt

o.number = true
o.relativenumber = true

-- enable mouse mode https://neovim.io/doc/user/options.html#'mouse'
o.mouse = 'a'

o.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  o.clipboard = 'unnamedplus'
end)

-- Enable break indent
o.breakindent    = true

-- Save undo history
o.undofile       = true
-- Maximum number of changes that can be undone
o.undolevels     = 1000

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
o.ignorecase     = true
o.smartcase      = true
-- Insert indents automatically
o.smartindent    = true

-- Keep signcolumn on by default
o.signcolumn     = 'yes'

-- Decrease update time
o.updatetime     = 250

-- Decrease mapped sequence wait time
o.timeoutlen     = 300

-- Configure how new splits should be opened
o.splitright     = true
o.splitbelow     = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-options-guide`
o.list           = true
o.listchars      = {
  tab = ' ',
  trail = '',
  nbsp = '␣',
}
o.fillchars      = "eob:" ..
    ",fold:" ..
    ",foldsep:│" ..
    ",foldopen:󰘖" ..
    ",foldclose:󰘕"
o.foldtext       = ""

-- Preview substitutions live, as you type!
o.inccommand     = 'split'

-- Show which line your cursor is on
o.cursorline     = true

-- Minimal number of screen lines to keep above and below the cursor.
o.scrolloff      = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
o.confirm        = true

-- folding
o.foldenable     = true
o.foldmethod     = "expr"
o.foldlevel      = 99
-- top level folds only are closed by default
o.foldlevelstart = -1
o.foldnestmax    = 5
o.foldtext       = ""

-- default tabs and spaces
o.shiftwidth     = 2
o.tabstop        = 2
