-- Window Picker
-- a Neovim plugin that allows you to pick a window by its number or name
return {
  's1n7ax/nvim-window-picker',
  lazy = true,
  name = 'window-picker',
  event = 'VeryLazy',
  version = '2.*',
  config = function()
    require('window-picker').setup {
      -- type of hints you want to get
      -- following types are supported
      -- 'statusline-winbar' | 'floating-big-letter' | 'floating-letter'
      -- 'statusline-winbar' draw on 'statusline' if possible, if not 'winbar' will be
      -- 'floating-big-letter' draw big letter on a floating window
      -- 'floating-letter' draw letter on a floating window
      hint = 'floating-letter',
      -- hint = 'floating-big-letter',
      -- This section contains picker specific configurations
      picker_config = {
        handle_mouse_click = true,
        statusline_winbar_picker = {
          -- You can change the display string in status bar.
          -- It supports '%' printf style. Such as `return char .. ': %f'` to display
          -- buffer file path. See :h 'stl' for details.
          selection_display = function(char, windowid) return '%=' .. char .. '%=' end,

          -- whether you want to use winbar instead of the statusline
          -- "always" means to always use winbar,
          -- "never" means to never use winbar
          -- "smart" means to use winbar if cmdheight=0 and statusline if cmdheight > 0
          use_winbar = 'always', -- "always" | "never" | "smart"
        },
      },
      filter_rules = {
        include_current_win = false,
        autoselect_one = true,
        -- filter using buffer options
        bo = {
          -- if the file type is one of following, the window will be ignored
          filetype = { 'neo-tree', 'neo-tree-popup', 'notify', 'snacks_notif', 'floaterm' },
          -- if the buffer type is one of following, the window will be ignored
          buftype = { 'terminal', 'quickfix' },
        },
      },
      show_prompt = false,
      highlights = {
        enabled = false,
      },
    }

    -- create the pick window comand and keybinding
    vim.api.nvim_create_user_command('PickWindow', function()
      local win_id = require('window-picker').pick_window()
      if win_id then vim.api.nvim_set_current_win(win_id) end
    end, { desc = 'pick a window' })
  end,
  keys = {
    { '<leader>wp', '<cmd>PickWindow<cr>', desc = 'pick ' },
  },
}
