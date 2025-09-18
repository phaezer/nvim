-- NOTE: provides function signature when typing
--  testing this out, may go back to snacks.
return {
  'ray-x/lsp_signature.nvim',
  event = 'InsertEnter',
  enabled = false, -- changing back to snacks for now
  opts = {
    bind = true,
    handler_opts = {
      border = 'rounded',
    },
    always_trigger = false,
    hint_prefix = '󰫧 ',
    move_signature_window_key = {
      '<A-S-j>',
      '<A-S-k>',
      '<A-S-h>',
      '<A-S-l>',
    },
    auto_close_after = 5,
    select_signature_key = '<A-S-n>',
    move_cursor_key = '<A-S-p>',
    floating_window_off_x = 5, -- adjust float windows x position.
    -- cSpell:disable
    floating_window_off_y = function() -- adjust float windows y position. e.g. set to -2 can make floating window move up 2 lines
      local pumheight = vim.o.pumheight
      local winline = vim.fn.winline() -- line number in the window
      local winheight = vim.fn.winheight(0)

      -- window top
      if winline - 1 < pumheight then return pumheight end

      -- window bottom
      if winheight - winline < pumheight then return -pumheight end
      return 0
    end,
  },
}
