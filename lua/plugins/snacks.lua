local header = [[
██████╗ ██╗  ██╗ █████╗ ███████╗███████╗███████╗██████╗
██╔══██╗██║  ██║██╔══██╗██╔════╝╚══███╔╝██╔════╝██╔══██╗
██████╔╝███████║███████║█████╗    ███╔╝ █████╗  ██████╔╝
██╔═══╝ ██╔══██║██╔══██║██╔══╝   ███╔╝  ██╔══╝  ██╔══██╗
██║     ██║  ██║██║  ██║███████╗███████╗███████╗██║  ██║
╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝╚═╝  ╚═╝]]


local explorer_config = {
  finder = "explorer",
  sort = { fields = { "sort" } },
  supports_live = true,
  tree = true,
  watch = true,
  diagnostics = true,
  diagnostics_open = false,
  git_status = true,
  git_status_open = false,
  git_untracked = true,
  follow_file = true,
  focus = "list",
  auto_close = false,
  jump = { close = false },
  layout = { preset = "sidebar", preview = false },
  -- to show the explorer to the right, add the below to
  -- your config under `opts.picker.sources.explorer`
  -- layout = { layout = { position = "right" } },
  formatters = {
    file = { filename_only = true },
    severity = { pos = "right" },
  },
  matcher = { sort_empty = false, fuzzy = false },
  config = function(opts)
    return require("snacks.picker.source.explorer").setup(opts)
  end,
  win = {
    input = {
      keys = {
        ['T'] = { 'tab', mode = { 'i', 'n' } },
      }
    },
    list = {
      keys = {
        ["<BS>"] = "explorer_up",
        ["l"] = "confirm",
        ["h"] = "explorer_close", -- close directory
        ["a"] = "explorer_add",
        ["d"] = "explorer_del",
        ["r"] = "explorer_rename",
        ["c"] = "explorer_copy",
        ["m"] = "explorer_move",
        ["o"] = "explorer_open", -- open with system application
        ["P"] = "toggle_preview",
        ["y"] = { "explorer_yank", mode = { "n", "x" } },
        ["p"] = "explorer_paste",
        ["u"] = "explorer_update",
        ["<c-c>"] = "tcd",
        ["<leader>/"] = "picker_grep",
        ["<c-t>"] = "terminal",
        ["."] = "explorer_focus",
        ["I"] = "toggle_ignored",
        ["H"] = "toggle_hidden",
        ["Z"] = "explorer_close_all",
        ["]g"] = "explorer_git_next",
        ["[g"] = "explorer_git_prev",
        ["]d"] = "explorer_diagnostic_next",
        ["[d"] = "explorer_diagnostic_prev",
        ["]w"] = "explorer_warn_next",
        ["[w"] = "explorer_warn_prev",
        ["]e"] = "explorer_error_next",
        ["[e"] = "explorer_error_prev",
        ["T"] = "tab",
      },
    },
  },
}

return {
  -- snacks, A collection of small QoL plugins for Neovim.
  -- src: https://github.com/folke/snacks.nvim
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    dashboard = {
      enabled = true,
      preset = {
        header = header,
      }
    },
    explorer = { enabled = true },
    indent = { -- see: https://github.com/folke/snacks.nvim/blob/main/docs/indent.md
      enabled = true,
      indent = {
        char = "│",
        only_scope = false,
        only_current = false,
        hl = {
          "IndentRainbowDim0",
          "IndentRainbowDim1",
          "IndentRainbowDim2",
          "IndentRainbowDim3",
          "IndentRainbowDim4",
          "IndentRainbowDim5",
          "IndentRainbowDim6",
          "IndentRainbowDim7",
        }
      },
      scope = {
        enabled = true, -- enable highlighting the current scope
        priority = 200,
        char = "│",
        underline = false,    -- underline the start of the scope
        only_current = false, -- only show scope in the current window
        hl = {
          "IndentRainbowBright0",
          "IndentRainbowBright1",
          "IndentRainbowBright2",
          "IndentRainbowBright3",
          "IndentRainbowBright4",
          "IndentRainbowBright5",
          "IndentRainbowBright6",
          "IndentRainbowBright7",
        }
      },
      animate = { enabled = false }, -- disable animations
    },
    input = { enabled = true },
    notifier = {
      enabled = true,
      timeout = 5000, -- 5 seconds
    },
    picker = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    styles = {               -- see: https://github.com/folke/snacks.nvim/blob/main/docs/styles.md
      notification = {
        wo = { wrap = true } -- Wrap notifications
      },
      -- cmd input above cursor
      input = {
        relative = "cursor",
        row = -3,
        col = 0,
      }
    }
  },

  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- set the hl groups


        local toggle = Snacks.toggle

        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
        vim.print = _G.dd -- Override print to use snacks for `:=` command

        -- toggle mappings
        -- see: https://github.com/folke/snacks.nvim/blob/main/docs/toggle.md
        toggle.option("spell", { name = "Spelling" }):map("<leader>us")
        toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
        toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
        toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
        toggle.option("conceallevel",
          { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }
        ):map("<leader>uc")

        -- color column toggle
        toggle.option("colorcolumn",
          { off = '', on = '+1', name = "Color Column", global = true }
        ):map("<leader>uv")

        -- cusror column toggle
        -- see: https://neovim.io/doc/user/options.html#'cursorcolumn'
        toggle.option("cursorcolumn",
          { name = "Cursor Column", global = true }
        ):map("<leader>uV")

        toggle.diagnostics():map("<leader>ud")
        toggle.line_number():map("<leader>ul")
        toggle.treesitter():map("<leader>uT")
        toggle.inlay_hints():map("<leader>uh")
        toggle.indent():map("<leader>ug")
        toggle.dim():map("<leader>uD")
      end,
    })
  end,
}
