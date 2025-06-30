local icons = Config.icon

return {
  {
    -- Bufferline
    -- src: https://github.com/akinsho/bufferline.nvim
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    },
  },

  {
    -- illuminate - A plugin for highlighting other uses of the word under the cursor
    -- src: https://github.com/RRethy/vim-illuminate
    'RRethy/vim-illuminate',
    event = 'BufReadPost',
    config = function()
      require('illuminate').configure {
        delay = 100,
        filetypes_denylist = {
          'dirbuf',
          'dirvish',
          'fugitive',
          'Outline',
        },
      }
    end,
  },

  {
    -- Colorizer
    -- src: https://github.com/catgoose/nvim-colorizer.lua
    "catgoose/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = {}
  },

  {
    -- Lualine
    -- src: https://github.com/nvim-lualine/lualine.nvim
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = {
      "bwpge/lualine-pretty-path",
    },
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) > 0 then
        -- set an empty statusline till lualine loads
        vim.o.statusline = " "
      else
        -- hide the statusline on the starter page
        vim.o.laststatus = 0
      end
    end,
    opts = function()
      -- Custom Lualine component to show attached language server
      local clients_lsp = function()
        local clients = vim.lsp.get_clients()
        if next(clients) == nil then
          return ""
        end

        local c = {}
        for _, client in pairs(clients) do
          table.insert(c, client.name)
        end
        return " " .. table.concat(c, "|")
      end

      vim.o.laststatus = vim.g.lualine_laststatus

      return {
        options = {
          theme = "auto",
          globalstatus = true,
          disabled_filetypes = {
            statusline = {
              "dashboard",
              "alpha",
              "ministarter",
              "snacks_dashboard",
              "Outline"
            }
          },
          component_separators = '|',
          section_separators = { left = '', right = '' },
        },
        sections = {

          lualine_a = {
            {
              'mode',
              separator = { left = ' ', right = '' },
              -- padding = { left = 1, right = 1 },
              icon = icons.ui.Neovim
            }
          },

          lualine_b = {
            { "branch", icon = icons.git.Branch }
          },

          lualine_c = {
            {
              "diagnostics",
              symbols = {
                error = icons.ui.Error,
                warn = icons.ui.Warning,
                info = icons.ui.Info,
                hint = icons.ui.Hint,
              },
              update_in_insert = true,
            },
            { "pretty_path" }
          },

          lualine_x = {
            Snacks.profiler.status(),
            -- stylua: ignore
            {
              function() return require("noice").api.status.command.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
              color = function() return { fg = Snacks.util.color("Statement") } end,
            },
            -- stylua: ignore
            {
              function() return require("noice").api.status.mode.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
              color = function() return { fg = Snacks.util.color("Constant") } end,
            },
            -- stylua: ignore
            {
              function() return icons.ui.Debug .. " " .. require("dap").status() end,
              cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
              color = function() return { fg = Snacks.util.color("Debug") } end,
            },
            -- stylua: ignore
            {
              require("lazy.status").updates,
              cond = require("lazy.status").has_updates,
              color = function() return { fg = Snacks.util.color("Special") } end,
            },
            {
              "diff",
              symbols = {
                added = icons.git.Added .. " ",
                modified = icons.git.Modified .. " ",
                removed = icons.git.Removed .. " ",
              },
              source = function()
                local gitsigns = vim.b.gitsigns_status_dict
                if gitsigns then
                  return {
                    added = gitsigns.added,
                    modified = gitsigns.changed,
                    removed = gitsigns.removed,
                  }
                end
              end,
            },
          },

          lualine_y = {
            clients_lsp,
            { "progress", separator = " ", padding = { left = 1, right = 2 } },
          },

          lualine_z = {
            {
              "location",
              -- padding = { left = 0, right = 1 },
              separator = { left = '', right = '' },
              icon = ""
            },
          },
        },

        extensions = { "neo-tree", "lazy", "fzf", "trouble" },

        inactive_sections = {
          lualine_a = { 'filename' },
          lualine_b = {},
          lualine_c = { 'pretty_path' },
          lualine_x = {},
          lualine_y = {},
          lualine_z = { 'location' },
        },
      }
    end,
  },

  {
    -- noice - A noice UI for neovim
    -- https://github.com/folke/noice.nvim
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      routes = {
        {
          view = "notify",
          filter = { event = "msg_showmode" },
        },
      },
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true,         -- use a classic bottom cmdline for search
        command_palette = true,       -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false,           -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false,       -- add a border to hover docs and signature help
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  }
}
