-- fzf-lua - A fzf wrapper for neovim written in lua
-- src: https://github.com/ibhagwan/fzf-lua
return {
  "ibhagwan/fzf-lua",
  cmd = "FzfLua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = function(_, opts)
    local fzf = require("fzf-lua")
    local config = fzf.config
    local actions = fzf.actions

    -- Quickfix
    config.defaults.keymap.fzf["ctrl-q"] = "select-all+accept"
    config.defaults.keymap.fzf["ctrl-u"] = "half-page-up"
    config.defaults.keymap.fzf["ctrl-d"] = "half-page-down"
    config.defaults.keymap.fzf["ctrl-x"] = "jump"
    config.defaults.keymap.fzf["ctrl-f"] = "preview-page-down"
    config.defaults.keymap.fzf["ctrl-b"] = "preview-page-up"
    config.defaults.keymap.builtin["<c-f>"] = "preview-page-down"
    config.defaults.keymap.builtin["<c-b>"] = "preview-page-up"

    -- Trouble
    config.defaults.actions.files["ctrl-t"] = require("trouble.sources.fzf").actions.open
    config.defaults.actions.files["alt-c"] = config.defaults.actions.files["ctrl-r"]
    -- config.set_action_helpstr(config.defaults.actions.files["ctrl-r"], "toggle-root-dir")

    local img_previewer ---@type string[]?
    for _, v in ipairs({
      { cmd = "ueberzug", args = {} },
      { cmd = "chafa",    args = { "{file}", "--format=symbols" } },
      { cmd = "viu",      args = { "-b" } },
    }) do
      if vim.fn.executable(v.cmd) == 1 then
        img_previewer = vim.list_extend({ v.cmd }, v.args)
        break
      end
    end

    return {
      "default-title",
      fzf_colors = true,
      fzf_opts = {
        ["--no-scrollbar"] = true,
      },
      defaults = {
        -- formatter = "path.filename_first",
        formatter = "path.dirname_first",
      },
      previewers = {
        builtin = {
          extensions = {
            ["png"] = img_previewer,
            ["jpg"] = img_previewer,
            ["jpeg"] = img_previewer,
            ["gif"] = img_previewer,
            ["webp"] = img_previewer,
          },
          ueberzug_scaler = "fit_contain",
        },
      },

      -- Custom LazyVim option to configure vim.ui.select
      ui_select = function(fzf_opts, items)
        return vim.tbl_deep_extend("force", fzf_opts, {
          prompt = " ",
          winopts = {
            title = " " .. vim.trim((fzf_opts.prompt or "Select"):gsub("%s*:%s*$", "")) .. " ",
            title_pos = "center",
          },
        }, fzf_opts.kind == "codeaction" and {
          winopts = {
            layout = "vertical",
            -- height is number of items minus 15 lines for the preview, with a max of 80% screen height
            height = math.floor(math.min(vim.o.lines * 0.8 - 16, #items + 2) + 0.5) + 16,
            width = 0.5,
            {
              layout = "vertical",
              vertical = "down:15,border-top",
            },
          },
        } or {
          winopts = {
            width = 0.5,
            -- height is number of items, with a max of 80% screen height
            height = math.floor(math.min(vim.o.lines * 0.8, #items + 2) + 0.5),
          },
        })
      end,

      winopts = {
        width = 0.8,
        height = 0.8,
        row = 0.5,
        col = 0.5,
        preview = {
          scrollchars = { "┃", "" },
        },
      },

      files = {
        cwd_prompt = false,
        actions = {
          ["alt-i"] = { actions.toggle_ignore },
          ["alt-h"] = { actions.toggle_hidden },
        },
      },

      grep = {
        actions = {
          ["alt-i"] = { actions.toggle_ignore },
          ["alt-h"] = { actions.toggle_hidden },
        },
      },

      lsp = {
        symbols = {
          symbol_icons = Config.icon.kind,
          symbol_hl = function(s) return "TroubleIcon" .. s end,
          symbol_fmt = function(s) return s:lower() .. "\t" end,
          child_prefix = false,
        },
        code_actions = {
          previewer = vim.fn.executable("delta") == 1 and "codeaction_native" or nil,
        },
      },
    }
  end,

  config = function(_, opts)
    if opts[1] == "default-title" then
      -- use the same prompt for all pickers for profile `default-title` and
      -- profiles that use `default-title` as base profile
      local function fix(t)
        t.prompt = t.prompt ~= nil and " " or nil
        for _, v in pairs(t) do
          if type(v) == "table" then
            fix(v)
          end
        end
        return t
      end
      opts = vim.tbl_deep_extend("force", fix(require("fzf-lua.profiles.default-title")), opts)
      opts[1] = nil
    end
    require("fzf-lua").setup(opts)
  end,

  keys = {
    -- { "jk",    "<esc>", ft = "fzf", mode = { "i", "v", "t" }, desc = "Exit fzf" },
    --   { "<c-j>", "<c-j>", ft = "fzf", mode = "t", nowait = true },
    --   { "<c-k>", "<c-k>", ft = "fzf", mode = "t", nowait = true },
    --   {
    --     "<leader>,",
    --     "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>",
    --     desc = "Switch Buffer",
    --   },
    --   {
    --     "<leader>/",
    --     "<cmd>FzfLua live_grep<cr>",
    --     desc = "Find Grep (Root Dir)"
    --   },
    --   {
    --     "<leader>:",
    --     "<cmd>FzfLua command_history<cr>",
    --     desc = "Command History"
    --   },
    --   {
    --     "<leader><space>",
    --     "<cmd>FzfLua files fzf_opts --layout=reverse-list<cr>",
    --     desc = "Find Files (Root Dir)"
    --   },

    --   -- find
    --   {
    --     "<leader>fb",
    --     "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>",
    --     desc = "[F]ind [B]uffers"
    --   },
    --   {
    --     "<leader>ff",
    --     "<cmd>FzfLua files fzf_opts --layout=reverse-list<cr>",
    --     desc = "[F]ind [F]iles (Root Dir)"
    --   },
    --   {
    --     "<leader>fg",
    --     "<cmd>FzfLua git_files<cr>",
    --     desc = "[F]ind [G]it-files"
    --   },
    --   {
    --     "<leader>fr",
    --     "<cmd>FzfLua oldfiles<cr>",
    --     desc = "[F]ind [R]ecent"
    --   },

    --   -- git
    --   {
    --     "<leader>gc",
    --     "<cmd>FzfLua git_commits<CR>",
    --     desc = "[G]it [C]ommits"
    --   },
    --   {
    --     "<leader>gs",
    --     "<cmd>FzfLua git_status<CR>",
    --     desc = "[G]it [S]tatus"
    --   },

    --   -- search
    --   {
    --     "<leader>sr",
    --     "<cmd>FzfLua registers<cr>",
    --     desc = "[S]earch [R]egisters"
    --   },
    --   {
    --     "<leader>sa",
    --     "<cmd>FzfLua autocmds<cr>",
    --     desc = "[S]earch [A]uto Commands"
    --   },
    --   {
    --     "<leader>sc",
    --     "<cmd>FzfLua command_history<cr>",
    --     desc = "[S]earch [C]ommand History"
    --   },
    --   {
    --     "<leader>sC",
    --     "<cmd>FzfLua commands<cr>",
    --     desc = "[S]earch [C]ommands"
    --   },
    --   {
    --     "<leader>sd",
    --     "<cmd>FzfLua diagnostics_document<cr>",
    --     desc = "[S]earch [D]ocument Diagnostics"
    --   },
    --   {
    --     "<leader>sw",
    --     "<cmd>FzfLua diagnostics_workspace<cr>",
    --     desc = "[S]earch [W]orkspace Diagnostics"
    --   },
    --   {
    --     "<leader>sh",
    --     "<cmd>FzfLua help_tags<cr>",
    --     desc = "[S]earch [H]elp Pages"
    --   },
    --   {
    --     "<leader>sH",
    --     "<cmd>FzfLua highlights<cr>",
    --     desc = "[S]earch [H]ighlight Groups"
    --   },
    --   {
    --     "<leader>sj",
    --     "<cmd>FzfLua jumps<cr>",
    --     desc = "[S]earch [J]umplist"
    --   },
    --   {
    --     "<leader>sk",
    --     "<cmd>FzfLua keymaps<cr>",
    --     desc = "[S]earch [K]ey Maps"
    --   },
    --   {
    --     "<leader>sl",
    --     "<cmd>FzfLua loclist<cr>",
    --     desc = "[S]earch [L]ocation List"
    --   },
    --   {
    --     "<leader>sM",
    --     "<cmd>FzfLua man_pages<cr>",
    --     desc = "[S]earch [M]an Pages"
    --   },
    --   {
    --     "<leader>sm",
    --     "<cmd>FzfLua marks<cr>",
    --     desc = "[S]earch [M]arks"
    --   },
    --   {
    --     "<leader>sR",
    --     "<cmd>FzfLua resume<cr>",
    --     desc = "[S]earch [R]esume"
    --   },
    --   {
    --     "<leader>sq",
    --     "<cmd>FzfLua quickfix<cr>",
    --     desc = "[S]earch [Q]uickfix List"
    --   },
    -- },
  }
}
