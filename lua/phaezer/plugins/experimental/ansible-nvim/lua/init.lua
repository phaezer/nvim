local util = require 'phaezer.core.util'

---Saves the contents of a TS node to a file.
---@param file_name string the name of the file to store the text in.
local function get_node_lines(node, file_name)
  local text = vim.treesitter.get_node_text(node, 0):gsub('^[^\n]*\n', '')
  local lines = {}
  for s in text:gmatch '[^\r\n]+' do
    local line = s:gsub('^ *', '')
    table.insert(lines, line)
  end
  return lines
end

local trim_spaces = true
vim.keymap.set(
  'v',
  '<space>s',
  function()
    require('toggleterm').send_lines_to_terminal('single_line', trim_spaces, { args = vim.v.count })
  end
)
-- Replace with these for the other two options
-- require("toggleterm").send_lines_to_terminal("visual_lines", trim_spaces, { args = vim.v.count })
-- require("toggleterm").send_lines_to_terminal("visual_selection", trim_spaces, { args = vim.v.count })

-- For use as an operator map:
-- Send motion to terminal
vim.keymap.set('n', [[<leader><c-\>]], function()
  set_opfunc(
    function(motion_type)
      require('toggleterm').send_lines_to_terminal(motion_type, false, { args = vim.v.count })
    end
  )
  vim.api.nvim_feedkeys('g@', 'n', false)
end)
-- Double the command to send line to terminal
vim.keymap.set('n', [[<leader><c-\><c-\>]], function()
  set_opfunc(
    function(motion_type)
      require('toggleterm').send_lines_to_terminal(motion_type, false, { args = vim.v.count })
    end
  )
  vim.api.nvim_feedkeys('g@_', 'n', false)
end)
-- Send whole file
vim.keymap.set('n', [[<leader><leader><c-\>]], function()
  set_opfunc(
    function(motion_type)
      require('toggleterm').send_lines_to_terminal(motion_type, false, { args = vim.v.count })
    end
  )
  vim.api.nvim_feedkeys("ggg@G''", 'n', false)
end)

vim.api.nvim_create_user_command('VaultEncrypt', function()
  local text = util.get_selected_text()
  local encrypted_string = util.shell_cmd('ansible-vault encrypt_string ' .. text)
  util.replace_selection(encrypted_string)
end, {})

vim.api.nvim_create_user_command('VaultDecrypt', function()
  local text = util.get_selected_text()
  local result = vim
    .system({ 'sh', '-c', 'ansible-vault decrypt' }, { text = true, cwd = cwd })
    :wait()

  local encrypted_string = util.shell_cmd('ansible-vault ' .. text)
  util.replace_selection(encrypted_string)
end, {})

-- TODO: use selection from utils with vault commands
vim.api.nvim_create_user_command('VaultDecryptBlock', function()
  local node = vim.treesitter.get_node()
  if node and node:type() == 'block_scalar' then
    save_node_text_to_file(node, '/tmp/ansible-vault.txt')
    require('snacks').terminal.open('ansible-vault view /tmp/ansible-vault.txt | pbcopy', {
      win = {
        position = 'float',
        border = 'rounded',
      },
    })
  end
end, {})

vim.api.nvim_create_user_command('VaultRecryptBlock', function()
  local node = vim.treesitter.get_node()
  if node and node:type() == 'block_scalar' then
    save_node_text_to_file(node, '/tmp/ansible-vault.txt')
    require('snacks').terminal.open(
      'ansible-vault rekey /tmp/ansible-vault.txt && cat /tmp/ansible-vault.txt | pbcopy',
      {
        win = {
          position = 'float',
          border = 'rounded',
        },
      }
    )
  end
end, {})
