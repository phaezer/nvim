-- NOTE: provides lsp progress info for lualine
return {
  'linrongbin16/lsp-progress.nvim',
  config = function()
    local lsp_name_map = {
      ['GitHub Copilot'] = '',
      cspell_ls = '',
    }
    require('lsp-progress').setup {
      client_format = function(client_name, spinner, series_messages)
        if #series_messages == 0 then return nil end
        return {
          name = client_name,
          body = spinner .. ' ' .. table.concat(series_messages, ', '),
        }
      end,
      format = function(client_messages)
        --- @param name string
        --- @param msg string?
        --- @return string
        local function stringify(name, msg) return msg and string.format('%s %s', name, msg) or name end

        local lsp_clients = vim.lsp.get_clients()
        local messages_map = {}
        for _, msg in ipairs(client_messages) do
          messages_map[msg.name] = msg.body
        end

        if #lsp_clients > 0 then
          table.sort(lsp_clients, function(a, b) return a.name < b.name end)
          local builder = {}
          for _, cli in ipairs(lsp_clients) do
            if type(cli) == 'table' and type(cli.name) == 'string' and string.len(cli.name) > 0 then
              -- if client name is in the lsp_name_map, use the mapped icon
              local name = lsp_name_map[cli.name] or cli.name
              if messages_map[cli.name] then
                table.insert(builder, stringify(name, messages_map[name]))
              else
                table.insert(builder, stringify(name))
              end
            end
          end
          if #builder > 0 then return table.concat(builder, ' ') end
        end
        return ''
      end,
    }
  end,
}
