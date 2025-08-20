local g = vim.g
-- os flags
g.is_mac = vim.uv.os_uname().sysname:find 'Darwin' ~= nil
g.is_win = vim.uv.os_uname().sysname:find 'Windows' ~= nil
g.is_linux = vim.uv.os_uname().sysname:find 'Linux' ~= nil
g.is_bsd = vim.uv.os_uname().sysname:find 'BSD' ~= nil
g.fs_sep = g.is_win and '\\' or '/'

-- default background color used by some custom color highlights such as rainbow indents
g.default_background_color = '#000000'
