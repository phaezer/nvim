-- NOTE: copilot-lsp provides next edit prediction
return {
  'copilotlsp-nvim/copilot-lsp',
  opts = {
    nes = {
      move_count_threshold = 1, -- clear after moving
    },
  },
  init = function()
    vim.g.copilot_nes_debounce = 200
    vim.lsp.enable 'copilot_ls'

    vim.keymap.set('n', '<C-a>', function()
      local bufnr = vim.api.nvim_get_current_buf()
      local state = vim.b[bufnr].nes_state
      if state then
        -- Try to jump to the start of the suggestion edit.
        -- If already at the start, then apply the pending suggestion and jump to the end of the edit.
        local _ = require('copilot-lsp.nes').walk_cursor_start_edit()
          or (
            require('copilot-lsp.nes').apply_pending_nes()
            and require('copilot-lsp.nes').walk_cursor_end_edit()
          )
        return nil
      else
        -- Resolving the terminal's inability to distinguish between `TAB` and `<C-i>` in normal mode
        return '<C-a>'
      end
    end, { desc = 'Accept Copilot NES suggestion', expr = true })

    local function clear(fallback)
      return function()
        if not require('copilot-lsp.nes').clear() then fallback() end
      end
    end

    vim.keymap.set(
      'i',
      '<C-;>',
      clear(function() return '<C-;>' end),
      { desc = 'Clear Copilot NES suggestion or fallback', expr = true }
    )

    vim.keymap.set(
      'i',
      '<C-d>',
      clear(function() return '<C-;>' end),
      { desc = 'Clear Copilot NES suggestion or fallback', expr = true }
    )
  end,
}
